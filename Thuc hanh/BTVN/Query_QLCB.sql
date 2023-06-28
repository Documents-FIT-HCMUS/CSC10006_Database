use QL_CB
go
set dateformat mdy
-- CÂU 01
select NV.MANV, NV.TEN, NV.DCHI, NV.DTHOAI
from KHANANG KN join NHANVIEN NV on KN.MANV = NV.MANV
where KN.MALOAI = 'B747'
-- CÂU 02
select LB.MACB, LB.NGAYDI
from CHUYENBAY CB join LICHBAY LB on CB.MACB = LB.MACB
where CB.SBDI = 'DCA' and (CB.GIODI between '14:00' and '18:00')
-- CÂU 03
select distinct NV.TEN
from NHANVIEN NV join PHANCONG PC on NV.MANV = PC.MANV join CHUYENBAY CB on PC.MACB = CB.MACB
where CB.MACB = '100' and CB.SBDI = 'SLC'
-- CÂU 04
select *
from CHUYENBAY CB join LICHBAY LB on CB.MACB = LB.MACB join MAYBAY MB on (LB.MALOAI = MB.MALOAI and LB.SOHIEU = MB.SOHIEU)
-- CÂU 05
select DC.MACB, DC.NGAYDI, KH.TEN, KH.DCHI, KH.DTHOAI
from KHACHHANG KH join DATCHO DC on KH.MAKH = DC.MAKH
order by DC.MACB asc, DC.NGAYDI desc
-- CÂU 06
select PC.MACB, PC.NGAYDI, NV.TEN, NV.DCHI, NV.DTHOAI
from PHANCONG PC join NHANVIEN NV on PC.MANV = NV.MANV
order by PC.MACB asc, PC.NGAYDI desc
-- CÂU 07
select PC.MACB, PC.NGAYDI, PC.MANV, NV.TEN
from NHANVIEN NV join PHANCONG PC on NV.MANV = PC.MANV join CHUYENBAY CB on PC.MACB = CB.MACB
where CB.SBDEN = 'ORD'
-- CÂU 08
select PC.MACB, PC.NGAYDI, NV.TEN
from PHANCONG PC join NHANVIEN NV on PC.MANV = NV.MANV
where PC.MANV = '1001'
-- CÂU 09
select CB.MACB, CB.SBDI, CB.GIODI, CB.GIODEN, LB.NGAYDI
from CHUYENBAY CB join LICHBAY LB on CB.MACB = LB.MACB
where CB.SBDEN = 'DEN'
order by LB.NGAYDI desc, CB.SBDI asc
-- CÂU 10
select NV.TEN, LMB.HANGSX, LMB.MALOAI
from NHANVIEN NV left join KHANANG KN on NV.MANV = KN.MANV left join LOAIMB LMB on KN.MALOAI = LMB.MALOAI
where NV.LOAINV = 1
-- CÂU 11
select NV.MANV, NV.TEN
from NHANVIEN NV join PHANCONG PC on NV.MANV = PC.MANV
where PC.MACB = '100' and PC.NGAYDI = '11/01/2000'
-- CÂU 12
select CB.MACB, NV.MANV, NV.TEN
from NHANVIEN NV join PHANCONG PC on NV.MANV = PC.MANV join CHUYENBAY CB on PC.MACB = CB.MACB
where PC.NGAYDI = '10/31/2000' and CB.SBDI = 'MIA' and CB.GIODI = '20:30'
-- CÂU 13 !!!
select distinct PC.MACB, MB.SOHIEU, MB.MALOAI, LMB.HANGSX
from NHANVIEN NV join PHANCONG PC on NV.MANV = PC.MANV join KHANANG KN on NV.MANV = KN.MANV join LOAIMB LMB on KN.MALOAI = LMB.MALOAI
join MAYBAY MB on LMB.MALOAI = MB.MALOAI
where NV.TEN = 'Quang'
-- CÂU 14
select NV.TEN
from NHANVIEN NV 
except
select NV.TEN
from NHANVIEN NV join PHANCONG PC on NV.MANV = PC.MANV
-- CÂU 15
select distinct KH.TEN
from KHACHHANG KH join DATCHO DC on KH.MAKH = DC.MAKH join LICHBAY LB on DC.MACB = LB.MACB join LOAIMB LMB on LB.MALOAI = LMB.MALOAI
where LMB.HANGSX = 'Boeing'
-- CÂU 16 !!!
select distinct CB.MACB
from CHUYENBAY CB join LICHBAY LB on CB.MACB = LB.MACB join MAYBAY MB on (LB.SOHIEU = MB.SOHIEU and LB.MALOAI = MB.MALOAI)
where MB.SOHIEU = 10 and MB.MALOAI = 'B747'

