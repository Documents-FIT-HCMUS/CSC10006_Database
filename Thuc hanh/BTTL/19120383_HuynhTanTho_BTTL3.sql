use QL_DT
go
set dateformat dmy
-- CÂU 01
select GV.HOTEN, GV.LUONG
from GIAOVIEN GV
where GV.PHAI = N'Nữ'
-- CÂU 02
select GV.HOTEN, GV.LUONG * 1.1 N'LƯƠNG MỚI (+10%)'
from GIAOVIEN GV
-- CÂU 03
select GV.MAGV
from GIAOVIEN GV left join BOMON BM on GV.MAGV = BM.TRUONGBM 
where (GV.HOTEN like N'Nguyễn %' and GV.LUONG > 2000) or (BM.TRUONGBM is not null and year(BM.NGAYNHANCHUC) > 1995)
-- CÂU 04
select GV.HOTEN
from GIAOVIEN GV join BOMON BM on GV.MABM = BM.MABM join KHOA K on BM.MAKHOA = K.MAKHOA
where K.TENKHOA = N'Công nghệ thông tin'
-- CÂU 05
select *
from GIAOVIEN GV join BOMON BM on GV.MAGV = BM.TRUONGBM
-- CÂU 06
select GV.MAGV, GV.HOTEN, BM.*
from GIAOVIEN GV join BOMON BM on GV.MABM = BM.MABM
-- CÂU 07
select DT.TENDT, GV.*
from DETAI DT join GIAOVIEN GV oN DT.GVCNDT = GV.MAGV
-- CÂU 08
select GV.*
from KHOA K left join GIAOVIEN GV on GV.MAGV = K.TRUONGKHOA
order by GV.MAGV asc
-- CÂU 09
select distinct GV.*
from GIAOVIEN GV join BOMON BM on GV.MABM = BM.MABM join THAMGIADT TGIA on GV.MAGV = TGIA.MAGV
where BM.TENBM = N'Vi sinh' and TGIA.MADT = '006'
-- CÂU 10
select DT.MADT, CD.TENCD, GV.HOTEN, GV.NGSINH, GV.DIACHI
from DETAI DT join CHUDE CD on DT.MACD = CD.MACD join GIAOVIEN GV on DT.GVCNDT = GV.MAGV
where DT.CAPQL = N'Thành phố'
-- CÂU 11
select GV1.HOTEN 'HO TEN GIAO VIEN', GV2.HOTEN 'HO TEN GVQLCM'
from GIAOVIEN GV1 left join GIAOVIEN GV2 on GV1.GVQLCM = GV2.MAGV
-- câu 12
select GV1.HOTEN
from GIAOVIEN GV1 join GIAOVIEN GV2 on GV1.GVQLCM = GV2.MAGV
where GV2.HOTEN = N'Nguyễn Thanh Tùng'
-- CÂU 13
select GV.HOTEN
from GIAOVIEN GV join BOMON BM on GV.MAGV = BM.TRUONGBM
where BM.TENBM = N'Hệ thống thông tin'
-- CÂU 14
select distinct GV.HOTEN
from GIAOVIEN GV join DETAI DT on GV.MAGV = DT.GVCNDT join CHUDE CD on DT.MACD = CD.MACD
where CD.TENCD = N'Quản lý giáo dục'
-- CÂU 15
select CV.TENCV
from DETAI DT join CONGVIEC CV on DT.MADT = CV.MADT
where DT.TENDT = N'HTTT quản lý các trường ĐH' and (month(CV.NGAYBD) = 3 and year(CV.NGAYBD) = 2008)
-- CÂU 16
select GV1.HOTEN, GV2.HOTEN N'Người QLCM'
from GIAOVIEN GV1 left join GIAOVIEN GV2 on GV1.GVQLCM = GV2.MAGV
-- CÂU 17
select CV.*
from CONGVIEC CV
where CV.NGAYBD between '1/1/2007' and '1/8/2007'
-- CÂU 18
select GV1.HOTEN
from GIAOVIEN GV1 join GIAOVIEN GV2 on GV1.MABM = GV2.MABM
where GV2.HOTEN = N'Trần Trà Hương'
-- CÂU 19
select distinct GV.*	/* Do 1 GV có thể chủ nhiệm nhiều đề tài */
from GIAOVIEN GV join BOMON BM on GV.MAGV = BM.TRUONGBM join DETAI DT on GV.MAGV = DT.GVCNDT
-- CÂU 20
select GV.HOTEN
from GIAOVIEN GV join BOMON BM on GV.MAGV = BM.TRUONGBM join KHOA K on GV.MAGV = K.TRUONGKHOA
-- CÂU 21
select distinct GV.HOTEN
from GIAOVIEN GV join BOMON BM on GV.MAGV = BM.TRUONGBM join DETAI DT on GV.MAGV = DT.GVCNDT 
-- CÂU 22
select distinct K.TRUONGKHOA
from KHOA K join DETAI DT on K.TRUONGKHOA = DT.GVCNDT
-- CÂU 23
select distinct GV.MAGV /* Do 1 GV có thể tham gia nhiều công việc trong cùng đề tài */
from GIAOVIEN GV join THAMGIADT TGIA on GV.MAGV = TGIA.MAGV
where GV.MABM = N'HTTT' or TGIA.MADT = '001'
-- CÂU 24
select GV1.*
from GIAOVIEN GV1 join GIAOVIEN GV2 on GV1.MABM = GV2.MABM
where GV2.MAGV = '002'
-- CÂU 25
select GV.*
from GIAOVIEN GV join BOMON BM on GV.MAGV = BM.TRUONGBM
order by GV.MAGV asc
-- CÂU 26
select GV.HOTEN, GV.LUONG
from GIAOVIEN GV