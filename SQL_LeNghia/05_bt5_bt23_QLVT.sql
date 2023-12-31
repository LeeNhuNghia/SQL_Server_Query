use QuanLyVT

SELECT*FROM TONKHO
--5.  Cho biết phiếu đặt hàng nào chưa nhập hàng.
SELECT DONDH.*
FROM DONDH
WHERE SoDH NOT IN (SELECT SoDH FROM PNHAP)
--6.  Cho biết những mặt hàng nào chưa được đặt hàng bao giờ.
SELECT VATTU.* FROM VATTU
WHERE MAVT  NOT IN (SELECT MAVT FROM CTDONDH)
--7.  Cho biết nhà cung cấp nào có nhiều đơn đặt hàng nhất.
-- CACH 1: TRUY VAN CON 
SELECT NHACC.MANHACC, TENNHACC,DIACHI, COUNT(*)
FROM NHACC INNER JOIN DONDH ON DONDH.MANHACC= NHACC.MANHACC
GROUP BY NHACC.MANHACC, TENNHACC,DIACHI
HAVING COUNT(*) >= ALL (SELECT COUNT(*) FROM DONDH GROUP BY MANHACC)

--CACH 2: SU DUNG SELECT TO N (ODER BY)
SELECT TOP 1 NHACC.MANHACC, TENNHACC,DIACHI, COUNT(*)
FROM NHACC INNER JOIN DONDH ON DONDH.MANHACC= NHACC.MANHACC
GROUP BY NHACC.MANHACC, TENNHACC,DIACHI
ORDER BY COUNT(*) DESC
-- CACH 3:  SU DUNG SELECT TP N VOI WITH TIES
SELECT TOP 1 WITH TIES NHACC.MANHACC, TENNHACC,DIACHI, COUNT(*)
FROM NHACC INNER JOIN DONDH ON DONDH.MANHACC= NHACC.MANHACC
GROUP BY NHACC.MANHACC, TENNHACC,DIACHI
ORDER BY COUNT(*) ASC

--8.  Cho biết vật tư nào có tổng số lượng xuất bán là nhiều nhất
SELECT TOP 1 WITH TIES CTPXUAT.MAVT, VATTU.TENVT, DVTINH,PHANTRAM,SUM(SLXUAT)
FROM VATTU INNER JOIN CTPXUAT ON CTPXUAT.MAVT= VATTU.MAVT
GROUP BY CTPXUAT.MAVT, VATTU.TENVT, DVTINH,PHANTRAM
ORDER BY SUM(SLXUAT) DESC 

--9.  Cho biết đơn đặt hàng nào có nhiều mặt hàng nhất.
SELECT TOP 1 WITH TIES CTDONDH.SoDH,NgayDH,MaNhaCC,COUNT(*)
FROM DONDH INNER JOIN CTDONDH ON CTDONDH.SoDH= DONDH.SoDH
GROUP BY CTDONDH.SoDH,NgayDH,MaNhaCC
ORDER BY COUNT(*) DESC

--10.  Cho biết tình hình đặt hàng trong từng ngày: ngày đặt hàng, mã vật tư, số lượng đặt.
SELECT NgayDH, MaVT,SUM(SlDat)
FROM DONDH INNER JOIN CTDONDH ON CTDONDH.SoDH= DONDH.SoDH
GROUP BY NgayDH,MAVT

--11.  Thống kê tình hình đặt trong từng tháng của mỗi năm, gồm: Năm tháng, mã vật tư, tên vật tư, tổng số lượng đặt hàng.
SELECT CONVERT(CHAR(6), NgayDH,112), CTDONDH.MAVT,TENVT,SUM(SLDAT)
FROM ((DONDH INNER JOIN CTDONDH ON CTDONDH.SoDH= DONDH.SoDH)
           INNER JOIN VATTU ON VATTU.MAVT= CTDONDH.MAVT )
GROUP BY CONVERT(CHAR(6), NgayDH,112), CTDONDH.MAVT,TENVT
           