select distinct LB.MACB
from LICHBAY LB
where LB.SOHIEU = 10 and LB.MALOAI = 'B747'
-- CÂU 17
select SBDEN, count(MACB) 'So luong den'
from CHUYENBAY
group by SBDEN
order by SBDEN asc
-- CÂU 18
select SBDI, count(MACB) 'So luong di'
from CHUYENBAY
group by SBDI
order by SBDI asc
-- CÂU 19
select CB.SBDI, LB.NGAYDI, count(CB.MACB) 'So luong di'
from CHUYENBAY CB join LICHBAY LB on CB.MACB = LB.MACB
group by CB.SBDI, LB.NGAYDI
-- CÂU 20
select CB.SBDEN, LB.NGAYDI, count(CB.MACB) 'So luong den'
from CHUYENBAY CB join LICHBAY LB on CB.MACB = LB.MACB
group by CB.SBDEN, LB.NGAYDI
-- CÂU 21
select LB.MACB, LB.NGAYDI, count(PC.MANV) 'Slg nv kf phi cong'
from LICHBAY LB join PHANCONG PC on (LB.NGAYDI = PC.NGAYDI and LB.MACB = PC.MACB) join NHANVIEN NV on PC.MANV = NV.MANV
where NV.LOAINV != 1
group by LB.MACB, LB.NGAYDI
-- CÂU 22
select count(*) 'So luong xuat phat'
from CHUYENBAY CB join LICHBAY LB on CB.MACB = LB.MACB
where CB.SBDI = 'MIA' and LB.NGAYDI = '11/01/2000'
-- CÂU 23
select PC.MACB, PC.NGAYDI, count(*) 'So luong nhan vien'
from PHANCONG PC join NHANVIEN NV on PC.MANV = NV.MANV
group by PC.MACB, PC.NGAYDI
order by count(*) desc
-- CÂU 24
select MACB, NGAYDI, count(*) 'So luong hanh khach'
from DATCHO
group by MACB, NGAYDI
order by count(*) desc
-- CÂU 25
select PC.MACB, PC.NGAYDI, sum(NV.LUONG) 'Tong luong'
from PHANCONG PC join NHANVIEN NV on PC.MANV = NV.MANV
group by PC.MACB, PC.NGAYDI
order by sum(NV.LUONG) asc
-- CÂU 26
select avg(LUONG) 'Luong TB cua NV khong la phi cong'
from NHANVIEN
where LOAINV != 1
-- CÂU 27
select avg(LUONG) 'Luong trung binh cua phi cong'
from NHANVIEN
where LOAINV = 1
-- CÂU 28
select LB.MALOAI, count(CB.MACB) 'So luong chuyen bay'
from CHUYENBAY CB join LICHBAY LB on CB.MACB = LB.MACB
where CB.SBDEN = 'ORD'
group by LB.MALOAI
-- CÂU 29
select SBDI, count(MACB) 'So luong'
from CHUYENBAY
where GIODI between '10:00' and '22:00'
group by SBDI
having count(MACB) > 2
-- CÂU 30
select NV.TEN
from PHANCONG PC join NHANVIEN NV on PC.MANV = NV.MANV
where NV.LOAINV = 1
group by PC.NGAYDI, NV.TEN
having count(PC.MACB) >= 2
-- CÂU 31
select MACB, NGAYDI
from DATCHO
group by MACB, NGAYDI
having count(MAKH) < 3
-- CÂU 32
select LB.SOHIEU, LB.MALOAI
from PHANCONG PC join LICHBAY LB on (PC.MACB = LB.MACB and PC.NGAYDI = LB.NGAYDI)
where PC.MANV = '1001' 
group by LB.SOHIEU, LB.MALOAI
having COUNT(PC.MANV) > 2
-- CÂU 33
select HANGSX, count(MALOAI) 'So luong loai may bay'
from LOAIMB
group by HANGSX

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

-- PHÉP CHIA
-- CÂU 51
-- not exists
select LB.MACB
from LICHBAY LB
where not exists (	select LMB.MALOAI
					from LOAIMB LMB
					where LMB.HANGSX = 'Boeing'
					and not exists (	select LB2.MACB, LB2.MALOAI from LICHBAY LB2
										where LB.MACB = LB2.MACB and LMB.MALOAI = LB2.MALOAI))
