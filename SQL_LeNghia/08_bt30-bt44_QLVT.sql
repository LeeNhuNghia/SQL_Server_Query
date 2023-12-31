use QuanLyVT
--VD1
create proc vd1
as
	print N'Chào bạn'
	--
exec sp_helptext vd1
--Thi hành
exec vd1
--
alter proc vd1
as
	print 'Hello'
	
--VD2
create proc vd2
	@ten nvarchar(20)
as
	print N'Xin chào bạn: ' + @ten
--
exec vd2 N'Như Nghĩa'

--Vdu3
create proc vd3
	@ho nvarchar(200),
	@ten nvarchar(100)
as
	print N'Xin chào '+@ho+' '+@ten
--
exec vd3 N'Lê' ,N'Như Nghĩa'


--Câu 30
create proc c30
	@Mavt char(4),
	@Tenvt nVarchar(200),
	@dvTinh nvarchar(100),
	@phantram real
as
		if exists(select *from VATTU where Mavt=@mavt)
			begin
				print N'Mã vật tư này đã có, Không thêm được'
				return
			end
		if exists(select *from VATTU where TenVT=@tenvt)
			begin
				print N'Tên vật tư này bị trùng, Không thể thêm được'
				return
			end
		if @phantram<0 or @phantram>100
			begin
				print N'Bạn nhập không hợp lệ! Phần trăm phải từ 1-100%'
				return
			end
		insert into VATTU values (@mavt, @tenvt, @dvtinh, @phantram)
		print N'Thêm Thành Công'
	--
exec c30 'C000',N'Đá',N'Khối',150
exec c30 'C000',N'Đá abc',N'Khối',150
exec c30 'C000',N'Đá abc',N'Khối',50

--Cau31
create proc c31
	@mavt char(4)
as
	if not exists(select *from vattu where MaVT=@mavt)
		begin
			print N'Không có vật tư này'
			return
		end
	if exists(select *from ctdondh where MaVT=@mavt)
		begin
			print N'Vật tư này đã đặt hàng, không xóa được'
			return
		end
	if exists(select *from CTpxuat where MaVT=@mavt)
		begin
			print N'Vật tư này đã xuất hàng, không xóa được'
			return
		end
	if exists(select *from tonkho where MaVT=@mavt)
		begin
			print N'Vật tư này đã tính tồn kho, không xóa được'
			return
		end
delete from vattu where mavt=@mavt
print N'Thành công'
--
exec c31 'Cxxx'
exec c31 'G001'
exec c31 'C001'





--Vidu
/*create proc Vidudtb
	@t real,
	@v real,
	@TB real output
as
	set @TB=(@t+@v)/2
--
declare @DTB real
exec Vidudtb 1,5,@dtb output
print @DTB
*/




--Câu 32
create proc c32
	@mavt char(4),
	@tenvt nvarchar(200),
	@dvtinh nvarchar(100),
	@phantram real
as
	if not exists(select *from VATTU where mavt=@mavt)
		begin
			print N'Không có vật tư này'
			return
		end
	if exists(select *from VATTU where TenVT=@tenvt)
		begin
			print N'Tên vật tư bị trùng'
			return
		end
	if @phantram<0 or @phantram>100
		begin
			print N'Phần trăm không phù hợp, Nó phải từ 1-100%'
		end
	update VATTU set TenVT=@tenvt, DVTinh=@dvtinh, PhanTram=@phantram where MaVT=@mavt
	print N'Thành công'
-----------
exec C32 'Sxxx', N'Đá', 'Kg', 120
exec C32 'S001', N'Đá', 'Kg', 120
exec C32 'S001', N'ĐÁ Gà', 'Kg', 120
exec C32 'S001', N'ĐÁ Gà', 'Kg', 20


--Câu33
create proc C33
	@Sodh char(4),
	@Mavt char(4),
	@SlDat int output
