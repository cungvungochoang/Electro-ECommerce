USE [DB_GEARSHOP]
GO
/****** Object:  Table [dbo].[ChiTietPhieuNhap]    Script Date: 12/11/2023 4:14:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChiTietPhieuNhap](
	[MaPN] [int] NOT NULL,
	[MaSP] [int] NOT NULL,
	[SoLuongSP] [int] NULL,
	[GiaNhapSP] [decimal](18, 2) NOT NULL,
	[TongTienNhapSP] [money] NULL,
	[GhiChu] [nvarchar](100) NULL,
 CONSTRAINT [PK_ChiTietPhieuNhap] PRIMARY KEY CLUSTERED 
(
	[MaPN] ASC,
	[MaSP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DonHang]    Script Date: 12/11/2023 4:14:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DonHang](
	[MaDH] [int] IDENTITY(1,1) NOT NULL,
	[MaGiaoDich] [nvarchar](15) NULL,
	[MaSP] [int] NULL,
	[SoLuongSP] [int] NULL,
	[GiaSP] [decimal](18, 2) NULL,
	[ThanhTien] [money] NULL,
	[MaKH] [int] NULL,
	[TenNVPT] [nvarchar](50) NOT NULL,
	[GhiChu] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaDH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HangSX]    Script Date: 12/11/2023 4:14:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HangSX](
	[MaHangSX] [int] IDENTITY(1,1) NOT NULL,
	[TenHangSX] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaHangSX] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KhachHang]    Script Date: 12/11/2023 4:14:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KhachHang](
	[MaKH] [int] IDENTITY(1,1) NOT NULL,
	[TenKH] [nvarchar](50) NULL,
	[DiaChi] [nvarchar](500) NULL,
	[DienThoai] [nvarchar](11) NULL,
	[Email] [nvarchar](50) NULL,
	[MatKhau] [nvarchar](10) NULL,
	[GhiChu] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaKH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LoaiSP]    Script Date: 12/11/2023 4:14:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoaiSP](
	[MaLoaiSP] [int] IDENTITY(1,1) NOT NULL,
	[TenLoaiSP] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaLoaiSP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NhaCungCap]    Script Date: 12/11/2023 4:14:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NhaCungCap](
	[MaNCC] [int] IDENTITY(1,1) NOT NULL,
	[TenNCC] [nvarchar](50) NULL,
	[DiaChi] [nvarchar](500) NULL,
	[DienThoai] [nvarchar](11) NULL,
	[GhiChu] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaNCC] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NhanVien]    Script Date: 12/11/2023 4:14:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NhanVien](
	[MaNV] [int] IDENTITY(1,1) NOT NULL,
	[TenNV] [nvarchar](50) NULL,
	[CCCD] [nvarchar](13) NULL,
	[DiaChi] [nvarchar](500) NULL,
	[DienThoai] [nvarchar](11) NULL,
	[ChucVu] [nvarchar](40) NULL,
	[MatKhau] [nvarchar](10) NULL,
	[GhiChu] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaNV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PhieuNhap]    Script Date: 12/11/2023 4:14:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PhieuNhap](
	[MaPN] [int] IDENTITY(1,1) NOT NULL,
	[MaNCC] [int] NULL,
	[MaNV] [int] NULL,
	[NgayNhap] [date] NOT NULL,
	[TongTienPN] [money] NULL,
	[GhiChu] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaPN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SanPham]    Script Date: 12/11/2023 4:14:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SanPham](
	[MaSP] [int] IDENTITY(1,1) NOT NULL,
	[TenSP] [nvarchar](max) NULL,
	[MaLoaiSP] [int] NULL,
	[MaHangSX] [int] NULL,
	[HinhAnh] [nvarchar](max) NULL,
	[GiaSP] [money] NULL,
	[SoLuong] [int] NULL,
	[MoTa] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaSP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [dbo].[ChiTietPhieuNhap] ([MaPN], [MaSP], [SoLuongSP], [GiaNhapSP], [TongTienNhapSP], [GhiChu]) VALUES (1, 1, 12, CAST(1000.00 AS Decimal(18, 2)), 12000.0000, NULL)
GO
SET IDENTITY_INSERT [dbo].[HangSX] ON 

INSERT [dbo].[HangSX] ([MaHangSX], [TenHangSX]) VALUES (10, N'AKKO')
INSERT [dbo].[HangSX] ([MaHangSX], [TenHangSX]) VALUES (11, N'ASUS')
INSERT [dbo].[HangSX] ([MaHangSX], [TenHangSX]) VALUES (4, N'COOLER MASTER')
INSERT [dbo].[HangSX] ([MaHangSX], [TenHangSX]) VALUES (2, N'CORSAIR')
INSERT [dbo].[HangSX] ([MaHangSX], [TenHangSX]) VALUES (9, N'EDIFIER')
INSERT [dbo].[HangSX] ([MaHangSX], [TenHangSX]) VALUES (3, N'E-DRA')
INSERT [dbo].[HangSX] ([MaHangSX], [TenHangSX]) VALUES (7, N'HUMAN MOTION')
INSERT [dbo].[HangSX] ([MaHangSX], [TenHangSX]) VALUES (8, N'HYPERWORK')
INSERT [dbo].[HangSX] ([MaHangSX], [TenHangSX]) VALUES (13, N'HYPERX')
INSERT [dbo].[HangSX] ([MaHangSX], [TenHangSX]) VALUES (1, N'LOGITECH')
INSERT [dbo].[HangSX] ([MaHangSX], [TenHangSX]) VALUES (12, N'ORICO')
INSERT [dbo].[HangSX] ([MaHangSX], [TenHangSX]) VALUES (5, N'RAZER')
INSERT [dbo].[HangSX] ([MaHangSX], [TenHangSX]) VALUES (6, N'STEELSERIES')
SET IDENTITY_INSERT [dbo].[HangSX] OFF
GO
SET IDENTITY_INSERT [dbo].[KhachHang] ON 

INSERT [dbo].[KhachHang] ([MaKH], [TenKH], [DiaChi], [DienThoai], [Email], [MatKhau], [GhiChu]) VALUES (1, N'Ho Duc Dat', N'123/5 Duong so 3, Phuong 16, Quan Go Vap, TP HCM', N'0978063224', N'dat@gmail.com', N'123', N'')
INSERT [dbo].[KhachHang] ([MaKH], [TenKH], [DiaChi], [DienThoai], [Email], [MatKhau], [GhiChu]) VALUES (2, N'Hoang Minh Long', N'12/1 Duong so 8, Phuong 11, Quan Tan Binh, TP HCM', N'898220281', N'long@gmail.com', N'123', N'')
INSERT [dbo].[KhachHang] ([MaKH], [TenKH], [DiaChi], [DienThoai], [Email], [MatKhau], [GhiChu]) VALUES (3, N'Pham Van Huy', N'23/4 Duong so 7, Phuong 9, Quan 5, TP HCM', N'322354343', N'huy@gmail.com', N'123', N'')
INSERT [dbo].[KhachHang] ([MaKH], [TenKH], [DiaChi], [DienThoai], [Email], [MatKhau], [GhiChu]) VALUES (4, N'Nguyen Huu Nam', N'45/6 Duong so 5, Phuong 15, Quan 10, TP HCM', N'991876499', N'nam@gmail.com', N'123', N'')
INSERT [dbo].[KhachHang] ([MaKH], [TenKH], [DiaChi], [DienThoai], [Email], [MatKhau], [GhiChu]) VALUES (5, N'Nguyen Thi Hong Hanh', N'67/8 Duong so 2, Phuong 12, Quan Binh Thanh, TP HCM', N'700796964', N'hanh@gmail.com', N'123', N'')
INSERT [dbo].[KhachHang] ([MaKH], [TenKH], [DiaChi], [DienThoai], [Email], [MatKhau], [GhiChu]) VALUES (6, N'Tran Thi Thanh Tam', N'89/10 Ðuong so 1, Phuong 14, Quan 3', N'897765807', N'tam@gmail.com', N'123', N'')
SET IDENTITY_INSERT [dbo].[KhachHang] OFF
GO
SET IDENTITY_INSERT [dbo].[LoaiSP] ON 

INSERT [dbo].[LoaiSP] ([MaLoaiSP], [TenLoaiSP]) VALUES (1, N'Ban phim co')
INSERT [dbo].[LoaiSP] ([MaLoaiSP], [TenLoaiSP]) VALUES (7, N'Box SSD')
INSERT [dbo].[LoaiSP] ([MaLoaiSP], [TenLoaiSP]) VALUES (2, N'Chuot')
INSERT [dbo].[LoaiSP] ([MaLoaiSP], [TenLoaiSP]) VALUES (6, N'Gia do man hinh')
INSERT [dbo].[LoaiSP] ([MaLoaiSP], [TenLoaiSP]) VALUES (8, N'Loa')
INSERT [dbo].[LoaiSP] ([MaLoaiSP], [TenLoaiSP]) VALUES (3, N'Tai nghe')
INSERT [dbo].[LoaiSP] ([MaLoaiSP], [TenLoaiSP]) VALUES (4, N'Tay cam')
INSERT [dbo].[LoaiSP] ([MaLoaiSP], [TenLoaiSP]) VALUES (5, N'Webcam')
SET IDENTITY_INSERT [dbo].[LoaiSP] OFF
GO
SET IDENTITY_INSERT [dbo].[NhaCungCap] ON 

INSERT [dbo].[NhaCungCap] ([MaNCC], [TenNCC], [DiaChi], [DienThoai], [GhiChu]) VALUES (1, N'ZADEZ Vietnam Company Limited', N'37 Ton Duc Thang, Quan 1 TP.HCM', N'307995333', N'Note')
INSERT [dbo].[NhaCungCap] ([MaNCC], [TenNCC], [DiaChi], [DienThoai], [GhiChu]) VALUES (2, N'KT Computer', N'725/99 Truong Chinh, Phuong Tay Thanh TP.HCM', N'768384159', N'Note')
INSERT [dbo].[NhaCungCap] ([MaNCC], [TenNCC], [DiaChi], [DienThoai], [GhiChu]) VALUES (3, N'Minh Tien Company Limited', N'469 Ton Duc Thang, Phuong Hoa Khanh Nam, quan Lien Chieu TP.Da Nang', N'307995333', N'Note')
INSERT [dbo].[NhaCungCap] ([MaNCC], [TenNCC], [DiaChi], [DienThoai], [GhiChu]) VALUES (4, N'An Phat Computer', N'158 160 Ly Thuong Kiet, Phuong 14, Quan 10 TP.HCM', N'0917948081', N'Note')
INSERT [dbo].[NhaCungCap] ([MaNCC], [TenNCC], [DiaChi], [DienThoai], [GhiChu]) VALUES (5, N'SPC Computer', N' 658/21 Cach Mang Thang Tam, Phuong 11, Quan 3, TP.HCM', N'996552650', N'Note')
SET IDENTITY_INSERT [dbo].[NhaCungCap] OFF
GO
SET IDENTITY_INSERT [dbo].[NhanVien] ON 

INSERT [dbo].[NhanVien] ([MaNV], [TenNV], [CCCD], [DiaChi], [DienThoai], [ChucVu], [MatKhau], [GhiChu]) VALUES (1, N'Vu Ngoc Hoang Cung', N'772543760869', N'123 Nguyen Van A, Quan 1, TP HCM', N'0987654321', N'NV Kho', N'123', N'')
INSERT [dbo].[NhanVien] ([MaNV], [TenNV], [CCCD], [DiaChi], [DienThoai], [ChucVu], [MatKhau], [GhiChu]) VALUES (2, N'Truong Canh Truong', N'653905866946', N'456 Le Loi, Quan 3, TP HCM', N'0903123456', N'NV Ki thuat', N'123', N'')
INSERT [dbo].[NhanVien] ([MaNV], [TenNV], [CCCD], [DiaChi], [DienThoai], [ChucVu], [MatKhau], [GhiChu]) VALUES (3, N'Vo Nguyen Thanh Nhan', N'987563210987', N'789 Dien Bien Phu, Quan Binh Thanh, TP HCM', N'0978234567', N'NV Kho', N'123', N'')
INSERT [dbo].[NhanVien] ([MaNV], [TenNV], [CCCD], [DiaChi], [DienThoai], [ChucVu], [MatKhau], [GhiChu]) VALUES (4, N'Nguyen Thi Nga', N'345678901234', N'101 Le Van Si, Quan Tan Binh, TP HCM', N'0912345678', N'NV Ban hang', N'123', N'')
INSERT [dbo].[NhanVien] ([MaNV], [TenNV], [CCCD], [DiaChi], [DienThoai], [ChucVu], [MatKhau], [GhiChu]) VALUES (5, N'Pham Thi Thanh Thuong', N'876543210987', N'202 Hoang Dieu, Quan 5, TPHCM', N'0967890123', N'NV Ban hang', N'123', N'')
SET IDENTITY_INSERT [dbo].[NhanVien] OFF
GO
SET IDENTITY_INSERT [dbo].[PhieuNhap] ON 

INSERT [dbo].[PhieuNhap] ([MaPN], [MaNCC], [MaNV], [NgayNhap], [TongTienPN], [GhiChu]) VALUES (1, 4, 1, CAST(N'2023-12-11' AS Date), 12000.0000, N'PN1')
INSERT [dbo].[PhieuNhap] ([MaPN], [MaNCC], [MaNV], [NgayNhap], [TongTienPN], [GhiChu]) VALUES (2, 2, 1, CAST(N'2023-12-11' AS Date), 0.0000, N'PN2')
INSERT [dbo].[PhieuNhap] ([MaPN], [MaNCC], [MaNV], [NgayNhap], [TongTienPN], [GhiChu]) VALUES (3, 1, 3, CAST(N'2023-12-11' AS Date), 0.0000, N'PN3')
INSERT [dbo].[PhieuNhap] ([MaPN], [MaNCC], [MaNV], [NgayNhap], [TongTienPN], [GhiChu]) VALUES (4, 2, 1, CAST(N'2023-12-11' AS Date), 0.0000, N'PN4')
SET IDENTITY_INSERT [dbo].[PhieuNhap] OFF
GO
SET IDENTITY_INSERT [dbo].[SanPham] ON 

INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (1, N'Razer Ornata V3 Pro Black TKL', 1, 5, N'None', 15900.0000, 12, N'Hãng sản xuất: Razer\r\nTình trạng: Mới\r\nBảo hành: 24 Tháng\r\nSwitch: Razer Mechanical Green\r\nKết nối: Cáp Type C có thể tháo rời')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (2, N'Razer BlackWidow V4 Pro Black', 1, 5, N'None', 54900.0000, 0, N'Hãng sản xuất: Razer\r\nTình trạng: Mới\r\nBảo hành: 24 Tháng\r\nSwitch: Razer Mechanical Green\r\nKết nối: Cáp Type C có thể tháo rời')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (3, N'Razer Huntsman Mini Mercury', 1, 5, N'None', 30900.0000, 0, N'Hãng sản xuất: Razer\r\nTình trạng: Mới\r\nBảo hành: 24 Tháng\r\nSwitch: Razer Mechanical Green\r\nKết nối: Cáp Type C có thể tháo rời')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (4, N'Razer BlackWidow V3  Merry', 1, 5, N'None', 25900.0000, 0, N'Hãng sản xuất: Razer\r\nTình trạng: Mới\r\nBảo hành: 24 Tháng\r\nSwitch: Razer Mechanical Green\r\nKết nối: Cáp Type C có thể tháo rời')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (5, N'Razer V4 Blackwidow Yellow Switch', 1, 5, N'None', 45900.0000, 0, N'Hãng sản xuất: Razer\r\nTình trạng: Mới\r\nBảo hành: 24 Tháng\r\nSwitch: Razer Mechanical Green\r\nKết nối: Cáp Type C có thể tháo rời')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (6, N'Razer Huntsman V2 Linear Optical', 1, 5, N'None', 62900.0000, 0, N'Hãng sản xuất: Razer\r\nTình trạng: Mới\r\nBảo hành: 24 Tháng\r\nSwitch: Razer Mechanical Green\r\nKết nối: Cáp Type C có thể tháo rời')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (7, N'Razer Ornata V3 TKL Optimal', 1, 5, N'None', 17900.0000, 0, N'Hãng sản xuất: Razer\r\nTình trạng: Mới\r\nBảo hành: 24 Tháng\r\nSwitch: Razer Mechanical Green\r\nKết nối: Cáp Type C có thể tháo rời')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (8, N'Razer Huntsman V2 Tenkeyless', 1, 5, N'None', 35900.0000, 0, N'Hãng sản xuất: Razer\r\nTình trạng: Mới\r\nBảo hành: 24 Tháng\r\nSwitch: Razer Mechanical Green\r\nKết nối: Cáp Type C có thể tháo rời')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (9, N'Razer Barracuda X 2022 Quart', 3, 5, N'None', 23900.0000, 0, N'Hãng sản xuất: Razer\r\nTình trạng: Mới\r\nBảo hành: 24 Tháng\r\nSwitch: Razer Mechanical Green\r\nKết nối: Cáp Type C có thể tháo rời')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (10, N'Razer Kraken BT Headset Rabbit', 3, 5, N'None', 26900.0000, 0, N'Hãng sản xuất: Razer\r\nTình trạng: Mới\r\nBảo hành: 24 Tháng\r\nSwitch: Razer Mechanical Green\r\nKết nối: Cáp Type C có thể tháo rời')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (11, N'Razer Barracuda Pro Black', 3, 5, N'None', 64900.0000, 0, N'Hãng sản xuất: Razer\r\nTình trạng: Mới\r\nBảo hành: 24 Tháng\r\nSwitch: Razer Mechanical Green\r\nKết nối: Cáp Type C có thể tháo rời')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (12, N'Razer Kaira X for Playstation', 3, 5, N'None', 169000.0000, 0, N'Hãng sản xuất: Razer\r\nTình trạng: Mới\r\nBảo hành: 24 Tháng\r\nSwitch: Razer Mechanical Green\r\nKết nối: Cáp Type C có thể tháo rời')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (13, N'Razer Kraken V3 HyperSense', 3, 5, N'None', 26900.0000, 0, N'Hãng sản xuất: Razer\r\nTình trạng: Mới\r\nBảo hành: 24 Tháng\r\nSwitch: Razer Mechanical Green\r\nKết nối: Cáp Type C có thể tháo rời')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (14, N'Razer Kraken V3 X USB Black', 3, 5, N'None', 11900.0000, 0, N'Hãng sản xuất: Razer\r\nTình trạng: Mới\r\nBảo hành: 24 Tháng\r\nSwitch: Razer Mechanical Green\r\nKết nối: Cáp Type C có thể tháo rời')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (15, N'Razer Hammerhead True Wireless Pro', 3, 5, N'None', 48900.0000, 0, N'Hãng sản xuất: Razer\r\nTình trạng: Mới\r\nBảo hành: 24 Tháng\r\nSwitch: Razer Mechanical Green\r\nKết nối: Cáp Type C có thể tháo rời')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (16, N'Razer Basilisk V3 Black Sukai', 2, 5, N'None', 9390.0000, 0, N'Hãng sản xuất: Razer\r\nTình trạng: Mới\r\nBảo hành: 24 Tháng\r\nSwitch: Razer Mechanical Green\r\nKết nối: Cáp Type C có thể tháo rời')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (17, N'Razer Basilisk V3 Pro Black  ', 2, 5, N'None', 39900.0000, 0, N'Hãng sản xuất: Razer\r\nTình trạng: Mới\r\nBảo hành: 24 Tháng\r\nSwitch: Razer Mechanical Green\r\nKết nối: Cáp Type C có thể tháo rời')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (18, N'Basilisk V3 X HyperSpeed Black', 2, 5, N'None', 13900.0000, 0, N'Hãng sản xuất: Razer\r\nTình trạng: Mới\r\nBảo hành: 24 Tháng\r\nSwitch: Razer Mechanical Green\r\nKết nối: Cáp Type C có thể tháo rời')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (19, N'Razer Orochi V2 Pro Wireless', 2, 5, N'None', 9590.0000, 0, N'Hãng sản xuất: Razer\r\nTình trạng: Mới\r\nBảo hành: 24 Tháng\r\nSwitch: Razer Mechanical Green\r\nKết nối: Cáp Type C có thể tháo rời')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (20, N'Razer Cobra Pro Black Wire', 2, 5, N'None', 33900.0000, 0, N'Hãng sản xuất: Razer\r\nTình trạng: Mới\r\nBảo hành: 24 Tháng\r\nSwitch: Razer Mechanical Green\r\nKết nối: Cáp Type C có thể tháo rời')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (21, N'Razer Cobra V3 Pro Black Wire', 2, 5, N'None', 9900.0000, 0, N'Hãng sản xuất: Razer\r\nTình trạng: Mới\r\nBảo hành: 24 Tháng\r\nSwitch: Razer Mechanical Green\r\nKết nối: Cáp Type C có thể tháo rời')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (22, N'Razer Basilisk V3 Pro White', 2, 5, N'None', 34900.0000, 0, N'Hãng sản xuất: Razer\r\nTình trạng: Mới\r\nBảo hành: 24 Tháng\r\nSwitch: Razer Mechanical Green\r\nKết nối: Cáp Type C có thể tháo rời')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (23, N'Razer Pro Click White Wireless', 2, 5, N'None', 23900.0000, 0, N'Hãng sản xuất: Razer\r\nTình trạng: Mới\r\nBảo hành: 24 Tháng\r\nSwitch: Razer Mechanical Green\r\nKết nối: Cáp Type C có thể tháo rời')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (24, N'HyperX Cloud III Wireless Black', 3, 13, N'None', 38900.0000, 0, N'Hãng sản xuất : HP HyperX\r\nTình trạng : 100%\r\nBảo hành : 24 tháng')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (25, N'HyperX Cloud III Wireless Red', 3, 13, N'None', 38900.0000, 0, N'Hãng sản xuất : HP HyperX\r\nTình trạng : 100%\r\nBảo hành : 24 tháng')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (26, N'HyperX Cloud Earbuds II Red', 3, 13, N'None', 8900.0000, 0, N'Hãng sản xuất : HP HyperX\r\nTình trạng : 100%\r\nBảo hành : 24 tháng')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (27, N'HyperX Cloud Earbuds II Black', 3, 13, N'None', 9900.0000, 0, N'Hãng sản xuất : HP HyperX\r\nTình trạng : 100%\r\nBảo hành : 24 tháng')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (28, N'HyperX Alloy Origins 65 Aqua', 1, 13, N'None', 22900.0000, 0, N'Hãng sản xuất : HP HyperX\r\nTình trạng : 100%\r\nBảo hành : 24 tháng')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (29, N'HyperX Alloy Core RGB Black', 1, 13, N'None', 9900.0000, 0, N'Hãng sản xuất : HP HyperX\r\nTình trạng : 100%\r\nBảo hành : 24 tháng')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (32, N'HyperX Pulsefire Haste Black II', 2, 13, N'None', 10900.0000, 0, N'Hãng sản xuất : HP HyperX\r\nTình trạng : 100%\r\nBảo hành : 24 tháng')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (33, N'HyperX Pulsefire Raid RGB Black', 2, 13, N'None', 20900.0000, 0, N'Hãng sản xuất : HP HyperX\r\nTình trạng : 100%\r\nBảo hành : 24 tháng')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (34, N'HyperX PulseFire FPS Core', 2, 13, N'None', 6900.0000, 0, N'Hãng sản xuất : HP HyperX\r\nTình trạng : 100%\r\nBảo hành : 24 tháng')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (35, N'Hyperx Pulsefire FPS Pro RGB', 2, 13, N'None', 7900.0000, 0, N'Hãng sản xuất : HP HyperX\r\nTình trạng : 100%\r\nBảo hành : 24 tháng')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (36, N'Logitech G435 Wireless Raspherry', 3, 1, N'None', 13290.0000, 0, N'Hãng sản xuất : Logitech\r\nTình trạng : 100%\r\nBảo hành : 24 tháng')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (37, N'Logitech G Pro Gen 2 Black', 3, 1, N'None', 16900.0000, 0, N'Hãng sản xuất : Logitech\r\nTình trạng : 100%\r\nBảo hành : 24 tháng')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (38, N'Logitech G733 LIGHTSPEED Wireless', 3, 1, N'None', 22900.0000, 0, N'Hãng sản xuất : Logitech\r\nTình trạng : 100%\r\nBảo hành : 24 tháng')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (39, N'Logitech G Pro X Language of Legend', 3, 1, N'None', 27000.0000, 0, N'Hãng sản xuất : Logitech\r\nTình trạng : 100%\r\nBảo hành : 24 tháng')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (40, N'Logitech G512 GX RGB Tactile', 1, 1, N'None', 18900.0000, 0, N'Hãng sản xuất : Logitech\r\nTình trạng : 100%\r\nBảo hành : 24 tháng')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (41, N'Logitech G Pro X TKL Light Speed', 1, 1, N'None', 47900.0000, 0, N'Hãng sản xuất : Logitech\r\nTình trạng : 100%\r\nBảo hành : 24 tháng')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (42, N'Logitech K380 Almond Milk', 1, 1, N'None', 6900.0000, 0, N'Hãng sản xuất : Logitech\r\nTình trạng : 100%\r\nBảo hành : 24 tháng')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (43, N'Logitech G213 RGB Pro Black', 1, 1, N'None', 9900.0000, 0, N'Hãng sản xuất : Logitech\r\nTình trạng : 100%\r\nBảo hành : 24 tháng')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (44, N'Logitech G102 LightSync Black', 2, 1, N'None', 3990.0000, 0, N'Hãng sản xuất : Logitech\r\nTình trạng : 100%\r\nBảo hành : 24 tháng')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (45, N'Logitech G304 Wireless White', 2, 1, N'None', 7800.0000, 0, N'Hãng sản xuất : Logitech\r\nTình trạng : 100%\r\nBảo hành : 24 tháng')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (46, N'Logitech G502 Hero Gaming', 2, 1, N'None', 9500.0000, 0, N'Hãng sản xuất : Logitech\r\nTình trạng : 100%\r\nBảo hành : 24 tháng')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (47, N'Logitech G Pro X Spl 2 Magenta', 2, 1, N'None', 30900.0000, 0, N'Hãng sản xuất : Logitech\r\nTình trạng : 100%\r\nBảo hành : 24 tháng')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (48, N'Steelseries Arctis Nova 1', 3, 6, N'None', 54900.0000, 0, N'Hãng sản xuất : Steelseries\r\nTình trạng : 100%\r\nBảo hành : 24 tháng')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (49, N'Steelseries Arctis Nova 7 WIRELESS: DIABLO IV EDITION', 3, 6, N'None', 17900.0000, 0, N'Hãng sản xuất : Steelseries\r\nTình trạng : 100%\r\nBảo hành : 24 tháng')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (50, N'Steelseries TUSQ', 3, 6, N'None', 29500.0000, 0, N'Hãng sản xuất : Steelseries\r\nTình trạng : 100%\r\nBảo hành : 24 tháng')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (51, N'Steelseries Arctis PRO GAMEDAC', 3, 6, N'None', 49900.0000, 0, N'Hãng sản xuất : Steelseries\r\nTình trạng : 100%\r\nBảo hành : 24 tháng')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (52, N'Steelseries Apex 9 MINI', 1, 6, N'None', 16400.0000, 0, N'Hãng sản xuất : Steelseries\r\nTình trạng : 100%\r\nBảo hành : 24 tháng')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (53, N'Steelseries Apex 7 TKL GHOST', 1, 6, N'None', 13900.0000, 0, N'Hãng sản xuất : Steelseries\r\nTình trạng : 100%\r\nBảo hành : 24 tháng')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (54, N'Steelseries Apex PRO MINI WIRELESS', 1, 6, N'None', 28800.0000, 0, N'Hãng sản xuất : Steelseries\r\nTình trạng : 100%\r\nBảo hành : 24 tháng')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [MaLoaiSP], [MaHangSX], [HinhAnh], [GiaSP], [SoLuong], [MoTa]) VALUES (55, N'Steelseries Apex 9 TKL', 1, 6, N'None', 36900.0000, 0, N'Hãng sản xuất : Steelseries\r\nTình trạng : 100%\r\nBảo hành : 24 tháng')
SET IDENTITY_INSERT [dbo].[SanPham] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UNIQUE_TenHang]    Script Date: 12/11/2023 4:14:06 PM ******/
ALTER TABLE [dbo].[HangSX] ADD  CONSTRAINT [UNIQUE_TenHang] UNIQUE NONCLUSTERED 
(
	[TenHangSX] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UNIQUE_TenLoaiSP]    Script Date: 12/11/2023 4:14:06 PM ******/