-- except
select LB.MACB
from LICHBAY LB
where not exists (	select LMB.MALOAI from LOAIMB LMB where LMB.HANGSX = 'Boeing'
					except
					select LB2.MALOAI from LICHBAY LB2 where LB2.MACB = LB.MACB)
-- group by
select LB.MACB
from LICHBAY LB join LOAIMB LMB on LB.MALOAI = LMB.MALOAI
where LMB.HANGSX = 'Boeing'
group by LB.MACB
having count(distinct LB.MALOAI) = (	select count(LMB.MALOAI)
										from LOAIMB LMB
										where LMB.HANGSX = 'Boeing')
-- CÂU 52
-- not exists
select NV.MANV, NV.TEN
from NHANVIEN NV
where not exists (	select LMB.MALOAI
					from LOAIMB LMB
					where LMB.HANGSX = 'Airbus' 
					and not exists (	select KN.MALOAI, KN.MANV
										from KHANANG KN
										where KN.MANV = NV.MANV and KN.MALOAI = LMB.MALOAI))
-- except
select NV.MANV, NV.TEN
from NHANVIEN NV
where not exists (	select LMB.MALOAI from LOAIMB LMB where LMB.HANGSX = 'Airbus' 
					except
					select KN.MALOAI from KHANANG KN where KN.MANV = NV.MANV)
-- group by
select NV.MANV, NV.TEN
from NHANVIEN NV join KHANANG KN on NV.MANV = KN.MANV join LOAIMB LMB on KN.MALOAI = LMB.MALOAI
where LMB.HANGSX = 'Airbus' 
group by NV.MANV, NV.TEN
having count(distinct LMB.MALOAI) = (	select count(LMB.MALOAI) 'SLMB'
										from LOAIMB LMB
										where LMB.HANGSX = 'Airbus')
-- CÂU 53
-- not exists
select NV.TEN
from NHANVIEN NV
where NV.LOAINV = 0 and 
not exists (	select LB.MACB, LB.NGAYDI
				from LICHBAY LB
				where LB.MACB = '100' and 
				not exists (	select PC.MACB, PC.MANV
								from PHANCONG PC
								where PC.MANV = NV.MANV and PC.MACB = LB.MACB and PC.NGAYDI = LB.NGAYDI))
-- except
select NV.TEN
from NHANVIEN NV
where NV.LOAINV = 0 and not exists (	select LB.MACB, LB.NGAYDI from LICHBAY LB where LB.MACB = '100'
										except
										select PC.MACB, PC.NGAYDI from PHANCONG PC where PC.MANV = NV.MANV)
-- group by
select NV.TEN
from NHANVIEN NV join PHANCONG PC on NV.MANV = PC.MANV join LICHBAY LB on (PC.MACB = LB.MACB and PC.NGAYDI = LB.NGAYDI)
where NV.LOAINV = 0 and LB.MACB = '100'
group by NV.MANV, NV.TEN
having count(*) = (	select count(*) 'SLCB' from LICHBAY LB where LB.MACB = '100')
-- CÂU 54
-- not exists
select LB.NGAYDI
from LICHBAY LB
where not exists (	select LMB.MALOAI
					from LOAIMB LMB
					where LMB.HANGSX = 'Boeing' and not exists (	select LB2.MALOAI, LB2.NGAYDI
																	from LICHBAY LB2
																	where LB2.MALOAI = LMB.MALOAI and LB2.NGAYDI = LB.NGAYDI))
-- except
select LB.NGAYDI
from LICHBAY LB
where not exists (	select LMB.MALOAI from LOAIMB LMB where LMB.HANGSX = 'Boeing'
					except
					select LB1.MALOAI from LICHBAY LB1 where LB1.NGAYDI = LB.NGAYDI)
-- group by
select LB.NGAYDI
from LICHBAY LB join LOAIMB LMB on LB.MALOAI = LMB.MALOAI
where LMB.HANGSX = 'Boeing'
group by LB.NGAYDI
having count(distinct LB.MALOAI) = (	select count(LMB.MALOAI) 'SLMB'
										from LOAIMB LMB
										where LMB.HANGSX = 'Boeing')
-- CÂU 55
-- not exists
select LMB.MALOAI
from LOAIMB LMB
where LMB.HANGSX = 'Boeing' and not exists (	select distinct LB1.NGAYDI
												from LICHBAY LB1
												where not exists (	select LB2.MALOAI, LB2.NGAYDI
																	from LICHBAY LB2
																	where LB2.MALOAI = LMB.MALOAI and LB2.NGAYDI = LB1.NGAYDI))
