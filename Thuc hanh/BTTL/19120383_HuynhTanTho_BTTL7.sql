use QL_DT
go
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
