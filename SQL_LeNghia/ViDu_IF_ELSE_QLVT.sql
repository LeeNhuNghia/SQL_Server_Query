use QuanLyVT
print 'HeLLO'
declare @toan real, @van real, @anh real, @DTB real
set @toan=7.8
set @van=8
set @anh=7.5

set @DTB=(@toan+@van+@anh)/3
if @DTB>=5
	print N'Đậu'
else
	print N'Rớt'