-- except
select LMB.MALOAI
from LOAIMB LMB
where LMB.HANGSX = 'Boeing' and not exists (	select distinct LB.NGAYDI from LICHBAY LB
												except
												select distinct LB.NGAYDI from LICHBAY LB where LB.MALOAI = LMB.MALOAI)
-- group by
select LMB.MALOAI
from LICHBAY LB join LOAIMB LMB on LB.MALOAI = LMB.MALOAI
where LMB.HANGSX = 'Boeing'
group by LMB.MALOAI
having count(distinct LB.NGAYDI) = (	select count(distinct LB.NGAYDI) 'SLNGAY'
										from LICHBAY LB)
-- CÂU 56
-- not exists
select KH.MAKH, KH.TEN
from KHACHHANG KH
where not exists (	select DC1.NGAYDI
					from DATCHO DC1
					where DC1.NGAYDI between '2000-1-1' and '2000-10-31'
					and not exists (	select DC2.MAKH, DC2.NGAYDI
										from DATCHO DC2
										where DC2.MAKH = KH.MAKH and DC2.NGAYDI = DC1.NGAYDI))
-- except
select KH.MAKH, KH.TEN
from KHACHHANG KH
where not exists (	select DC.NGAYDI
					from DATCHO DC
					where DC.NGAYDI between '2000-1-1' and '2000-10-31'
					except
					select DC.NGAYDI
					from DATCHO DC
					where DC.MAKH = KH.MAKH)
-- group by
select KH.MAKH, KH.TEN
from KHACHHANG KH join DATCHO DC on KH.MAKH = DC.MAKH
where DC.NGAYDI between '2000-1-1' and '2000-10-31'
group by KH.MAKH, KH.TEN
having count(distinct DC.NGAYDI) = (	select count(distinct DC.NGAYDI)
								from DATCHO DC
								where DC.NGAYDI between '2000-1-1' and '2000-10-31')
-- CÂU 57
-- not exists
select NV.MANV, NV.TEN
from NHANVIEN NV
where not exists (	select LMB.MALOAI 
					from LOAIMB LMB
					where LMB.HANGSX = 'Airbus' and not exists (	select KN.MANV, KN.MALOAI 
																	from KHANANG KN
																	where KN.MANV = NV.MANV and KN.MALOAI = LMB.MALOAI))
-- except
select NV.MANV, NV.TEN
from NHANVIEN NV
where not exists (	select LMB.MALOAI from LOAIMB LMB where LMB.HANGSX = 'Airbus'
					except 
					select KN.MALOAI from KHANANG KN where KN.MANV = NV.MANV)
-- group by
select NV.MANV, NV.TEN
from NHANVIEN NV join KHANANG KN on NV.MANV = KN.MANV join LOAIMB LMB on KN.MALOAI = LMB.MALOAI
where LMB.HANGSX = 'Airbus'
group by NV.MANV, NV.TEN
having count(LMB.MALOAI) = (	select count(LMB.MALOAI) 'SLMB'
								from LOAIMB LMB
								where LMB.HANGSX = 'Airbus')
-- CÂU 58
-- not exists
select CB.SBDI
from CHUYENBAY CB
where not exists (	select LMB1.MALOAI
					from CHUYENBAY CB1 join LICHBAY LB1 on CB1.MACB = LB1.MACB join LOAIMB LMB1 on LB1.MALOAI = LMB1.MALOAI
					where LMB1.HANGSX = 'Boeing' and 
					not exists (	select CB2.SBDI, LB2.MALOAI
									from LICHBAY LB2 join CHUYENBAY CB2 on LB2.MACB = CB2.MACB
									where CB2.SBDI = CB.SBDI and LB2.MALOAI = LMB1.MALOAI))
-- except
select CB.SBDI
from CHUYENBAY CB
where not exists (	select LMB1.MALOAI
					from CHUYENBAY CB1 join LICHBAY LB1 on CB1.MACB = LB1.MACB join LOAIMB LMB1 on LB1.MALOAI = LMB1.MALOAI
					where LMB1.HANGSX = 'Boeing'
					except
					select LB1.MALOAI
					from LICHBAY LB1 join CHUYENBAY CB1 on LB1.MACB = CB1.MACB
					where CB1.SBDI = CB.SBDI)
-- group by
select CB.SBDI
from CHUYENBAY CB join LICHBAY LB on CB.MACB = LB.MACB join LOAIMB LMB on LB.MALOAI = LMB.MALOAI
where LMB.HANGSX = 'Boeing'
group by CB.SBDI
having count(distinct LB.MALOAI) = (	select count(LMB.MALOAI)
										from LOAIMB LMB
										where LMB.HANGSX = 'Boeing')
