use QuanLyVT

Select * From VATTU
--Tạo Bảng Ảo Không dùng With Check Option
Create View VATTU_View
as
	select * From VATTU where DVTinh=N'Viên'
--Vì cách này k dùng "with check option" nên thêm k cần điều kiện
--Giả sử thêm 
insert into VATTU_View values ('MITO',N'Mì Tôm',N'Gói',5)
Select * From  VATTU_View

--Tạo Bảng Ảo dùng With Check Option
Create View VATTU_View_bala
as
	select * From VATTU where DVTinh=N'Viên'
with check option
--Vì cách này dùng "with check option" nên k thể thêm nếu k đúng điều kiện
--Giả sử thêm
insert into VATTU_View_bala values ('COMC',N'Cơm Cháy Mở Hành',N'Túi',15)
--thì nó k thêm đc
--Muốn thêm "Cơm cháy" vào VATTU_View_bala thì "DVTinh"='Viên'
Select * From  VATTU_View_bala
