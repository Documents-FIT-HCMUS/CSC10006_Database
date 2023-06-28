use QL_DT
go
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
select GV.HOTEN
from GIAOVIEN GV
where not exists (	select TG1.MADT  from THAMGIADT TG1 join GIAOVIEN GV1 on TG1.MAGV = GV1.MAGV
					where GV1.HOTEN = N'Trần Trà Hương'
					and not exists 
					(select TG2.MADT from THAMGIADT TG2 
					where GV.MAGV = TG2.MAGV and TG2.MADT = TG1.MADT))
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