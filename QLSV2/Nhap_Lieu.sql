use QLSV_14
--Nhập liệu cho LOPHOC
insert into LOPHOC values ('TH10',N'Tin học 10A',0)
insert into LOPHOC values ('TH11',N'Tin học 11A',0)
insert into LOPHOC values ('KT12',N'Kế toán 12A',0)
select * from LOPHOC

--Nhập liệu cho MONHOC
insert into MONHOC values ('THCB',N'Tin học cơ bản',60)
insert into MONHOC values ('THVP',N'Tin học văn phòng',90)
insert into MONHOC values ('NLKT',N'Nguyên lý kế toán',120)
select * from MONHOC

--Nhập liệu cho SINHVIEN
insert into SINHVIEN values ('A001',N'Tran Thanh Tung','01/01/1983',1,'TH10',0,0)
insert into SINHVIEN values ('A002',N'Vu Truong Thuy','05/05/1983',0,'TH10',0,0)
insert into SINHVIEN values ('A003',N'Pham Anh Tuan','04/04/1984',1,'TH10',0,0)
insert into SINHVIEN values ('B001',N'Dao Pha Thach','02/02/1978',1,'TH11',0,0)
insert into SINHVIEN values ('B002',N'Truong My Dung','05/24/1985',0,'TH11',0,0)
insert into SINHVIEN values ('C001',N'Nguyen Van Cuong','08/18/1978',1,'KT12',0,0)
insert into SINHVIEN values ('C002',N'Pham Thi Thu Duy','05/05/1981',0,'KT12',0,0)
insert into SINHVIEN values ('C003',N'Tran Kim Sang','10/10/1990',0,'KT12',0,0)
select * from SINHVIEN

--Nhập liệu cho KETQUA
insert into KETQUA values ('A001','THCB',6)
insert into KETQUA values ('A001','THVP',9)
insert into KETQUA values ('A002','THCB',7.5)
insert into KETQUA values ('A002','THVP',6.5)
insert into KETQUA values ('A003','THCB',10)
insert into KETQUA values ('A003','THVP',9.5)

insert into KETQUA values ('B001','THCB',4)
insert into KETQUA values ('B001','THVP',3)
insert into KETQUA values ('B002','THCB',8)
insert into KETQUA values ('B002','THVP',4.5)

insert into KETQUA values ('C001','THCB',10)
insert into KETQUA values ('C001','THVP',9)
insert into KETQUA values ('C001','NLKT',8)
insert into KETQUA values ('C002','THCB',5)
insert into KETQUA values ('C002','THVP',6)
insert into KETQUA values ('C002','NLKT',3)
select * from KETQUA