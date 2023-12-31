use QLSV_14
--Create table với tên LOPHOC
create table LOPHOC
(MaLop char(4), TenLop nvarchar(100),
Siso int constraint def_LOPHOC default 0,
constraint Pri_LOPHOC primary key(malop),
constraint Uni_LOPHOC unique(tenlop),
constraint Chk_LOPHOC check(Siso>=0)
)
--Create table với tên MONHOC
create table MONHOC
(MaMon char(4), TenMon nvarchar(100), SoTiet int
constraint Pri_MONHOC primary key(MaMon),
constraint Uni_MONHOC unique(TenMon),
constraint Chk_MONHOC check(sotiet>=0)
)
--Create table với tên SINHVIEN
create table SINHVIEN
(MaSV char(4), Hotensv nvarchar(50), NgaySinh datetime, Phai bit, MaLop char(4), DiemTB real, TSMon int
constraint Pri_SINHVIEN primary key(Masv),
constraint For_SINHVIEN_LOPHOC foreign key(malop) references LOPHOC(malop)
)
--Create table với tên KETQUA
create table KETQUA
(MaSV char(4), MaMon char(4), Diem real
constraint Pri_KETQUA primary key(Masv, mamon),
constraint Chk_KETQUA check(Diem>=0 and Diem<=10),
constraint For_KETQUA_SINHVIEN foreign key(masv) references SINHVIEN(masv),
constraint For_KETQUA_MONHOC foreign key(mamon) references MONHOC(mamon)
)