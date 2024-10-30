using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace QuanLyCuaHangGamingGear.Models;

public partial class DbGearshopContext : DbContext
{
    public DbGearshopContext()
    {
    }

    public DbGearshopContext(DbContextOptions<DbGearshopContext> options)
        : base(options)
    {
    }

    public virtual DbSet<ChiTietPhieuNhap> ChiTietPhieuNhaps { get; set; }

    public virtual DbSet<DonHang> DonHangs { get; set; }

    public virtual DbSet<HangSx> HangSxes { get; set; }

    public virtual DbSet<KhachHang> KhachHangs { get; set; }

    public virtual DbSet<LoaiSp> LoaiSps { get; set; }

    public virtual DbSet<NhaCungCap> NhaCungCaps { get; set; }

    public virtual DbSet<NhanVien> NhanViens { get; set; }

    public virtual DbSet<PhieuNhap> PhieuNhaps { get; set; }

    public virtual DbSet<SanPham> SanPhams { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see http://go.microsoft.com/fwlink/?LinkId=723263.
        => optionsBuilder.UseSqlServer("Data Source=CUNG\\SQLEXPRESS;Initial Catalog=DB_GEARSHOP;User ID=sa;Password=123;Connect Timeout=30;Encrypt=False;Trust Server Certificate=False;Application Intent=ReadWrite;Multi Subnet Failover=False");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<ChiTietPhieuNhap>(entity =>
        {
            entity.HasKey(e => new { e.MaPn, e.MaSp });

            entity.ToTable("ChiTietPhieuNhap", tb =>
                {
                    tb.HasTrigger("Them_CTPN");
                    tb.HasTrigger("Xoa_CTPN");
                });

            entity.Property(e => e.MaPn).HasColumnName("MaPN");
            entity.Property(e => e.MaSp).HasColumnName("MaSP");
            entity.Property(e => e.GhiChu).HasMaxLength(100);
            entity.Property(e => e.GiaNhapSp)
                .HasColumnType("decimal(18, 2)")
                .HasColumnName("GiaNhapSP");
            entity.Property(e => e.SoLuongSp).HasColumnName("SoLuongSP");
            entity.Property(e => e.TongTienNhapSp)
                .HasDefaultValueSql("((0))")
                .HasColumnType("money")
                .HasColumnName("TongTienNhapSP");

            entity.HasOne(d => d.MaPnNavigation).WithMany(p => p.ChiTietPhieuNhaps)
                .HasForeignKey(d => d.MaPn)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_ChiTietPhieuNhap_PhieuNhap");

            entity.HasOne(d => d.MaSpNavigation).WithMany(p => p.ChiTietPhieuNhaps)
                .HasForeignKey(d => d.MaSp)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_ChiTietPhieuNhap_SanPham");
        });

        modelBuilder.Entity<DonHang>(entity =>
        {
            entity.HasKey(e => e.MaDh).HasName("PK__DonHang__27258661D0011AD5");

            entity.ToTable("DonHang", tb =>
                {
                    tb.HasTrigger("CN_SLSP_DonHang");
                    tb.HasTrigger("ThanhTien_DH");
                });

            entity.Property(e => e.MaDh).HasColumnName("MaDH");
            entity.Property(e => e.GhiChu).HasMaxLength(100);
            entity.Property(e => e.GiaSp)
                .HasColumnType("decimal(18, 2)")
                .HasColumnName("GiaSP");
            entity.Property(e => e.MaGiaoDich).HasMaxLength(15);
            entity.Property(e => e.MaKh).HasColumnName("MaKH");
            entity.Property(e => e.MaSp).HasColumnName("MaSP");
            entity.Property(e => e.SoLuongSp).HasColumnName("SoLuongSP");
            entity.Property(e => e.TenNvpt)
                .HasMaxLength(50)
                .HasColumnName("TenNVPT");
            entity.Property(e => e.ThanhTien)
                .HasDefaultValueSql("((0))")
                .HasColumnType("money");

            entity.HasOne(d => d.MaKhNavigation).WithMany(p => p.DonHangs)
                .HasForeignKey(d => d.MaKh)
                .HasConstraintName("FK_DonHang_KhachHang");

            entity.HasOne(d => d.MaSpNavigation).WithMany(p => p.DonHangs)
                .HasForeignKey(d => d.MaSp)
                .HasConstraintName("FK_DonHang_SanPham");
        });

        modelBuilder.Entity<HangSx>(entity =>
        {
            entity.HasKey(e => e.MaHangSx).HasName("PK__HangSX__8C6D28FE97D071D6");

            entity.ToTable("HangSX");

            entity.HasIndex(e => e.TenHangSx, "UNIQUE_TenHang").IsUnique();

            entity.Property(e => e.MaHangSx).HasColumnName("MaHangSX");
            entity.Property(e => e.TenHangSx)
                .HasMaxLength(50)
                .HasColumnName("TenHangSX");
        });

        modelBuilder.Entity<KhachHang>(entity =>
        {
            entity.HasKey(e => e.MaKh).HasName("PK__KhachHan__2725CF1E7BDE4678");

            entity.ToTable("KhachHang");

            entity.Property(e => e.MaKh).HasColumnName("MaKH");
            entity.Property(e => e.DiaChi).HasMaxLength(50);
            entity.Property(e => e.DienThoai).HasMaxLength(11);
            entity.Property(e => e.Email).HasMaxLength(50);
            entity.Property(e => e.GhiChu).HasMaxLength(100);
            entity.Property(e => e.MatKhau).HasMaxLength(10);
            entity.Property(e => e.TenKh)
                .HasMaxLength(50)
                .HasColumnName("TenKH");
        });

        modelBuilder.Entity<LoaiSp>(entity =>
        {
            entity.HasKey(e => e.MaLoaiSp).HasName("PK__LoaiSP__1224CA7C0BCF9C2E");

            entity.ToTable("LoaiSP");

            entity.HasIndex(e => e.TenLoaiSp, "UNIQUE_TenLoaiSP").IsUnique();

            entity.Property(e => e.MaLoaiSp).HasColumnName("MaLoaiSP");
            entity.Property(e => e.TenLoaiSp)
                .HasMaxLength(50)
                .HasColumnName("TenLoaiSP");
        });

        modelBuilder.Entity<NhaCungCap>(entity =>
        {
            entity.HasKey(e => e.MaNcc).HasName("PK__NhaCungC__3A185DEB91FE5034");

            entity.ToTable("NhaCungCap");

            entity.Property(e => e.MaNcc).HasColumnName("MaNCC");
            entity.Property(e => e.DiaChi).HasMaxLength(50);
            entity.Property(e => e.DienThoai).HasMaxLength(11);
            entity.Property(e => e.GhiChu).HasMaxLength(100);
            entity.Property(e => e.TenNcc)
                .HasMaxLength(50)
                .HasColumnName("TenNCC");
        });

        modelBuilder.Entity<NhanVien>(entity =>
        {
            entity.HasKey(e => e.MaNv).HasName("PK__NhanVien__2725D70A14F30B8C");

            entity.ToTable("NhanVien");

            entity.Property(e => e.MaNv).HasColumnName("MaNV");
            entity.Property(e => e.Cccd)
                .HasMaxLength(13)
                .HasColumnName("CCCD");
            entity.Property(e => e.ChucVu).HasMaxLength(40);
            entity.Property(e => e.DiaChi).HasMaxLength(50);
            entity.Property(e => e.DienThoai).HasMaxLength(11);
            entity.Property(e => e.GhiChu).HasMaxLength(100);
            entity.Property(e => e.MatKhau).HasMaxLength(10);
            entity.Property(e => e.TenNv)
                .HasMaxLength(50)
                .HasColumnName("TenNV");
        });

        modelBuilder.Entity<PhieuNhap>(entity =>
        {
            entity.HasKey(e => e.MaPn).HasName("PK__PhieuNha__2725E7F06B6E3AC4");

            entity.ToTable("PhieuNhap");

            entity.Property(e => e.MaPn).HasColumnName("MaPN");
            entity.Property(e => e.GhiChu).HasMaxLength(100);
            entity.Property(e => e.MaNcc).HasColumnName("MaNCC");
            entity.Property(e => e.MaNv).HasColumnName("MaNV");
            entity.Property(e => e.NgayNhap)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("date");
            entity.Property(e => e.TongTienPn)
                .HasDefaultValueSql("((0))")
                .HasColumnType("money")
                .HasColumnName("TongTienPN");

            entity.HasOne(d => d.MaNccNavigation).WithMany(p => p.PhieuNhaps)
                .HasForeignKey(d => d.MaNcc)
                .HasConstraintName("FK_PhieuNhap_NhaCungCap");

            entity.HasOne(d => d.MaNvNavigation).WithMany(p => p.PhieuNhaps)
                .HasForeignKey(d => d.MaNv)
                .HasConstraintName("FK_PhieuNhap_NhanVien");
        });

        modelBuilder.Entity<SanPham>(entity =>
        {
            entity.HasKey(e => e.MaSp).HasName("PK__SanPham__2725081C021A75D2");

            entity.ToTable("SanPham");

            entity.Property(e => e.MaSp).HasColumnName("MaSP");
            entity.Property(e => e.GiaSp)
                .HasDefaultValueSql("((0))")
                .HasColumnType("money")
                .HasColumnName("GiaSP");
            entity.Property(e => e.MaHangSx).HasColumnName("MaHangSX");
            entity.Property(e => e.MaLoaiSp).HasColumnName("MaLoaiSP");
            entity.Property(e => e.MoTa).HasMaxLength(300);
            entity.Property(e => e.TenSp)
                .HasMaxLength(50)
                .HasColumnName("TenSP");

            entity.HasOne(d => d.MaHangSxNavigation).WithMany(p => p.SanPhams)
                .HasForeignKey(d => d.MaHangSx)
                .HasConstraintName("FK_SanPham_HangSX");

            entity.HasOne(d => d.MaLoaiSpNavigation).WithMany(p => p.SanPhams)
                .HasForeignKey(d => d.MaLoaiSp)
                .HasConstraintName("FK_SanPham_LoaiSP");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