--12.  Thống kê tình hình nhập hàng tương tự tình hình đặt hàng.

--13.  Hiển thị danh sách các vật tư trong bảng VATTU sắp xếp theo thứ tự tên vật tư giảm dần.
select VATTU.*
from VATTU
order by TenVT desc

--14.  Hiển thị danh sách các nhà cung cấp trong bảng NHACC có cột  địa chỉ ở quận 1 HCM, sắp 
--xếp dữ liệu theo họ tên tăng dần.
select NHACC.*
from NHACC
where(DiaChi like'%Q1%')
order by TenNhaCC


--15.  Hiển thị danh sách các thông tin trong bảng CTNHAP và có thêm cột thành tiền biết rằng:
--Thành tiền = SLNhap*DgNhap
select CTPNhap.*, SlNhap*DgNhap as ThanhTien
from CTPNhap

--16.  Hiển thị danh sách các mã nhà cung cấp, tên nhà cung cấp không trùng lắp dữ liệu đã  đặt 
--hàng trong bảng DONDH.
select distinct NHACC.MaNhaCC, TenNhaCC
from NHACC inner join DONDH on NHACC.MaNhaCC=DONDH.MaNhaCC

--17.  Hiển thị danh sách các đơn đặt hàng gần đây nhất trong bảng DONDH.

select *
from DONDH


--18.  Hiển thị danh sách các phiếu xuất hàng gồm có: số phiếu xuất và tổng trị giá. Trong đó sắp 
--xếp theo thứ tự tổng trị giá giảm dần.


--19.  Hiển thị danh sách các vật tư  và tổng số lượng xuất bán (sử dụng  các mối liên kết INNER, 
--LEFT,  RIGHT  JOIN  giữa  hai  bảng  VATTU  và  CTPXUAT  để  xem  các  kết  quả  có  khác  nhau không?)
--*********INNER JOIN:
select CTPXUAT.MaVT, TenVT, SUM(slxuat)as TSLX
from CTPXUAT inner join VATTU on VATTU.MaVT=CTPXUAT.MaVT
group by CTPXUAT.MaVT, TenVT
--*********LEFT JOIN:
select CTPXUAT.MaVT, TenVT, SUM(slxuat)as TSLX
from CTPXUAT Left join VATTU on VATTU.MaVT=CTPXUAT.MaVT
group by CTPXUAT.MaVT, TenVT
--********RIGHT JOIN:
select CTPXUAT.MaVT, TenVT, SUM(slxuat)as TSLX
from CTPXUAT Left join VATTU on VATTU.MaVT=CTPXUAT.MaVT
group by VATTU.MaVT, TenVT
having SUM(slxuat) is null --su dung trong truong hop TRUY VAN CON


--20.  Xóa chi tiết các vật tư trong bảng CTDONDH vào ngày 17/01/2003.
delete from CTDONDH
from CTDONDH inner join DONDH on DONDH.SoDH=CTDONDH.SoDH
where(NgayDH='01/17/2003')
select * from CTDONDH

--21.  Xóa toàn bộ các dòng dữ liệu trong bảng CTPXUAT.
select * from CTDONDH
delete from CTPXUAT
from CTPXUAT

--22.  Sử dụng lại tập tin script thêm dữ liệu trước đây để chèn lại dữ liệu đã bị xóa

--23.  Sử dụng mệnh đề UNION kết hợp dữ liệu từ hai truy vấn thành 1 có dạng:
select CTPXUAT.SoPX, NgayXuat, TenVT,SlNhap = 0,SlXuat 
from ((CTPXUAT inner join PXUAT on PXUAT.SoPX=CTPXUAT.SoPX)
		inner join VATTU on VATTU.MaVT=CTPXUAT.MaVT)
union
select CTPNhap.SoPN, NgayNhap, TenVT, SlNhap, SlXuat = 0
from ((CTPNhap inner join PNHAP on PNHAP.SoPN=CTPNhap.SoPN)
		inner join VATTU on VATTU.MaVT=CTPNhap.MaVT)
		

		
































