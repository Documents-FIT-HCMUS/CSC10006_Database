-- Lớp: CQ2019/3
-- Room: 24
-- Mã đề thi: 322
-- MSSV: 19120383
-- Họ tên: Huỳnh Tấn Thọ
use QLLV
go
-- Câu 1: Cho biết thông tin mã giáo viên, họ tên giáo viên, tên bộ môn của giáo viên làm “Chủ tịch hội đồng” nhiều lần nhất
select GV.MSGV, GV.HOTEN, BM.TENBM
from GIANGVIEN GV join BOMON BM on GV.MABM = BM.MABM join THANHVIENHD TVHD on GV.MSGV = TVHD.MSGV
where TVHD.VAITRO = N'Chủ tịch hội đồng'
group by GV.MSGV, GV.HOTEN, BM.TENBM
having count(*) >= all (	select count(*)	
							from THANHVIENHD TVHD	
							where TVHD.VAITRO = N'Chủ tịch hội đồng'
							group by TVHD.MSGV)
					

-- Câu 2: Cho biết mã và họ tên giáo viên cho điểm cao nhất cho luận văn “Nghiên cứu xây dựng website học online”.
select GV.MSGV, GV.HOTEN
from KETQUABAOVE KQ join LUANVAN LV on KQ.MSLV = LV.MSLV join THANHVIENHD TVHD on KQ.ID = TVHD.ID join GIANGVIEN GV on TVHD.MSGV = GV.MSGV
where LV.TENLV = N'Nghiên cứu xây dựng website học online' and KQ.DIEM >= all 
(	select KQ.DIEM 
	from KETQUABAOVE KQ join LUANVAN LV on KQ.MSLV = LV.MSLV 
	where LV.TENLV = N'Nghiên cứu xây dựng website học online')

-- Câu 3: Tìm hội đồng (mã hội đồng, năm) có tất cả giảng viên thuộc bộ môn “Mạng máy tính” tham gia trong hội đồng. Yêu cầu:
-- Xác định các thành phần của phép chia: R, S, KQ.
	-- KQ: HOIDONG(MAHD, NAM)
	-- S: GIANGVIEN x BOMON (MSGV) where TENBM = Mạng máy tính
	-- R: THANHVIENHD (MSGV, MAHD, NAM)
-- Viết truy vấn (dùng 1 trong 3 cách truy vấn: not exists, except hoặc group by).
select  HD.MAHD, HD.NAM
from HOIDONG HD
where not exists (	select GV.MSGV
					from GIANGVIEN GV join BOMON BM on GV.MABM = BM.MABM
					where BM.TENBM = N'Mạng máy tính'
					except
					select TVHD.MSGV
					from THANHVIENHD TVHD
					where TVHD.MAHD = HD.MAHD)


-- Câu 4: Cài đặt stored procedure thêm một thành viên hội đồng
go
create procedure spThemTVHD @id char(10), @msgv char(6), @mahd int, @nam char(4), @vaitro nvarchar(20)
as
	-- Kiểm tra GV tồn tại
	if (not exists (select * from GIANGVIEN where @msgv = MSGV))
		return -1
	-- Kiểm tra HĐ tồn tại
	if (not exists (select * from HOIDONG where MAHD = @mahd and NAM = @nam))
		return -1
	-- Kiểm tra SL chủ tịch
	if (@vaitro = N'Chủ tịch hội đồng')
	begin
		if ((select count(*) from THANHVIENHD where MAHD = @mahd and NAM = @nam and VAITRO = @vaitro) >= 1)
			return -1
	end
	-- Kiểm tra SL thư ký
	if (@vaitro = N'Thư ký')
	begin
		if ((select count(*) from THANHVIENHD where MAHD = @mahd and NAM = @nam and VAITRO = @vaitro) >= 1)
			return -1
	end
	-- Kiểm tra SL ủy viên
	if (@vaitro = N'Ủy viên')
	begin
		if ((select count(*) from THANHVIENHD where MAHD = @mahd and NAM = @nam and VAITRO = @vaitro) >= 3)
			return -1
	end
	insert THANHVIENHD values (@id, @mahd, @nam, @msgv, @vaitro)
	return 1
go
declare @kq int
exec @kq = spThemTVHD '4857', 3, '2009', 'GV1010', N'Ủy viên' 
print @kq