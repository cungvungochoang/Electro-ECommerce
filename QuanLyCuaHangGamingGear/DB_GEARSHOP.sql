CREATE DATABASE DB_GEARSHOP;
GO

USE DB_GEARSHOP;
GO

CREATE TABLE NhanVien (
    MaNV INT IDENTITY(1,1) PRIMARY KEY,
    TenNV NVARCHAR(50),
    CCCD NVARCHAR(13),
    DiaChi NVARCHAR(500),
    DienThoai NVARCHAR(11),
    ChucVu NVARCHAR(40),
    MatKhau NVARCHAR(10),
    GhiChu NVARCHAR(100)
);

CREATE TABLE KhachHang (
    MaKH INT IDENTITY(1,1) PRIMARY KEY,
    TenKH NVARCHAR(50),
    DiaChi NVARCHAR(500),
    DienThoai NVARCHAR(11),
    Email NVARCHAR(50),
    MatKhau NVARCHAR(10),
    GhiChu NVARCHAR(100)
);

CREATE TABLE NhaCungCap (
    MaNCC INT IDENTITY(1,1) PRIMARY KEY,
    TenNCC NVARCHAR(50),
    DiaChi NVARCHAR(500),
    DienThoai NVARCHAR(11),
    GhiChu NVARCHAR(100)
);

CREATE TABLE PhieuNhap (
    MaPN INT IDENTITY(1,1) PRIMARY KEY,
    MaNCC INT,
    MaNV INT,
    NgayNhap DATE NOT NULL DEFAULT GETDATE(),
    TongTienPN MONEY DEFAULT 0,
    GhiChu NVARCHAR(100),
    CONSTRAINT FK_PhieuNhap_NhaCungCap FOREIGN KEY (MaNCC) REFERENCES NhaCungCap(MaNCC),
    CONSTRAINT FK_PhieuNhap_NhanVien FOREIGN KEY (MaNV) REFERENCES NhanVien(MaNV)
);

CREATE TABLE LoaiSP (
    MaLoaiSP INT IDENTITY(1,1) PRIMARY KEY,
    TenLoaiSP NVARCHAR(50) CONSTRAINT UNIQUE_TenLoaiSP UNIQUE (TenLoaiSP)
);

CREATE TABLE HangSX (
    MaHangSX INT IDENTITY(1,1) PRIMARY KEY,
    TenHangSX NVARCHAR(50) CONSTRAINT UNIQUE_TenHang UNIQUE (TenHangSX)
);

CREATE TABLE SanPham (
    MaSP INT IDENTITY(1,1) PRIMARY KEY,
    TenSP NVARCHAR(MAX),
    MaLoaiSP INT,
    MaHangSX INT,
    HinhAnh NVARCHAR(MAX),
    GiaSP MONEY DEFAULT 0,
    SoLuong INT,
    MoTa NVARCHAR(MAX),
    CONSTRAINT FK_SanPham_LoaiSP FOREIGN KEY (MaLoaiSP) REFERENCES LoaiSP(MaLoaiSP),
    CONSTRAINT FK_SanPham_HangSX FOREIGN KEY (MaHangSX) REFERENCES HangSX(MaHangSX)
);

CREATE TABLE ChiTietPhieuNhap (
    MaPN INT,
    MaSP INT,
    SoLuongSP INT,
    GiaNhapSP DECIMAL (18, 2) NOT NULL,
    TongTienNhapSP MONEY DEFAULT 0,
    GhiChu NVARCHAR(100),
    CONSTRAINT PK_ChiTietPhieuNhap PRIMARY KEY (MaPN, MaSP),
    CONSTRAINT FK_ChiTietPhieuNhap_PhieuNhap FOREIGN KEY (MaPN) REFERENCES PhieuNhap(MaPN),
    CONSTRAINT FK_ChiTietPhieuNhap_SanPham FOREIGN KEY (MaSP) REFERENCES SanPham(MaSP)
);

CREATE TABLE DonHang (
    MaDH INT IDENTITY(1,1) PRIMARY KEY,
    MaGiaoDich NVARCHAR(15),
    MaSP INT,
    SoLuongSP INT,
    GiaSP DECIMAL (18, 2),
    ThanhTien MONEY DEFAULT 0,
    MaKH INT,
    TenNVPT NVARCHAR(50) NOT NULL,
    GhiChu NVARCHAR(100),
    CONSTRAINT FK_DonHang_KhachHang FOREIGN KEY (MaKH) REFERENCES KhachHang(MaKH),
    CONSTRAINT FK_DonHang_SanPham FOREIGN KEY (MaSP) REFERENCES SanPham(MaSP)
);

--Trigger--
--Tính thành tiền khi nhập liệu vào DonHang--
GO
CREATE TRIGGER ThanhTien_DH ON DonHang
FOR INSERT, UPDATE
AS
	UPDATE DonHang
	SET ThanhTien = (SELECT SoLuongSP * GiaSP)
GO

