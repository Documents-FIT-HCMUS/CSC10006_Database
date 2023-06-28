use QL_CB
go

-- C헧 17
select SBDEN, count(MACB) 'So luong den'
from CHUYENBAY
group by SBDEN
order by SBDEN asc
-- C헧 18
select SBDI, count(MACB) 'So luong di'
from CHUYENBAY
group by SBDI
order by SBDI asc
-- C헧 19
select CB.SBDI, LB.NGAYDI, count(CB.MACB) 'So luong di'
from CHUYENBAY CB join LICHBAY LB on CB.MACB = LB.MACB
group by CB.SBDI, LB.NGAYDI
-- C헧 20
select CB.SBDEN, LB.NGAYDI, count(CB.MACB) 'So luong den'
from CHUYENBAY CB join LICHBAY LB on CB.MACB = LB.MACB
group by CB.SBDEN, LB.NGAYDI
-- C헧 21
select LB.MACB, LB.NGAYDI, count(PC.MANV) 'Slg nv kf phi cong'
from LICHBAY LB join PHANCONG PC on (LB.NGAYDI = PC.NGAYDI and LB.MACB = PC.MACB) join NHANVIEN NV on PC.MANV = NV.MANV
where NV.LOAINV != 1
group by LB.MACB, LB.NGAYDI
-- C헧 22
select count(*) 'So luong xuat phat'
from CHUYENBAY CB join LICHBAY LB on CB.MACB = LB.MACB
where CB.SBDI = 'MIA' and LB.NGAYDI = '11/01/2000'
-- C헧 23
select PC.MACB, PC.NGAYDI, count(*) 'So luong nhan vien'
from PHANCONG PC join NHANVIEN NV on PC.MANV = NV.MANV
group by PC.MACB, PC.NGAYDI
order by count(*) desc
-- C헧 24
select MACB, NGAYDI, count(*) 'So luong hanh khach'
from DATCHO
group by MACB, NGAYDI
order by count(*) desc
-- C헧 25
select PC.MACB, PC.NGAYDI, sum(NV.LUONG) 'Tong luong'
from PHANCONG PC join NHANVIEN NV on PC.MANV = NV.MANV
group by PC.MACB, PC.NGAYDI
order by sum(NV.LUONG) asc
-- C헧 26
select avg(LUONG) 'Luong TB cua NV khong la phi cong'
from NHANVIEN
where LOAINV != 1
-- C헧 27
select avg(LUONG) 'Luong trung binh cua phi cong'
from NHANVIEN
where LOAINV = 1
-- C헧 28
select LB.MALOAI, count(CB.MACB) 'So luong chuyen bay'
from CHUYENBAY CB join LICHBAY LB on CB.MACB = LB.MACB
where CB.SBDEN = 'ORD'
group by LB.MALOAI
-- C헧 29
select SBDI, count(MACB) 'So luong'
from CHUYENBAY
where GIODI between '10:00' and '22:00'
group by SBDI
having count(MACB) > 2
-- C헧 30
select NV.TEN
from PHANCONG PC join NHANVIEN NV on PC.MANV = NV.MANV
where NV.LOAINV = 1
group by PC.NGAYDI, NV.TEN
having count(PC.MACB) >= 2
-- C헧 31
select MACB, NGAYDI
from DATCHO
group by MACB, NGAYDI
having count(MAKH) < 3
-- C헧 32
select LB.SOHIEU, LB.MALOAI
from PHANCONG PC join LICHBAY LB on (PC.MACB = LB.MACB and PC.NGAYDI = LB.NGAYDI)
where PC.MANV = '1001' 
group by LB.SOHIEU, LB.MALOAI
having COUNT(PC.MANV) > 2
-- C헧 33
select HANGSX, count(MALOAI) 'So luong loai may bay'
from LOAIMB
group by HANGSX