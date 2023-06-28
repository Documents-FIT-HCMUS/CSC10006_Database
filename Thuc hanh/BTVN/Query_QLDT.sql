use QL_DT
go
set dateformat dmy
-- TRUY VẤN ĐƠN GIẢN
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

-- TRUY VẤN DÙNG HÀM KẾT HỢP VÀ GOM NHÓM
-- CÂU 27
select count(GV.MAGV) 'SO LUONG GV', sum(GV.LUONG) 'TONG LUONG' 
from GIAOVIEN GV
-- CÂU 28
select BM.TENBM 'TEN BO MON', count(GV.MAGV) 'SO LUONG GIAO VIEN', avg(GV.LUONG) 'LUONG TRUNG BINH'
from GIAOVIEN GV join BOMON BM on GV.MABM = BM.MABM
group by BM.TENBM
-- CÂU 29
select CD.TENCD, count(DT.MADT) 'SO LUONG DE TAI'
from CHUDE CD join DETAI DT on CD.MACD = DT.MACD
group by CD.TENCD
-- CÂU 30
select GV.HOTEN, count(distinct TG.MADT) 'SLG DT THGIA'
from GIAOVIEN GV join THAMGIADT TG on GV.MAGV = TG.MAGV
group by TG.MAGV, GV.HOTEN
-- CÂU 31
select GV.HOTEN, count(DT.MADT) 'SLG DT CHU NHIEM'
from GIAOVIEN GV join DETAI DT on GV.MAGV = DT.GVCNDT
group by GV.MAGV, GV.HOTEN
-- CÂU 32
select GV.MAGV, GV.HOTEN, count(NT.TEN) 'SO LUONG NG THAN'
from GIAOVIEN GV left join NGUOITHAN NT on GV.MAGV = NT.MAGV
group by GV.MAGV, GV.HOTEN
-- CÂU 33
select GV.HOTEN
from GIAOVIEN GV join THAMGIADT TG on GV.MAGV = TG.MAGV
group by GV.MAGV, GV.HOTEN
having count(distinct TG.MADT) >= 3
-- CÂU 34
select count(GV.MAGV) 'SLG GV THGIA'
from GIAOVIEN GV join THAMGIADT TG on GV.MAGV = TG.MAGV join DETAI DT on TG.MADT = DT.MADT
where DT.TENDT = N'Ứng dụng hóa học xanh'

-- TRUY VẤN LỒNG
-- CÂU 35
select max(LUONG) 'Luong cao nhat'
from GIAOVIEN
-- CÂU 36
select GV.*
from GIAOVIEN GV
where GV.LUONG >= all (select LUONG from GIAOVIEN)
-- CÂU 37
select *
from GIAOVIEN GV
where GV.MABM = N'HTTT' and GV.LUONG >= all (select LUONG from GIAOVIEN where MABM = N'HTTT')
-- CÂU 38
select GV.*
from GIAOVIEN GV join BOMON BM on GV.MABM = BM.MABM
where BM.TENBM = N'Hệ thống thông tin' and DATEDIFF(year, GV.NGSINH, getdate()) >= all 
(
	select DATEDIFF(year, GV.NGSINH, getdate()) 
	from GIAOVIEN GV join BOMON BM on GV.MABM = BM.MABM
	where BM.TENBM = N'Hệ thống thông tin'
)
-- CÂU 39
select GV1.*
from GIAOVIEN GV1 join BOMON BM1 on GV1.MABM = BM1.MABM join KHOA K1 on BM1.MAKHOA = K1.MAKHOA
where K1.TENKHOA = N'Công nghệ thông tin' and DATEDIFF(year, GV1.NGSINH, getdate()) <= all
(
	select DATEDIFF(year, GV2.NGSINH, getdate()) 
	from GIAOVIEN GV2 join BOMON BM2 on GV2.MABM = BM2.MABM join KHOA K2 on BM2.MAKHOA = K2.MAKHOA
	where K2.TENKHOA = N'Công nghệ thông tin'
)
-- CÂU 40
select GV.HOTEN, K.TENKHOA
from GIAOVIEN GV join BOMON BM on GV.MABM = BM.MABM join KHOA K on BM.MAKHOA = K.MAKHOA
where GV.LUONG >= all (select LUONG from GIAOVIEN)
-- CÂU 41
select GV1.*
from GIAOVIEN GV1
where GV1.LUONG >= all (select GV2.LUONG 
						from GIAOVIEN GV2 
						where GV1.MABM = GV2.MABM)