as
	if not exists(select * from CTDONDH where SoDH=@sodh and Mavt=@mavt)
		begin
			print N'Không có dòng chi tiết đặt hàng này'
			return
		end
	set @SlDat=(select SlDat from CTDONDH where SoDH=@Sodh and MaVT=@mavt)
---
drop proc C33

declare @sl int
exec C33 'Dxxx','Gxxx', @sl output
print @sl

declare @sl int
exec C33 'D001','Gxxx', @sl output
print @sl

declare @sl int
exec C33 'D001','G001', @sl output
print @sl


--Câu 34
create proc C34
	@SoDH char(4),
	@MaVT char(4),
	@TongSLNhap int output
as
	if not exists(select *from CTPNhap inner join PNHAP 
				on CTPNHAP.SoPN = PNHAP.SoPN
				where SoDH=@SoDH and MaVT=@MaVT)
			begin
				print 'Khong ton tai dong chi tiet nay'
				return
			end
	set @TongSLNhap=(select SUM(slNhap) from CTPNhap inner join PNHAP 
					on PNHAP.SoPN=CTPNhap.SoPN
					where SoDH=@SoDH and MaVT=@MaVT)
---

declare @tong int
exec C34 'D001','G001',@tong output
print @tong


--C35
create proc spud_TONKHO_TinhTon_Cuoi
	@NamThang datetime,
	@MaVT char(4),
	@SLCuoi int output
as
	if not exists(select *from TONKHO where NamThang=@NamThang and MaVT=@MaVT)
		begin
			print 'Khong ton tai NamThang/ MaVT nay'
			return
		end
	set @SLCuoi=(select SLCuoi from TONKHO where NamThang=@NamThang and MaVT=@MaVT)
--
declare @sl int
exec spud_TONKHO_TinhTon_Cuoi '200301','G001',@sl output
print @sl

--ví dụ4
create proc VD4
	@toan real,
	@van real,
	@dtb real output,
	@anh real=null
as
	if @anh is null
		set @dtb= (@toan+@van)/2
	else
		set @dtb= (@toan+@van+@anh)/3
---
declare @diemTB_1 real
exec VD4 8,7,@diemTB_1 output
print @diemTB_1

declare @diemTB_2 real
exec VD4 8,7,@diemTB_2 output,6
print @diemTB_2


--Vi dụ 5
create proc VD5
	@dvtinh nvarchar(10)=null
as
	if @dvtinh is null
		select * from VATTU
	else
		select * from VATTU where DVTinh=@dvtinh

exec VD5
exec VD5 'kg'

--Câu 38
create proc C38
	@soPX char(4)=null
as
	if @soPX is null
		select CTPXUAT.SoPX, CTPXUAT.MaVT, SLXuat, DGXuat, NgayXuat, TenKH, TenVT
		from ((PXUAT inner join CTPXUAT on PXUAT.SoPX=CTPXUAT.SoPX)
				inner join VATTU on VATTU.MaVT=CTPXUAT.MaVT)
	else
		select CTPXUAT.SoPX, CTPXUAT.MaVT, SLXuat, DGXuat, NgayXuat, TenKH, TenVT
		from ((PXUAT inner join CTPXUAT on PXUAT.SoPX=CTPXUAT.SoPX)
				inner join VATTU on VATTU.MaVT=CTPXUAT.MaVT)
		where CTPXUAT.SoPX=@SoPX
--
exec C38
exec C38 'X002'
exec C38 'N001'
--Câu39
create proc C39
	@sodh char(4),
	@manhacc char(4),
	@ngaydh datetime=null
as
	if exists(select * from DONDH where SoDH=@sodh)
		begin
			print N'Trùng SoDH'
			return
		end
	if not exists(select * from NHACC where MaNhaCC=@manhacc)
		begin
			print 'khong co MANHACC nay'
			return
		end
	if @ngaydh is null
		insert into DONDH values (@sodh, GETDATE(),@manhacc)
	else
		insert into DONDH values (@sodh, @ngaydh,@manhacc)