--Các hành động khi thêm sản phẩm vào ChiTietPhieuNhap--
CREATE TRIGGER Them_CTPN ON ChiTietPhieuNhap
AFTER INSERT
AS
	--Tính tổng tiền nhập của 1 sản phẩm--
	UPDATE ChiTietPhieuNhap
	SET TongTienNhapSP = (SELECT SoLuongSP * GiaNhapSP)

	--Cập nhật số lượng của bảng Sản Phẩm = 0 khi nó == null--
	UPDATE SanPham
	SET SoLuong = 0
	WHERE SoLuong IS NULL

	--Cập nhật lại tổng tiền phiếu nhập của bảng Phiếu Nhập =0 khi nó bằng null--
	UPDATE PhieuNhap
	SET TongTienPN = 0
	WHERE TongTienPN IS NULL

	--Cập nhật số lượng trong bảng Sản Phẩm bằng số lượng hiện tại + số lượng vừa nhập vào ChiTietPhieuNhap(SoLuongSP)
	UPDATE SanPham
	SET SoLuong = SoLuong + (SELECT SoLuongSP FROM inserted)
	WHERE SanPham.MaSP = (SELECT MaSP FROM inserted)

	--Cập nhật tổng tiền phiếu nhập bằng tổng tiền hiện tại + tiền vừa nhập vào ChiTietPhieuNhap--
	UPDATE PhieuNhap
	SET TongTienPN = TongTienPN + (SELECT SoLuongSP * GiaNhapSP FROM inserted)
	WHERE PhieuNhap.MaPN = (SELECT MaPN FROM inserted)
GO

--Các hành động khi xóa sản phẩm khỏi ChiTietPhieuNhap--
CREATE TRIGGER Xoa_CTPN ON ChiTietPhieuNhap
FOR DELETE
AS
	--Cập nhật số lượng của bảng Sản Phẩm = 0 khi nó == null--
	UPDATE SanPham
	SET SoLuong = 0
	WHERE SoLuong IS NULL

	--Cập nhật lại tổng tiền phiếu nhập của bảng Phiếu Nhập =0 khi nó bằng null--
	UPDATE PhieuNhap
	SET TongTienPN = 0
	WHERE TongTienPN IS NULL

	--Cập nhật số lượng trong bảng Sản Phẩm bằng số lượng hiện tại - số lượng vừa nhập vào ChiTietPhieuNhap(SoLuongSP)
	UPDATE SanPham 
	SET SoLuong = SoLuong - (SELECT SUM(SoLuongSP) FROM deleted)
	WHERE SanPham.MaSP = (SELECT MaSP FROM deleted)

	--Cập nhật tổng tiền phiếu nhập bằng tổng tiền hiện tại - tiền vừa nhập vào ChiTietPhieuNhap--
	UPDATE PhieuNhap
	SET TongTienPN = TongTienPN - (SELECT SoLuongSP * GiaNhapSP FROM deleted)
	WHERE PhieuNhap.MaPN = (SELECT MaPN FROM deleted)
GO

--Cập nhật số lượng mua của mỗi sản phẩm khi chọn giống nhau trong bảng DonHang--
CREATE TRIGGER CN_SLSP_DonHang ON DonHang
AFTER INSERT
AS
	/*Sau khi nhập 1 dòng dữ liệu nếu xuất hiện trên 1 dòng dữ liệu giống nhau*/
	/*Trigger sẽ Update soluongSP của DonHang có masp và magiaodich giống với masp và magiaodich vừa nhập*/
	IF(SELECT COUNT(*) FROM DonHang WHERE MaSP = (SELECT MaSP FROM inserted) and MaGiaoDich = (SELECT MaGiaoDich FROM inserted)) > 1
		UPDATE DonHang
		SET SoLuongSP = SoLuongSP + (SELECT SoLuongSP FROM inserted) --SoLuongPS ?--
		WHERE MaSP = (SELECT MaSP FROM inserted) AND MaGiaoDich = (SELECT MaGiaoDich FROM inserted)
	--Xóa những dòng đơn hàng trùng--
	DELETE FROM DonHang
	WHERE MaDH IN (SELECT TOP((SELECT COUNT(*) FROM DonHang WHERE MaSP = (SELECT MaSP FROM inserted) and MaGiaoDich = (SELECT MaGiaoDich FROM inserted)) - 1) MaDH
	FROM DonHang
	WHERE MaDH = (SELECT MaSP FROM inserted) AND MaGiaoDich = (SELECT MaGiaoDich FROM inserted) ORDER BY SoLuongSP) --SoLuongSP ?--
GO

--Show tất cả các trigger đã chạy trên database--
SELECT 
    name AS TriggerName,
    OBJECT_NAME(parent_id) AS TableName,
    create_date AS CreatedDate
FROM 
    sys.triggers;


--Procedure--

--PhieuNhap vs ChiTietPhieuNhap--

--Thủ tục khi thêm dữ liệu vào ChiTietPhieuNhap--
GO
CREATE PROC PRO_Them_CTPN @mapn int, @masp int, @slsp int, @gnsp money
AS
	INSERT INTO ChiTietPhieuNhap(MaPN, MaSP, SoLuongSP, GiaNhapSP)
	VALUES (@mapn, @masp, @slsp, @gnsp)