-- CÂU 42
select TENDT
from DETAI
where TENDT not in (select DT.TENDT
					from THAMGIADT TG join DETAI DT on TG.MADT = DT.MADT join GIAOVIEN GV on GV.MAGV = TG.MAGV
					where GV.HOTEN = N'Nguyễn Hoài An')
-- CÂU 43
select DT.TENDT 'Ten de tai', GV.HOTEN 'Ten nguoi chu nhiem'
from DETAI DT join GIAOVIEN GV on DT.GVCNDT = GV.MAGV
where DT.MADT not in (	select DT.MADT
						from THAMGIADT TG join DETAI DT on TG.MADT = DT.MADT join GIAOVIEN GV on GV.MAGV = TG.MAGV
						where GV.HOTEN = N'Nguyễn Hoài An')
-- CÂU 44
select GV.HOTEN
from GIAOVIEN GV join BOMON BM on GV.MABM = BM.MABM join KHOA K on BM.MAKHOA = K.MAKHOA
where K.TENKHOA = N'Công nghệ thông tin' and GV.MAGV not in (select MAGV from THAMGIADT)
-- CÂU 45
select *
from GIAOVIEN
where MAGV not in (select distinct MAGV from THAMGIADT)
-- CÂU 46
select *
from GIAOVIEN
where LUONG > (select LUONG from GIAOVIEN where HOTEN = N'Nguyễn Hoài An')
-- CÂU 47
select GV.*
from GIAOVIEN GV join BOMON BM on GV.MABM = BM.MABM
where GV.MAGV = BM.TRUONGBM and GV.MAGV in (select distinct MAGV from THAMGIADT)
-- CÂU 48
-- CÂU 49
select *
from GIAOVIEN
where LUONG > any (	select GV.LUONG 
					from GIAOVIEN GV join BOMON BM on GV.MABM = BM.MABM  
					where BM.TENBM = N'Công nghệ phần mềm')
-- CÂU 50
select *
from GIAOVIEN
where LUONG > all (	select GV.LUONG
					from GIAOVIEN GV join BOMON BM on GV.MABM = BM.MABM
					where BM.TENBM = N'Hệ thống thông tin')
-- CÂU 51
select K.TENKHOA
from GIAOVIEN GV join BOMON BM on GV.MABM = BM.MABM join KHOA K on BM.MAKHOA = K.MAKHOA
group by K.MAKHOA, K.TENKHOA
having count(GV.MAGV) >= all (	select count(GV.MAGV)
								from GIAOVIEN GV join BOMON BM on GV.MABM = BM.MABM join KHOA K on BM.MAKHOA = K.MAKHOA
								group by K.MAKHOA)
-- CÂU 52
select GV.HOTEN
from GIAOVIEN GV join DETAI DT on GV.MAGV = DT.GVCNDT
group by GV.MAGV, GV.HOTEN
having count(DT.MADT) >= all (	select count(DT.MADT)
								from GIAOVIEN GV join DETAI DT on GV.MAGV = DT.GVCNDT
								group by GV.MAGV)
-- CÂU 53
select BM.MABM
from GIAOVIEN GV join BOMON BM on GV.MABM = BM.MABM
group by BM.MABM
having count(GV.MAGV) >= all (	select count(GV.MAGV)
								from GIAOVIEN GV join BOMON BM on GV.MABM = BM.MABM
								group by BM.MABM)
-- CÂU 54
select GV.HOTEN, BM.TENBM
from GIAOVIEN GV join THAMGIADT TG on GV.MAGV = TG.MAGV join BOMON BM on GV.MABM = BM.MABM
group by GV.MAGV, GV.HOTEN, BM.TENBM
having count(distinct TG.MADT) >= all (	select count(distinct TG.MADT)
										from GIAOVIEN GV join THAMGIADT TG on GV.MAGV = TG.MAGV
										group by GV.MAGV)
