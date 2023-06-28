-- Lớp: CQ2019/3
-- Room: 40
-- Mã đề thi: 662
-- MSSV: 19120383
-- Họ tên: Huỳnh Tấn Thọ
use master
go
if DB_ID('QLDA') is not null
	drop database QLDA
go
create database QLDA
go
use QLDA

create table PHONGBAN
(
	MaPhongBan varchar(4),
	TenPhongBan nvarchar(40),
	DiaDiem varchar(4),
	TruongPhong varchar(4)

	constraint PK_PHONGBAN
	primary key (MaPhongBan)
)
create table DEAN
(
	MaDeAn varchar(4),
	TenDeAn nvarchar(40),
	ThoiGian int,
	MaPhongBan varchar(4),
	TruongDeAn varchar(4)

	constraint PK_DEAN
	primary key (MaDeAn)
)
create table NHANVIEN
(
	MaNV varchar(4),
	MaPhong varchar(4),
	HoTen nvarchar(40),
	NgaySinh date,
	GioiTinh nvarchar(3),
	Luong int

	constraint PK_NHANVIEN
	primary key (MaNV, MaPhong)
)

alter table PHONGBAN
add
	constraint FK_TRUONGPHONG
	foreign key (TruongPhong, MaPhongBan)
	references NHANVIEN (MaNV, MaPhong)
alter table DEAN
add
	constraint FK_DEAN_PHONGBAN
	foreign key (MaPhongBan)
	references PHONGBAN (MaPhongBan),
	constraint FK_DEAN_NHANVIEN
	foreign key (TruongDeAn, MaPhongBan)
	references NHANVIEN (MaNV, MaPhong)
alter table NHANVIEN
add
	constraint FK_NHANVIEN_PHONGBAN
	foreign key (MaPhong)
	references PHONGBAN (MaPhongBan)

set dateformat dmy
go
insert PHONGBAN
values('P001', N'Nghiên cứu', 'C444', null), ('P002', N'Kế hoạch', 'B234', null), ('P003', N'Nhân sự', 'D111', null)

insert NHANVIEN
values ('NV01', 'P001', N'Trần Hải', '12/2/1999', N'Nam', 2500), ('NV02', 'P001', N'Lê Anh Đào', '30/12/1987', N'Nữ', 3000),
('NV01', 'P002', N'Lý Khanh', '6/6/1960', N'Nam', 1000), ('NV02', 'P002', N'Phan Minh Trí', '6/6/1960', N'Nam', 2500),
('NV03', 'P002', N'Nguyễn Lan', '7/3/1982', N'Nữ', 3000), ('NV01', 'P003', N'Vũ Bình Phương', '17/3/1980', N'Nam', 3000),
('NV02', 'P003', N'Đặng Khải Minh', '22/10/1980', N'Nam', 1400)

insert DEAN
values ('DA01', N'Ngôi nhà thông minh', 120, 'P001', 'NV02'), ('DA02', N'Hành tinh xanh', 220, 'P002', 'NV01'),
('DA03', N'Công viên xanh', 100, 'P002', 'NV02')

update PHONGBAN set TruongPhong = 'NV02' where MaPhongBan = 'P001'
update PHONGBAN set TruongPhong = 'NV03' where MaPhongBan = 'P002'
update PHONGBAN set TruongPhong = 'NV01' where MaPhongBan = 'P003'

select * from PHONGBAN
select * from NHANVIEN
select * from DEAN

-- Cho biết thông tin mã và tên nhân viên vừa là trưởng phòng vừa là trưởng đề án
select NV.MaNV, NV.HoTen
from NHANVIEN NV join PHONGBAN PB on (NV.MaNV = PB.TruongPhong and NV.MaPhong = PB.MaPhongBan) 
join DEAN DA on (NV.MaNV = DA.TruongDeAn and NV.MaPhong = DA.MaPhongBan)

-- Cho biết thông tin mã, tên phòng, họ tên trưởng phòng và số lượng nhân viên của từng phòng ban.
select PB.TruongPhong, PB.TenPhongBan, NVTP.HoTen 'TenTruongPhong', count(NV.MaNV) 'SoLuongNhanVien'
from PHONGBAN PB join NHANVIEN NVTP on (NVTP.MaNV = PB.TruongPhong and NVTP.MaPhong = PB.MaPhongBan) 
join NHANVIEN NV on NV.MaPhong = PB.MaPhongBan
group by PB.TruongPhong, PB.TenPhongBan, NVTP.HoTen

-- Cho biết thông tin mã, tên phòng ban phụ trách từ 2 đề án trở lên
select PB.MaPhongBan, PB.TenPhongBan
from PHONGBAN PB join DEAN DA on PB.MaPhongBan = DA.MaPhongBan
group by PB.MaPhongBan, PB.TenPhongBan
having count(DA.MaDeAn) >=2 