GO


--Thủ tục thêm phiếu nhập--
CREATE PROC PRO_Them_PN @mapn int, @mancc int, @manv int
AS
	INSERT INTO PhieuNhap(MaPN, MaNCC, MaNV)
	VALUES(@mapn, @mancc, @manv)
GO

--Thủ tục xóa phiếu nhập--
CREATE PROC PRO_Xoa_PN @mapn int
AS
	DELETE FROM ChiTietPhieuNhap WHERE MaPN = @mapn
	DELETE FROM PhieuNhap WHERE MaPN = @mapn
GO

--Thủ tục xóa chi tiết phiếu nhập--
CREATE PROC PRO_Xoa_CTPN @mapn int, @masp int
AS
	DELETE FROM ChiTietPhieuNhap WHERE MaPN = @mapn AND MaSP = @masp
GO

--SanPham--
--Thủ tục sửa sản phẩm--
CREATE PROC PRO_Sua_SP @masp int, @tensp nvarchar(50), @mlsp int, @mhsx int, @hinhanh nvarchar(max), @sl int, @gsp money
AS
	UPDATE SanPham
	SET TenSP = @tensp, MaLoaiSP = @mlsp, MaHangSX = @mhsx, SoLuong = @sl
	WHERE MaSP = @masp

	UPDATE DonHang
	SET GiaSP = @gsp
	WHERE masp = @masp
GO

--Thủ tục xóa sản phẩm--
CREATE PROC PRO_Xoa_SP @masp int
AS
	If (SELECT COUNT(*) FROM ChiTietPhieuNhap WHERE MaSP = @masp) > 0
		COMMIT TRAN
	Else
		DELETE FROM DonHang WHERE MaSP = @masp
		DELETE FROM SanPham WHERE MaSP = @masp
GO

--Show bill (chi tiết những sản phẩm đã chọn mua)--
CREATE PROC PRO_ShowBill @magiaodich nvarchar(15)
AS
	If (SELECT TOP(1) MaKH FROM DonHang WHERE MaGiaoDich LIKE @magiaodich) IS NULL
		SELECT DISTINCT MaDH, dh.MaSP, TenSP, SoLuongSP, dh.GiaSP, ThanhTien, 'tenkh' = NULL, TenNVPT
		FROM DonHang dh, KhachHang kh, SanPham sp
		WHERE sp.MaSP = dh.MaSP AND MaGiaoDich LIKE @magiaodich
	Else
		SELECT MaDH, dh.MaSP, TenSP, SoLuongSP, dh.GiaSP, ThanhTien,kh.TenKH, TenNVPT
		FROM DonHang dh, KhachHang kh, SanPham sp
		WHERE kh.MaKH = dh.MaKH AND sp.MaSP = dh.MaSP AND MaGiaoDich LIKE @magiaodich
GO


SET DATEFORMAT DMY

--Nhập khách hàng--

--INSERT INTO KhachHang
--VALUES('Ho Duc Dat','123/5 Duong so 3, Phuong 16, Quan Go Vap, TP HCM','0978063224','dat@gmail.com','123','')
--INSERT INTO KhachHang
--VALUES('Hoang Minh Long','12/1 Duong so 8, Phuong 11, Quan Tan Binh, TP HCM','898220281','long@gmail.com','123','')
--INSERT INTO KhachHang
--VALUES('Pham Van Huy','23/4 Duong so 7, Phuong 9, Quan 5, TP HCM','322354343','huy@gmail.com','123','')
--INSERT INTO KhachHang
--VALUES('Nguyen Huu Nam','45/6 Duong so 5, Phuong 15, Quan 10, TP HCM','991876499','nam@gmail.com','123','')
--INSERT INTO KhachHang
--VALUES('Nguyen Thi Hong Hanh','67/8 Duong so 2, Phuong 12, Quan Binh Thanh, TP HCM','700796964','hanh@gmail.com','123','')
--INSERT INTO KhachHang
--VALUES('Tran Thi Thanh Tam','89/10 Đuong so 1, Phuong 14, Quan 3','897765807','tam@gmail.com','123','')

----Nhập nhân viên--
--INSERT INTO NhanVien
--VALUES('Vu Ngoc Hoang Cung','772543760869','123 Nguyen Van A, Quan 1, TP HCM','0987654321','NV Kho','123','')
--INSERT INTO NhanVien
--VALUES('Truong Canh Truong','653905866946','456 Le Loi, Quan 3, TP HCM','0903123456','NV Ki thuat','123','')
--INSERT INTO NhanVien
--VALUES('Vo Nguyen Thanh Nhan','987563210987','789 Dien Bien Phu, Quan Binh Thanh, TP HCM','0978234567','NV Kho','123','')
--INSERT INTO NhanVien
--VALUES('Nguyen Thi Nga','345678901234','101 Le Van Si, Quan Tan Binh, TP HCM','0912345678','NV Ban hang','123','')
--INSERT INTO NhanVien
--VALUES('Pham Thi Thanh Thuong','876543210987','202 Hoang Dieu, Quan 5, TPHCM','0967890123','NV Ban hang','123','')