-- CÂU 55
select GV.HOTEN
from GIAOVIEN GV join THAMGIADT TG on GV.MAGV = TG.MAGV join BOMON BM on GV.MABM = BM.MABM
where BM.MABM = N'HTTT'
group by GV.MAGV, GV.HOTEN
having count(distinct TG.MADT) >= all (	select count(distinct TG.MADT)
										from GIAOVIEN GV join THAMGIADT TG on GV.MAGV = TG.MAGV join BOMON BM on GV.MABM = BM.MABM
										where BM.MABM = N'HTTT'
										group by GV.MAGV)
-- CÂU 56
select GV.HOTEN, BM.TENBM
from GIAOVIEN GV join BOMON BM on GV.MABM = BM.MABM join NGUOITHAN NT on GV.MAGV = NT.MAGV
group by GV.MAGV, GV.HOTEN, BM.TENBM
having count(NT.MAGV) >= all (select count(MAGV) from NGUOITHAN group by MAGV)
-- CÂU 57
select GV.HOTEN
from GIAOVIEN GV join DETAI DT on GV.MAGV = DT.GVCNDT join BOMON BM on GV.MABM = BM.MABM
where GV.MAGV = BM.TRUONGBM
group by GV.MAGV, GV.HOTEN
having count(DT.MADT) >= all (	select count(DT.MADT)
								from GIAOVIEN GV join DETAI DT on GV.MAGV = DT.GVCNDT
								group by GV.MAGV)

-- PHÉP CHIA
-- CÂU 58
select GV.HOTEN
from GIAOVIEN GV
where not exists (	select CD.MACD 
					from CHUDE CD
					where not exists (	select TG.MAGV, CD.MACD
										from THAMGIADT TG join DETAI DT on TG.MADT = DT.MADT
										where GV.MAGV = TG.MAGV and DT.MACD = CD.MACD))
-- CÂU 59
select DT.TENDT
from DETAI DT
where not exists (	select GV.MAGV
					from GIAOVIEN GV
					where GV.MABM = N'HTTT' 
					and not exists (	select TG.MAGV, TG.MADT
										from THAMGIADT TG
										where TG.MAGV = GV.MAGV and TG.MADT = DT.MADT))
-- CÂU 60
select DT.TENDT
from DETAI DT
where not exists (	select GV.MAGV
					from GIAOVIEN GV join BOMON BM on GV.MABM = BM.MABM
					where BM.TENBM = N'Hệ thống thông tin' 
					and not exists (	select TG.MAGV, TG.MADT
										from THAMGIADT TG
										where TG.MAGV = GV.MAGV and TG.MADT = DT.MADT))
-- CÂU 61
select GV.*
from GIAOVIEN GV
where not exists (	select DT.MADT from DETAI DT join CHUDE CD on DT.MACD = CD.MACD
					where CD.MACD = N'QLGD'
					except
					select TG.MADT from THAMGIADT TG
					where GV.MAGV = TG.MAGV)			
-- CÂU 62
select GV.HOTEN
from GIAOVIEN GV
where not exists (	select TG1.MADT  from THAMGIADT TG1 join GIAOVIEN GV1 on TG1.MAGV = GV1.MAGV
					where GV1.HOTEN = N'Trần Trà Hương'
					except
					select TG2.MADT from THAMGIADT TG2 
					where GV.MAGV = TG2.MAGV)
-- CÂU 63
select DT.TENDT
from DETAI DT join THAMGIADT TG on DT.MADT = TG.MADT join GIAOVIEN GV on TG.MAGV = GV.MAGV join BOMON BM on GV.MABM = BM.MABM
where BM.TENBM = N'Hóa hữu cơ'
group by DT.MADT, DT.TENDT
having count(distinct TG.MAGV) = (	select count(GV.MAGV) 'SLGV_HHC'
									from GIAOVIEN GV join BOMON BM on GV.MABM = BM.MABM
									where BM.TENBM = N'Hóa hữu cơ')
-- CÂU 64
select GV.HOTEN
from GIAOVIEN GV join THAMGIADT TG on GV.MAGV = TG.MAGV
where TG.MADT = '006'
group by GV.HOTEN
having count(*) = (	select count(*) 'SLCV'
					from CONGVIEC CV
					where CV.MADT = '006')