print 'Thanh Cong'
--
exec C39 'D001', 'Bxxx'
exec C39 'D004', 'Bxxx'
exec C39 'D004', 'B001'
select *from DONDH
exec C39 'D005', 'B001','1/1/2022'

--Cau40
create proc C40
	@sodh char(4)
as
	
	if exists(select *from PNHAP where SoDH=@sodh)
		begin
			print 'Khong xoa duoc vi SoDH nay da nhap hang'
			return
		end
	if not exists(select *from DONDH where Sodh=@sodh)
		begin
			print 'Khong ton tai SoDH nay!'
			return
		end
	delete from CTDONDH where Sodh=@sodh
	delete from DONDH where Sodh=@sodh
	print 'Xoa Thanh Cong'
--
exec C40 'D003'

--Cau41
create proc C41
	@sodh char(4),
	@ngaydh datetime,
	@manhacc char(4)
as
	if not exists(select * from NHACC where MaNhaCC=@manhacc)
		begin
			print 'Khong co MaNhaCC nay!'
			return
		end
	if not exists(select *from DONDH where SoDH=@sodh)
		begin
			print 'Don dat hang nay khong co!!'
			return
		end
	declare @ngaymin datetime
	set @ngaymin = (select MIN(ngaynhap) from PNHAP where SoDH=@sodh)
	if @ngaydh>=@ngaymin
		begin
			print 'Ngay can sua phai < ' + convert(char(10),@ngaymin,103)
			return
		end
	update DONDH set NgayDH=@ngaydh, MaNhaCC=@manhacc where Sodh=@sodh
	print 'Sua thanh cong'
--
exec C41 'Dxxx','10/10/2003', 'Bxxx'
--C42
create proc C42
	@sodh char(4),
	@mavt char(4),
	@sldat int
as
	if not exists(select *From DONDH where SoDH=@sodh)
		begin
			print 'SoDH nay khong co'
			return
		end
	if not exists(select *From VATTU where MaVT=@mavt)
		begin
			print 'MaVT nay khong co'
			return
		end
	if exists(select *from CTDONDH where SoDH=@sodh and MaVT=@mavt)
		begin
			print 'SoDH va MaVT bi trung!'
			return
		end
	if @sldat<=0
		begin
			print 'so luong dat hang phai >0'
			return
		end
	insert into CTDONDH values (@sodh, @mavt, @sldat)
	print 'Nhap thanh cong'
--
exec C42 'Dxxx', 'Gxxx', 0
exec C42 'D001', 'Gxxx', 0
exec C42 'D001', 'G001', 0
exec C42 'D001', 'T001', 15

select *from CTDONDH

--C43
create proc C43
	@SoDH char(4),
	@MaVT char(4)
as
	if exists(select *from PNHAP where SoDH=@sodh)
		begin
			print 'SoDH nay da ton tai trong PNHAP'
			return
		end
	if exists(select *from CTPNHAP where MaVT=@mavt)
		begin
			print 'MaVT nay da ton tai trong CTPNHAP'
			return
		end
	if not exists(select *from CTDONDH where SoDH=@sodh and MaVT=@mavt)
		begin
			print 'Dong chi tiet nay khong co!'
			return
		end
	delete from CTDONDH where SoDH=@sodh and MaVT=@mavt
	
--
exec C43 'Dxxx','Gxxx'
exec C43 'D001','G001'
exec C43 'D003','G001'
exec C43 'D003','T003'
select *from CTDONDH

--C44
create proc C44
	@sodh char(4),
	@mavt char(4),
	@sldat int
as
	if not exists(select *from CTDONDH where SoDH=@sodh and MaVT=@mavt)
		begin
			print 'SoDH hoac MaVT khong nam trong bang CTDONDH'
			return
		end
	update CTDONDH set SLDat=@sldat where SoDH=@sodh and MaVT=@mavt
	print 'Sua thanh cong'
--
exec C44 'Dxxx','Gxxx',700
exec C44 'D001','Gxxx',700
exec C44 'D001','G001',700