--Nhập nhà cung cấp--
INSERT INTO NhaCungCap
VALUES('ZADEZ Vietnam Company Limited','37 Ton Duc Thang, Quan 1 TP.HCM','307995333','Note'),
	  ('KT Computer','725/99 Truong Chinh, Phuong Tay Thanh TP.HCM','768384159','Note'),
	  ('Minh Tien Company Limited','469 Ton Duc Thang, Phuong Hoa Khanh Nam, quan Lien Chieu TP.Da Nang','307995333','Note'),
	  ('An Phat Computer','158 160 Ly Thuong Kiet, Phuong 14, Quan 10 TP.HCM','0917948081','Note'),
	  ('SPC Computer',' 658/21 Cach Mang Thang Tam, Phuong 11, Quan 3, TP.HCM','996552650','Note')

--Nhập loại sản phẩm--
INSERT INTO LoaiSP
VALUES('Bàn phím'),
	  ('Chuột'),
	  ('Tai nghe'),
	  ('Tay cầm'),
	  ('Webcam'),
	  ('Giá đỡ'),
	  ('Box SSD'),
	  ('Loa')

--Nhập hãng sản xuất--
INSERT INTO HangSX
VALUES('LOGITECH'),
	  ('CORSAIR'),
	  ('E-DRA'),
	  ('COOLER MASTER'),
	  ('RAZER'),
	  ('STEELSERIES'),
	  ('HUMAN MOTION'),
	  ('HYPERWORK'),
	  ('EDIFIER'),
	  ('AKKO'),
	  ('ASUS'),
	  ('ORICO'),
	  ('HYPERX')

--Nhập phiếu nhập edit trong bảng ko viết lệnh--


--Nhập sản phẩm--

