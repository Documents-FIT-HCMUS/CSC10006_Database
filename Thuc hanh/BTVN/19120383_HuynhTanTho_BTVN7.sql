use QL_CB
go

-- TRUY VẤN LỒNG
-- CÂU 34
select LMB.HANGSX, LMB.MALOAI, LB.SOHIEU
from LICHBAY LB join LOAIMB LMB on LB.MALOAI = LMB.MALOAI
group by LMB.HANGSX, LMB.MALOAI, LB.SOHIEU
having count(*) >= all (select count(*) from LICHBAY group by SOHIEU, MALOAI)
-- CÂU 35
select NV.TEN
from NHANVIEN NV join PHANCONG PC on NV.MANV = PC.MANV
group by PC.MANV, NV.TEN
having count(PC.MANV) >= all (select count(MANV) from PHANCONG group by MANV)
-- CÂU 36
select NV.TEN, NV.DCHI, NV.DTHOAI
from NHANVIEN NV join PHANCONG PC on NV.MANV = PC.MANV
where NV.LOAINV = 1
group by PC.MANV, NV.TEN, NV.DCHI, NV.DTHOAI
having count(PC.MANV) >= all (	select count(PC.MANV) 
								from NHANVIEN NV join PHANCONG PC on NV.MANV = PC.MANV
								where NV.LOAINV = 1
								group by PC.MANV)
-- CÂU 37
select SBDEN, count(MACB) 'SO LUONG CHUYEN BAY'
from CHUYENBAY
group by SBDEN
having count(MACB) <= all (select count(MACB) from CHUYENBAY group by SBDEN)
-- CÂU 38
select SBDI, count(MACB) 'SO LUONG CHUYEN BAY'
from CHUYENBAY
group by SBDI
having count(MACB) >= all (select count(MACB) from CHUYENBAY group by SBDI)
-- CÂU 39
select KH.TEN, KH.DCHI, KH.DTHOAI
from KHACHHANG KH join DATCHO DC on KH.MAKH = DC.MAKH
group by KH.MAKH, KH.TEN, KH.DCHI, KH.DTHOAI
having count(DC.MACB) >= all (select count(MACB) from DATCHO group by MAKH)
-- CÂU 40
select NV.MANV, NV.TEN, NV.LUONG
from NHANVIEN NV join KHANANG KN on NV.MANV = KN.MANV
group by KN.MANV, NV.MANV, NV.TEN, NV.LUONG
having count(MALOAI) >= all (select count(MALOAI) from KHANANG group by MANV)
-- CÂU 41
select MANV, TEN, LUONG
from NHANVIEN
where LUONG >= all (select LUONG from NHANVIEN)
-- CÂU 42
select distinct NV.TEN, NV.DCHI
from NHANVIEN NV join PHANCONG PC on NV.MANV = PC.MANV join 
(
	select PC.MACB, max(NV.LUONG) 'LUONGCAONHAT'
	from NHANVIEN NV join PHANCONG PC on NV.MANV = PC.MANV
	group by PC.MACB
) MAX_LUONG on PC.MACB = MAX_LUONG.MACB and NV.LUONG = MAX_LUONG.LUONGCAONHAT
-- CÂU 43
select MACB, GIODI, GIODEN
from CHUYENBAY
where GIODI <= all (select distinct GIODI from CHUYENBAY)
-- CÂU 44
select MACB, datediff(minute, GIODI, GIODEN) 'THOIGIANBAY (PHUT)'
from CHUYENBAY
where datediff(minute, GIODI, GIODEN) >= all (select datediff(minute, GIODI, GIODEN) from CHUYENBAY) 
-- CÂU 45
select MACB, datediff(minute, GIODI, GIODEN) 'THOIGIANBAY (PHUT)'
from CHUYENBAY
where datediff(minute, GIODI, GIODEN) <= all (select datediff(minute, GIODI, GIODEN) from CHUYENBAY) 
-- CÂU 46
select MACB, NGAYDI
from LICHBAY
where MACB in 
(
	select MACB
	from LICHBAY
	where MALOAI = 'B747' 
	group by MACB
	having count(*) >= all (select count(*) from LICHBAY where MALOAI = 'B747' group by MACB)
)
-- CÂU 47
select distinct TEMP.MACB, count(distinct PC.MANV) 'SLNV'
from (select MACB, count(MAKH) 'SL HANH KHACH' from DATCHO group by MACB having count(MAKH) > 3) TEMP 
left join PHANCONG PC on TEMP.MACB = PC.MACB
group by TEMP.MACB
-- CÂU 48
select LOAINV, count(MANV) 'SLNV'
from NHANVIEN 
group by LOAINV
having sum(LUONG) > 600000
-- CÂU 49
select TEMP.MACB, count(distinct MAKH) 'SLKH'
from (select MACB from PHANCONG group by MACB having count(distinct MANV) > 3) TEMP
left join DATCHO DC on TEMP.MACB = DC.MACB
group by TEMP.MACB
-- CÂU 50
select distinct MALOAI, count(MACB)
from LICHBAY
where MALOAI in (select MALOAI from LICHBAY group by MALOAI having count(SOHIEU) > 1)
group by MALOAI