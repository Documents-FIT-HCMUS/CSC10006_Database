use QL_CB
go
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