-- CÂU 65
select GV.*
from GIAOVIEN GV
where not exists (	select DT.MADT
					from DETAI DT join CHUDE CD on DT.MACD = CD.MACD
					where CD.TENCD = N'Ứng dụng công nghệ' and
					not exists (	select TG.MAGV, TG.MADT
									from THAMGIADT TG
									where TG.MAGV = GV.MAGV and TG.MADT = DT.MADT))
-- CÂU 66
select GV.HOTEN
from GIAOVIEN GV
where not exists (	select DT.MADT
					from DETAI DT join GIAOVIEN GV1 on DT.GVCNDT = GV1.MAGV
					where GV1.HOTEN = N'Trần Trà Hương' and
					not exists (	select TG.MAGV, TG.MADT
									from THAMGIADT TG
									where TG.MAGV = GV.MAGV and TG.MADT = DT.MADT))
-- CÂU 67
select DT.TENDT
from DETAI DT
where not exists (	select GV.MAGV from GIAOVIEN GV join BOMON BM on GV.MABM = BM.MABM
					where BM.MAKHOA = 'CNTT'
					except
					select TG.MAGV from THAMGIADT TG
					where TG.MADT = DT.MADT)
-- CÂU 68
select GV.HOTEN
from GIAOVIEN GV
where not exists (	select CV.MADT, CV.SOTT
					from CONGVIEC CV join DETAI DT on CV.MADT = DT.MADT
					where DT.TENDT = N'Nghiên cứu tế bào gốc'
					except
					select TG.MADT, TG.STT
					from THAMGIADT TG
					where TG.MAGV = GV.MAGV)
-- CÂU 69
select GV.HOTEN
from GIAOVIEN GV join THAMGIADT TG on GV.MAGV = TG.MAGV join DETAI DT on TG.MADT = DT.MADT
where DT.KINHPHI > 100
group by GV.MAGV, GV.HOTEN
having count(distinct TG.MADT) = (	select count(DT.MADT) 'SLDT'
									from DETAI DT
									where DT.KINHPHI > 100)
-- CÂU 70
select DT.TENDT
from GIAOVIEN GV join THAMGIADT TG on GV.MAGV = TG.MAGV join DETAI DT on TG.MADT = DT.MADT
	 join BOMON BM on GV.MABM = BM.MABM join KHOA K on BM.MAKHOA = K.MAKHOA
where K.TENKHOA = N'Sinh học'
group by DT.MADT, DT.TENDT
having count(distinct TG.MAGV) = (	select count(GV.MAGV) 'SLGV SH'
									from GIAOVIEN GV join BOMON BM on GV.MABM = BM.MABM join KHOA K on BM.MAKHOA = K.MAKHOA
									where K.TENKHOA = N'Sinh học')
-- CÂU 71
select GV.MAGV, GV.HOTEN, GV.NGSINH
from GIAOVIEN GV join THAMGIADT TG on GV.MAGV = TG.MAGV join DETAI DT on TG.MADT = DT.MADT
where DT.TENDT = N'Ứng dụng hóa học xanh'
group by GV.MAGV, GV.HOTEN, GV.NGSINH
having count(*) = (	select count(*)
					from CONGVIEC CV join DETAI DT on CV.MADT = DT.MADT
					where DT.TENDT = N'Ứng dụng hóa học xanh')
-- CÂU 72
select GV.MAGV, GV.HOTEN, BM.TENBM, GV_QL.HOTEN 'TEN GVQLCM'
from GIAOVIEN GV join THAMGIADT TG on GV.MAGV = TG.MAGV join DETAI DT on TG.MADT = DT.MADT join CHUDE CD on DT.MACD = CD.MACD 
	 join BOMON BM on GV.MABM = BM.MABM left join GIAOVIEN GV_QL on GV.GVQLCM = GV_QL.MAGV
where CD.TENCD = N'Nghiên cứu phát triển'
group by GV.MAGV, GV.HOTEN, BM.TENBM, GV_QL.HOTEN
having count(distinct DT.MADT) = (	select count(MADT) 'SLDT'
									from DETAI DT join CHUDE CD on DT.MACD = CD.MACD
									where CD.TENCD = N'Nghiên cứu phát triển')