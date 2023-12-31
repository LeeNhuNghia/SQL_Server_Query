use QuanLyVT
/*1. Tạo view có tên vw_DMVT bao gồm các thông tin sau: mã vật tư, tên vật tư. View này
dùng để liệt kê danh sách các vật tư hiện có trong bảng VATTU.*/
create view vw_DMVT
as
	select MaVT, TenVT
	from VATTU

/*2. Tạo view có tên vw_DonDH_TongSLNhap của từng số đặt hàng, bao gồm các thông tin
sau: số đặt hàng, tổng số lượng đã nhập hàng.*/
create view vw_DonDH_TongSLNhap
as
	select CTDONDH.SoDH,SUM(SlNhap) as TongSLNhap
	from ((CTDONDH inner join VATTU on VATTU.MaVT=CTDONDH.MaVT)
			inner join CTPNHAP on CTPNHAP.MaVT=VATTU.MaVT)
	group by CTDONDH.SoDH
	select*from vw_DONDH_TongSlNhap
/*3. Tạo view có tên vw_TongNhap bao gồm các thông tin sau: năm tháng, mã vật tư, tổng
số lượng nhập. View này dùng để thông kê số lượng nhập của các vật tư trong từng năm
tháng tương ứng.*/

	
/*4. Tạo view có tên vw_TongXuat bao gồm các thông tin sau: năm tháng, mã vật tư, tổng số
lượng xuất. View này dùng để thống kê số lượng xuất của vật tư trong từng năm tháng
tương ứng./*