ALTER TABLE [dbo].[LoaiSP] ADD  CONSTRAINT [UNIQUE_TenLoaiSP] UNIQUE NONCLUSTERED 
(
	[TenLoaiSP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ChiTietPhieuNhap] ADD  DEFAULT ((0)) FOR [TongTienNhapSP]
GO
ALTER TABLE [dbo].[DonHang] ADD  DEFAULT ((0)) FOR [ThanhTien]
GO
ALTER TABLE [dbo].[PhieuNhap] ADD  DEFAULT (getdate()) FOR [NgayNhap]
GO
ALTER TABLE [dbo].[PhieuNhap] ADD  DEFAULT ((0)) FOR [TongTienPN]
GO
ALTER TABLE [dbo].[SanPham] ADD  DEFAULT ((0)) FOR [GiaSP]
GO
ALTER TABLE [dbo].[ChiTietPhieuNhap]  WITH CHECK ADD  CONSTRAINT [FK_ChiTietPhieuNhap_PhieuNhap] FOREIGN KEY([MaPN])
REFERENCES [dbo].[PhieuNhap] ([MaPN])
GO
ALTER TABLE [dbo].[ChiTietPhieuNhap] CHECK CONSTRAINT [FK_ChiTietPhieuNhap_PhieuNhap]
GO
ALTER TABLE [dbo].[ChiTietPhieuNhap]  WITH CHECK ADD  CONSTRAINT [FK_ChiTietPhieuNhap_SanPham] FOREIGN KEY([MaSP])
REFERENCES [dbo].[SanPham] ([MaSP])
GO
ALTER TABLE [dbo].[ChiTietPhieuNhap] CHECK CONSTRAINT [FK_ChiTietPhieuNhap_SanPham]
GO
ALTER TABLE [dbo].[DonHang]  WITH CHECK ADD  CONSTRAINT [FK_DonHang_KhachHang] FOREIGN KEY([MaKH])
REFERENCES [dbo].[KhachHang] ([MaKH])
GO
ALTER TABLE [dbo].[DonHang] CHECK CONSTRAINT [FK_DonHang_KhachHang]
GO
ALTER TABLE [dbo].[DonHang]  WITH CHECK ADD  CONSTRAINT [FK_DonHang_SanPham] FOREIGN KEY([MaSP])
REFERENCES [dbo].[SanPham] ([MaSP])
GO
ALTER TABLE [dbo].[DonHang] CHECK CONSTRAINT [FK_DonHang_SanPham]
GO
ALTER TABLE [dbo].[PhieuNhap]  WITH CHECK ADD  CONSTRAINT [FK_PhieuNhap_NhaCungCap] FOREIGN KEY([MaNCC])
REFERENCES [dbo].[NhaCungCap] ([MaNCC])
GO
ALTER TABLE [dbo].[PhieuNhap] CHECK CONSTRAINT [FK_PhieuNhap_NhaCungCap]
GO
ALTER TABLE [dbo].[PhieuNhap]  WITH CHECK ADD  CONSTRAINT [FK_PhieuNhap_NhanVien] FOREIGN KEY([MaNV])
REFERENCES [dbo].[NhanVien] ([MaNV])
GO
ALTER TABLE [dbo].[PhieuNhap] CHECK CONSTRAINT [FK_PhieuNhap_NhanVien]
GO
ALTER TABLE [dbo].[SanPham]  WITH CHECK ADD  CONSTRAINT [FK_SanPham_HangSX] FOREIGN KEY([MaHangSX])
REFERENCES [dbo].[HangSX] ([MaHangSX])
GO
ALTER TABLE [dbo].[SanPham] CHECK CONSTRAINT [FK_SanPham_HangSX]
GO
ALTER TABLE [dbo].[SanPham]  WITH CHECK ADD  CONSTRAINT [FK_SanPham_LoaiSP] FOREIGN KEY([MaLoaiSP])
REFERENCES [dbo].[LoaiSP] ([MaLoaiSP])
GO
ALTER TABLE [dbo].[SanPham] CHECK CONSTRAINT [FK_SanPham_LoaiSP]
GO
/****** Object:  StoredProcedure [dbo].[PRO_ShowBill]    Script Date: 12/11/2023 4:14:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--Show bill (chi tiết những sản phẩm đã chọn mua)--
CREATE PROC [dbo].[PRO_ShowBill] @magiaodich nvarchar(15)
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
/****** Object:  StoredProcedure [dbo].[PRO_Sua_SP]    Script Date: 12/11/2023 4:14:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--SanPham--
--Thủ tục sửa sản phẩm--
CREATE PROC [dbo].[PRO_Sua_SP] @masp int, @tensp nvarchar(50), @mlsp int, @mhsx int, @hinhanh nvarchar(max), @sl int, @gsp money
AS
	UPDATE SanPham
	SET TenSP = @tensp, MaLoaiSP = @mlsp, MaHangSX = @mhsx, SoLuong = @sl
	WHERE MaSP = @masp

	UPDATE DonHang
	SET GiaSP = @gsp
	WHERE masp = @masp
GO
/****** Object:  StoredProcedure [dbo].[PRO_Them_CTPN]    Script Date: 12/11/2023 4:14:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PRO_Them_CTPN] @mapn int, @masp int, @slsp int, @gnsp money
AS
	INSERT INTO ChiTietPhieuNhap(MaPN, MaSP, SoLuongSP, GiaNhapSP)
	VALUES (@mapn, @masp, @slsp, @gnsp)
GO
/****** Object:  StoredProcedure [dbo].[PRO_Them_PN]    Script Date: 12/11/2023 4:14:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--Thủ tục thêm phiếu nhập--
CREATE PROC [dbo].[PRO_Them_PN] @mapn int, @mancc int, @manv int
AS
	INSERT INTO PhieuNhap(MaPN, MaNCC, MaNV)
	VALUES(@mapn, @mancc, @manv)
GO
/****** Object:  StoredProcedure [dbo].[PRO_Xoa_CTPN]    Script Date: 12/11/2023 4:14:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--Thủ tục xóa chi tiết phiếu nhập--
CREATE PROC [dbo].[PRO_Xoa_CTPN] @mapn int, @masp int
AS
	DELETE FROM ChiTietPhieuNhap WHERE MaPN = @mapn AND MaSP = @masp
GO
/****** Object:  StoredProcedure [dbo].[PRO_Xoa_PN]    Script Date: 12/11/2023 4:14:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--Thủ tục xóa phiếu nhập--
CREATE PROC [dbo].[PRO_Xoa_PN] @mapn int
AS
	DELETE FROM ChiTietPhieuNhap WHERE MaPN = @mapn
	DELETE FROM PhieuNhap WHERE MaPN = @mapn
GO
/****** Object:  StoredProcedure [dbo].[PRO_Xoa_SP]    Script Date: 12/11/2023 4:14:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--Thủ tục xóa sản phẩm--
CREATE PROC [dbo].[PRO_Xoa_SP] @masp int
AS
	If (SELECT COUNT(*) FROM ChiTietPhieuNhap WHERE MaSP = @masp) > 0
		COMMIT TRAN
	Else
		DELETE FROM DonHang WHERE MaSP = @masp
		DELETE FROM SanPham WHERE MaSP = @masp
GO
