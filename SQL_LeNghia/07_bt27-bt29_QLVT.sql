use QuanLyVT
/*27.  Tạo  một  bảng  tên  VATTU_Temp  có  cấu  trúc  và  dữ  liệu  dựa  vào  bảng  VATTU  (Chỉ  lấy  hai 
cột:  MAVT,  TENVT  và  bỏ  đi  các  constraint  liên  quan),  sau  đó  sử  dụng  WHILE  EXISTS 
(cau_lenh_Select)  viết  1  đoạn  chương  trình  dùng  để  xóa  từng  dòng  dữ  liệu  trong  bảng 
VATTU_Temp  với  điều  kiện  câu  lệnh  trong  vòng  lặp  khi  mỗi  lần  lặp  chỉ  được  phép  xóa  1 
dòng dữ liệu trong bảng VATTU_Temp. Trong khi xóa nên thông báo "Đang xóa vật tư" + 
Tên vật tư*/
select MaVT, TenVT into VATTU_Temp from VATTU

select *from VATTU_Temp
declare @MaVT char(4), @TenVT nvarchar(100)
while exists(select * from VATTU_Temp)
	begin
		set @MaVT= (select top 1 mavt from VATTU_Temp)
		set @TenVT= (select top 1 Tenvt from VATTU_Temp)
		delete from VATTU_Temp where Mavt=@mavt
		print N'Đang xóa vật tư: '+@TenVT
	end
	
/*28.  Trong bảng VATTU_Temp bổ sung thêm hai cột mới: SOPX CHAR(4), DGIAXUAT FLOAT.
Kiểm tra đơn giá trung bình của vật tư  G001 trong bảng CTPXUAT, nếu đơn giá trung bình 
vẫn còn <800 thì tăng đơn giá lên 10% cho các vật tư G001 chỉ có đơn giá xuất <800. Kết 
thúc vòng lặp cho biết  đã  thực hiện việc tăng bao nhiêu lần trong vòng lặp. Trong mỗi lần 
tăng  đơn giá phải chèn thêm dòng dữ liệu  đã  tăng từ bảng CTXUAT và VATTU (để lấy cột 
TENVT) vào bảng VATTU_Temp.*/
alter table VATTU_Temp
add SOPX CHAR(4), DGIAXUAT FLOAT
select *from VATTU_Temp
declare @dem int
set @dem = 0
while (select AVG(dgxuat) from CTPXUAT where MaVT='G001')<800
	begin
		insert into VATTU_Temp
		select 'G001', tenvt, sopx, dgxuat *1.1
		from CTPXuat inner join VATTU on VATTU.MaVT=CTPXuat.Mavt
		where ctpxuat.Mavt='G001' and dgxuat<800
		
		update CTPXuat
		set DGXuat=Dgxuat*1.1
		where Mavt='G001' and DGXuat<800
		set @dem=@dem+1
	end
print @dem


select *from CTPXuat
select *from VATTU_Temp


/*29.  Xem lại dữ liệu của bảng VATTU_Temp sắp xếp theo SOPX, MAVT, DGIAXUAT để thấy được 
thứ tự các lần tăng giá mà câu 28 đã thực hiện. */
select * from VATTU_Temp
order by SOPX, MAVT, DGIAXUAT