GO
SET IDENTITY_INSERT [dbo].[SanPham] ON 
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (1, N'Razer Ornata V3 Pro Black TKL', 1, 5, 'https://product.hstatic.net/200000722513/product/2_acefa2f6b4d4424383e15f0cd872452a_grande.jpg', 15900.0000, 0, N'Hãng sản xuất: Razer\r\nTình trạng: Mới\r\nBảo hành: 24 Tháng\r\nSwitch: Razer Mechanical Green\r\nKết nối: Cáp Type C có thể tháo rời')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (2, N'Razer BlackWidow V4 Pro Black', 1, 5, 'https://product.hstatic.net/200000722513/product/2_0d44b2aba78a4de4b8a0dc4cd7c8eb66_grande.jpg', 54900.0000, 0, N'Hãng sản xuất: Razer\r\nTình trạng: Mới\r\nBảo hành: 24 Tháng\r\nSwitch: Razer Mechanical Green\r\nKết nối: Cáp Type C có thể tháo rời')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (3, N'Razer Huntsman Mini Mercury', 1, 5, 'https://product.hstatic.net/200000722513/product/tv5e718m_6525a8330e574db193a84f18eb0f8670_grande.png', 30900.0000, 0, N'Hãng sản xuất: Razer\r\nTình trạng: Mới\r\nBảo hành: 24 Tháng\r\nSwitch: Razer Mechanical Green\r\nKết nối: Cáp Type C có thể tháo rời')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (4, N'Razer BlackWidow V3 Merry', 1, 5, 'https://product.hstatic.net/200000722513/product/m-razer-blackwidow-v3-mini-hyperspeed_7a9ece3408f142cb9d95b100ff845eda_6cac2ff3ce9249119877ff30108c75cc_grande.png', 25900.0000, 0, N'Hãng sản xuất: Razer\r\nTình trạng: Mới\r\nBảo hành: 24 Tháng\r\nSwitch: Razer Mechanical Green\r\nKết nối: Cáp Type C có thể tháo rời')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (5, N'Razer V4 Blackwidow Yellow Switch', 1, 5, 'https://product.hstatic.net/200000722513/product/phim_6c19f3491c624a93acecf707c68a9cd8_137391e150d54883a044e69479533a20_039fa00aaffc4cf69d81fc1c7d102537_medium.png', 45900.0000, 0, N'Hãng sản xuất: Razer\r\nTình trạng: Mới\r\nBảo hành: 24 Tháng\r\nSwitch: Razer Mechanical Green\r\nKết nối: Cáp Type C có thể tháo rời')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (6, N'Razer Huntsman V2 Linear Optical', 1, 5, 'https://product.hstatic.net/200000722513/product/tv5e718m_6525a8330e574db193a84f18eb0f8670_medium.png', 62900.0000, 0, N'Hãng sản xuất: Razer\r\nTình trạng: Mới\r\nBảo hành: 24 Tháng\r\nSwitch: Razer Mechanical Green\r\nKết nối: Cáp Type C có thể tháo rời')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (7, N'Razer Ornata V3 TKL Optimal', 1, 5, 'https://product.hstatic.net/200000722513/product/thumbphim_a43ec31d5f664ac6916739a9d07e784d_58977386013540cb90e2b6d01d793765_medium.png', 17900.0000, 0, N'Hãng sản xuất: Razer\r\nTình trạng: Mới\r\nBảo hành: 24 Tháng\r\nSwitch: Razer Mechanical Green\r\nKết nối: Cáp Type C có thể tháo rời')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (8, N'Razer Huntsman V2 Tenkeyless', 1, 5, 'https://product.hstatic.net/200000722513/product/ss-4_efd60f06126047679a8d70f6748827dc_deff31fbe1aa47b8b1c57e2f57132216_aeee5e8c5f654d9599850a2f7ad134d4_medium.jpg', 35900.0000, 0, N'Hãng sản xuất: Razer\r\nTình trạng: Mới\r\nBảo hành: 24 Tháng\r\nSwitch: Razer Mechanical Green\r\nKết nối: Cáp Type C có thể tháo rời')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (9, N'Razer Barracuda X 2022 Quart', 3, 5, 'https://product.hstatic.net/200000722513/product/hinh-1_ef0f3da93df44ee98a711e72a502bfa0_40d4fed11ca94cacadfe8ad44bdea27d_medium.jpg', 23900.0000, 0, N'Hãng sản xuất: Razer\r\nTình trạng: Mới\r\nBảo hành: 24 Tháng\r\nSwitch: Razer Mechanical Green\r\nKết nối: Cáp Type C có thể tháo rời')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (10, N'Razer Kraken BT Headset Rabbit', 3, 5,'https://m.media-amazon.com/images/I/71RvZp8e3CL.jpg', 26900.0000, 0, N'Hãng sản xuất: Razer\r\nTình trạng: Mới\r\nBảo hành: 24 Tháng\r\nSwitch: Razer Mechanical Green\r\nKết nối: Cáp Type C có thể tháo rời')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (11, N'Razer Barracuda Pro Black', 3, 5, 'https://product.hstatic.net/200000722513/product/thumbtainghe_78bafb230e9241fb839ad1e00c05b3e0_9638209884984e91995acb360c4628bb_medium.png', 64900.0000, 0, N'Hãng sản xuất: Razer\r\nTình trạng: Mới\r\nBảo hành: 24 Tháng\r\nSwitch: Razer Mechanical Green\r\nKết nối: Cáp Type C có thể tháo rời')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (12, N'Razer Kaira X for Playstation', 3, 5,'https://nvs.tn-cdn.net/2022/10/tai-nghe-razer-kaira-x-for-playstation-2.jpg', 169000.0000, 0, N'Hãng sản xuất: Razer\r\nTình trạng: Mới\r\nBảo hành: 24 Tháng\r\nSwitch: Razer Mechanical Green\r\nKết nối: Cáp Type C có thể tháo rời')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (13, N'Razer Kraken V3 HyperSense', 3, 5, 'https://product.hstatic.net/200000722513/product/ezgif-3-2a102e266ba9_15326bef447c473eb07d61b0e843d206_5771f81db9cb441cbc3698ac0e24f888_medium.png', 26900.0000, 0, N'Hãng sản xuất: Razer\r\nTình trạng: Mới\r\nBảo hành: 24 Tháng\r\nSwitch: Razer Mechanical Green\r\nKết nối: Cáp Type C có thể tháo rời')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (14, N'Razer Kraken V3 X USB Black', 3, 5, 'https://product.hstatic.net/200000722513/product/ezgif-3-2a102e266ba9_15326bef447c473eb07d61b0e843d206_5771f81db9cb441cbc3698ac0e24f888_grande.png', 11900.0000, 0, N'Hãng sản xuất: Razer\r\nTình trạng: Mới\r\nBảo hành: 24 Tháng\r\nSwitch: Razer Mechanical Green\r\nKết nối: Cáp Type C có thể tháo rời')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (15, N'Razer Hammerhead True Wireless Pro', 3, 5, 'https://product.hstatic.net/200000722513/product/1603714990639_5b3addd2047e4ac0ab1cc6d9efcb5d41_225c8f69208349a59a284532cc1ea678_medium.jpg', 48900.0000, 0, N'Hãng sản xuất: Razer\r\nTình trạng: Mới\r\nBảo hành: 24 Tháng\r\nSwitch: Razer Mechanical Green\r\nKết nối: Cáp Type C có thể tháo rời')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (16, N'Razer Basilisk V3 Black Sukai', 2, 5, 'https://product.hstatic.net/200000722513/product/rtehosjd_7cf8331e76c04cb59e02a8f763ae3bb8_grande.png', 9390.0000, 0, N'Hãng sản xuất: Razer\r\nTình trạng: Mới\r\nBảo hành: 24 Tháng\r\nSwitch: Razer Mechanical Green\r\nKết nối: Cáp Type C có thể tháo rời')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (17, N'Razer Basilisk V3 Pro Black  ', 2, 5, 'https://product.hstatic.net/200000722513/product/thumb_thumb_11_617e7fa251fa4690ae7948ec28aea888_grande.jpg', 39900.0000, 0, N'Hãng sản xuất: Razer\r\nTình trạng: Mới\r\nBảo hành: 24 Tháng\r\nSwitch: Razer Mechanical Green\r\nKết nối: Cáp Type C có thể tháo rời')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (18, N'Basilisk V3 X HyperSpeed Black', 2, 5, 'https://product.hstatic.net/200000722513/product/1532069345-4326-600x394_c563b34006924e788c065b0e47ce06e6_93d044d502b14010ad34ed5bdd80417c_grande.png', 13900.0000, 0, N'Hãng sản xuất: Razer\r\nTình trạng: Mới\r\nBảo hành: 24 Tháng\r\nSwitch: Razer Mechanical Green\r\nKết nối: Cáp Type C có thể tháo rời')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (19, N'Razer Orochi V2 Pro Wireless', 2, 5, 'https://product.hstatic.net/200000722513/product/1_bd86b5d5cdac43fa9acb2f95b4bdd800_grande.jpg', 9590.0000, 0, N'Hãng sản xuất: Razer\r\nTình trạng: Mới\r\nBảo hành: 24 Tháng\r\nSwitch: Razer Mechanical Green\r\nKết nối: Cáp Type C có thể tháo rời')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (20, N'Razer Cobra Pro Black Wire', 2, 5, 'https://product.hstatic.net/200000722513/product/1-2_d48628cb79b3407cbc7b5c8e81c9db08_grande.png', 33900.0000, 0, N'Hãng sản xuất: Razer\r\nTình trạng: Mới\r\nBảo hành: 24 Tháng\r\nSwitch: Razer Mechanical Green\r\nKết nối: Cáp Type C có thể tháo rời')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (21, N'Razer Cobra V3 Pro Black Wire', 2, 5, 'https://product.hstatic.net/200000722513/product/1_4944caaca4a941a7b730a314ff40516a_grande.jpg', 9900.0000, 0, N'Hãng sản xuất: Razer\r\nTình trạng: Mới\r\nBảo hành: 24 Tháng\r\nSwitch: Razer Mechanical Green\r\nKết nối: Cáp Type C có thể tháo rời')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (22, N'Razer Basilisk V3 Pro White', 2, 5, 'https://product.hstatic.net/200000722513/product/thumbchuot-recovered_44dcc374ea4d40e9bfaa4fa0d086f62f_c213a6395356408aae12d54abc6ff8ee_grande.gif', 34900.0000, 0, N'Hãng sản xuất: Razer\r\nTình trạng: Mới\r\nBảo hành: 24 Tháng\r\nSwitch: Razer Mechanical Green\r\nKết nối: Cáp Type C có thể tháo rời')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (23, N'Razer Pro Click White Wireless', 2, 5, 'https://product.hstatic.net/200000722513/product/565656_22914bb589c146e599cb381f2c75b557_e6b08a36816248339bcf29ca71560fcb_grande.png', 23900.0000, 0, N'Hãng sản xuất: Razer\r\nTình trạng: Mới\r\nBảo hành: 24 Tháng\r\nSwitch: Razer Mechanical Green\r\nKết nối: Cáp Type C có thể tháo rời')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (24, N'HyperX Cloud III Wireless Black', 3, 13, 'https://product.hstatic.net/200000722513/product/q0wcp8h5_955f4a8d44b14005a4be5f6ecdb1f429_grande.png', 38900.0000, 0, N'Hãng sản xuất : HP HyperX\r\nTình trạng : 100%\r\nBảo hành : 24 tháng')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (25, N'HyperX Cloud III Wireless Red', 3, 13, 'https://product.hstatic.net/200000722513/product/hinh-1_3b11da8a826f404f886613107278b85e_a86a5f556b154780a4c98035f4e22a68_grande.gif', 38900.0000, 0, N'Hãng sản xuất : HP HyperX\r\nTình trạng : 100%\r\nBảo hành : 24 tháng')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (26, N'HyperX Cloud Earbuds II Red', 3, 13, 'https://product.hstatic.net/200000722513/product/hinh_f79a47228bed4171bec6eed36db726c3_4dbc10328d744db680b62b38755bf952_medium.gif', 8900.0000, 0, N'Hãng sản xuất : HP HyperX\r\nTình trạng : 100%\r\nBảo hành : 24 tháng')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (27, N'HyperX Cloud Earbuds II Black', 3, 13, 'https://product.hstatic.net/200000722513/product/hx-features-cloud-core-wireless_70150d6fc8b84627ad8f59a875a66d79_9b412bd5d9794286a8484bdefde44883_medium.jpg', 9900.0000, 0, N'Hãng sản xuất : HP HyperX\r\nTình trạng : 100%\r\nBảo hành : 24 tháng')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (28, N'HyperX Alloy Origins 65 Aqua', 1, 13, 'https://product.hstatic.net/200000722513/product/phim_5c97d99218bc4fa2885f32ea86c12a35_26d35a65271f4a8f91433fbdd7265f5b_6f5550b93ee84624a75d1637aa3c2562_medium.png', 22900.0000, 0, N'Hãng sản xuất : HP HyperX\r\nTình trạng : 100%\r\nBảo hành : 24 tháng')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (29, N'HyperX Alloy Core RGB Black', 1, 13, 'https://product.hstatic.net/200000722513/product/phim_5c97d99218bc4fa2885f32ea86c12a35_26d35a65271f4a8f91433fbdd7265f5b_7506c559e1c548b9905cb43561cc73ec_medium.png', 9900.0000, 0, N'Hãng sản xuất : HP HyperX\r\nTình trạng : 100%\r\nBảo hành : 24 tháng')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (32, N'HyperX Pulsefire Haste Black II', 2, 13, 'https://product.hstatic.net/200000637319/product/ezgif-1-c39a8ed822_1dc8d7718aee421096b93b6b01e0569c_master.png', 10900.0000, 0, N'Hãng sản xuất : HP HyperX\r\nTình trạng : 100%\r\nBảo hành : 24 tháng')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (33, N'HyperX Pulsefire Raid RGB Black', 2, 13, 'https://product.hstatic.net/200000722513/product/n-chuot-hyperx-pulsefire-raid-rgb-666_420b096a12ec4088828930f9fd2c6a0d_849def6221244467833f54831514e2a5_1024x1024.jpg', 20900.0000, 0, N'Hãng sản xuất : HP HyperX\r\nTình trạng : 100%\r\nBảo hành : 24 tháng')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (34, N'HyperX PulseFire FPS Core', 2, 13, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSQGKzfiVv7BwHK3gcb3rLFqyjTKiOMWLj5rA&s', 6900.0000, 0, N'Hãng sản xuất : HP HyperX\r\nTình trạng : 100%\r\nBảo hành : 24 tháng')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (35, N'Hyperx Pulsefire FPS Pro RGB', 2, 13, 'https://row.hyperx.com/cdn/shop/products/hyperx_pulsefire_fps_pro_1_top_down.jpg?v=1662449658', 7900.0000, 0, N'Hãng sản xuất : HP HyperX\r\nTình trạng : 100%\r\nBảo hành : 24 tháng')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (36, N'Logitech G435 Wireless Raspherry', 3, 1, 'https://file.hstatic.net/1000026716/file/gearvn-tai-nghe-logitech-g435-lightspeed-wireless-blue-raspberry-1_8414fa497ef04e528262157fc1d8f75d_grande.jpg', 13290.0000, 0, N'Hãng sản xuất : Logitech\r\nTình trạng : 100%\r\nBảo hành : 24 tháng')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (37, N'Logitech G Pro Gen 2 Black', 3, 1, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcThsuJrhS-PArYfGZXVPQIW6qroTquLtevZYA&s', 16900.0000, 0, N'Hãng sản xuất : Logitech\r\nTình trạng : 100%\r\nBảo hành : 24 tháng')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (38, N'Logitech G733 LIGHTSPEED Wireless', 3, 1, 'https://product.hstatic.net/200000722513/product/ch-g733-lightspeed-wireless-black-666_2eb1a71d562e4a6d853a0f086723cbe3_f7f15fa3c25c4d6190c05c6db168fbf7_1024x1024.png', 22900.0000, 0, N'Hãng sản xuất : Logitech\r\nTình trạng : 100%\r\nBảo hành : 24 tháng')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (39, N'Logitech G Pro X Language of Legend', 3, 1, 'https://product.hstatic.net/200000722513/product/-logitech-g-pro-x-league-of-legends-1_08089aaa82c24a4e8c129455be552215_01b21f867ea041c7823b112b641de333_grande.jpg', 27000.0000, 0, N'Hãng sản xuất : Logitech\r\nTình trạng : 100%\r\nBảo hành : 24 tháng')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (40, N'Logitech G512 GX RGB Tactile', 1, 1, 'https://product.hstatic.net/200000722513/product/rgb-gx-blue-clicky-switch-full-size-2_bd94ff3a617f4c958e65e67d04852d5e_5e7fbaa8025549b8a44a004847990b25_1024x1024.jpg', 18900.0000, 0, N'Hãng sản xuất : Logitech\r\nTình trạng : 100%\r\nBảo hành : 24 tháng')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (41, N'Logitech G Pro X TKL Light Speed', 1, 1, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSjpwqDJcMD8DBQHaQsaduvP7oWNR5qdC2MEA&s', 47900.0000, 0, N'Hãng sản xuất : Logitech\r\nTình trạng : 100%\r\nBảo hành : 24 tháng')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (42, N'Logitech K380 Almond Milk', 1, 1, 'https://file.hstatic.net/1000026716/file/gearvn-ban-phim-bluetooth-logitech-k380-almond-milk_932d885f921f485eacd236f0a4112491_grande.jpg', 6900.0000, 0, N'Hãng sản xuất : Logitech\r\nTình trạng : 100%\r\nBảo hành : 24 tháng')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (43, N'Logitech G213 RGB Pro Black', 1, 1, 'https://www.tnc.com.vn/uploads/product/gallery/G123.jpg', 9900.0000, 0, N'Hãng sản xuất : Logitech\r\nTình trạng : 100%\r\nBảo hành : 24 tháng')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (44, N'Logitech G102 LightSync Black', 2, 1, 'https://product.hstatic.net/200000722513/product/logitech-g102-lightsync-rgb-black-1_bf4f5774229c4a0f81b8e8a2feebe4d8_aeb4ae49ee844c3e9d315883d4e482d4_1024x1024.jpg', 3990.0000, 0, N'Hãng sản xuất : Logitech\r\nTình trạng : 100%\r\nBảo hành : 24 tháng')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (45, N'Logitech G304 Wireless White', 2, 1, 'https://product.hstatic.net/200000722513/product/ch-g304-lightspeed-wireless-white-777_4f35661f87af49b2b7f9a0870a174ea7_b6fb9848292c44d59247da75dbe986d9_1024x1024.jpg', 7800.0000, 0, N'Hãng sản xuất : Logitech\r\nTình trạng : 100%\r\nBảo hành : 24 tháng')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (46, N'Logitech G502 Hero Gaming', 2, 1, 'https://file.hstatic.net/1000026716/file/gearvn-logitech-g502-hero_6d2cc5be9b964b89ad423f8123cf357e.jpg', 9500.0000, 0, N'Hãng sản xuất : Logitech\r\nTình trạng : 100%\r\nBảo hành : 24 tháng')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (47, N'Logitech G Pro X Spl 2 Magenta', 2, 1, 'https://product.hstatic.net/200000722513/product/6_cc9e6a9210494554aed0ed8cbb6f8a5a_1024x1024.jpg', 30900.0000, 0, N'Hãng sản xuất : Logitech\r\nTình trạng : 100%\r\nBảo hành : 24 tháng')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (48, N'Steelseries Arctis Nova 1', 3, 6, 'https://product.hstatic.net/200000722513/product/thumbtainghe-recovered_98cd6388269344c8a5a051edc3609aef_cc8120e49835498aae344671b8018378.gif', 54900.0000, 0, N'Hãng sản xuất : Steelseries\r\nTình trạng : 100%\r\nBảo hành : 24 tháng')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (49, N'Steelseries Arctis Nova 7', 3, 6, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRN5xDoqI1kf-ipWD44Cl83xzfB2x0L7kQOYw&s', 17900.0000, 0, N'Hãng sản xuất : Steelseries\r\nTình trạng : 100%\r\nBảo hành : 24 tháng')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (50, N'Steelseries TUSQ', 3, 6, 'https://file.hstatic.net/200000281563/file/tusq_004__1__e543e12c5c2f42678ed577737f1df344_1024x1024.jpg', 29500.0000, 0, N'Hãng sản xuất : Steelseries\r\nTình trạng : 100%\r\nBảo hành : 24 tháng')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (51, N'Steelseries Arctis PRO GAMEDAC', 3, 6, 'https://product.hstatic.net/200000722513/product/gearvn_arctisprodac_0_e4fb2dfacfc54bffa0ca707cf0e7a3bf.jpg', 49900.0000, 0, N'Hãng sản xuất : Steelseries\r\nTình trạng : 100%\r\nBảo hành : 24 tháng')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (52, N'Steelseries Apex 9 MINI', 1, 6, 'https://product.hstatic.net/200000637319/product/azaudio-steelseries-apex-9-mini_6925370fe20c47769a1e027a6bba01c5_grande.jpg', 16400.0000, 0, N'Hãng sản xuất : Steelseries\r\nTình trạng : 100%\r\nBảo hành : 24 tháng')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (53, N'Steelseries Apex 7 TKL GHOST', 1, 6, 'https://media.steelseriescdn.com/thumbs/filer_public/67/c0/67c0cc44-9bd0-46e0-9578-d91a85ce5143/m_feature_apex7_tkl_ghost_prismcaps.jpg__540x540_q100_crop-scale_optimize_subsampling-2.webp', 13900.0000, 0, N'Hãng sản xuất : Steelseries\r\nTình trạng : 100%\r\nBảo hành : 24 tháng')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (54, N'Steelseries Apex PRO MINI WIRELESS', 1, 6, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSilo_bAV3m-D0I5KBoCWskL0vRWxIQZCBxwQ&s', 28800.0000, 0, N'Hãng sản xuất : Steelseries\r\nTình trạng : 100%\r\nBảo hành : 24 tháng')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (55, N'Steelseries Apex 9 TKL', 1, 6, 'https://product.hstatic.net/200000637319/product/h3__1__f4b156d7cfc34d28851ac3215cc39afd_master.png', 36900.0000, 0, N'Hãng sản xuất : Steelseries\r\nTình trạng : 100%\r\nBảo hành : 24 tháng')
SET IDENTITY_INSERT [dbo].[SanPham] OFF


DELETE FROM SanPham



--Nhập chi tiết phiếu nhập--
--INSERT INTO ChiTietPhieuNhap
--VALUES('1','15',15,30000,NULL,NULL),
--	  ('1','18',15,10000,NULL,NULL)
