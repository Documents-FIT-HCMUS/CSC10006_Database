use QL_DT
go
set dateformat dmy

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