use master
go
if DB_ID('QL_CB') is not null
	drop database QL_CB
go
create database QL_CB
go
use QL_CB 
go
set dateformat mdy

create table KHACHHANG
(
	MAKH varchar(15),
	TEN varchar(15),
	DCHI varchar(50),
	DTHOAI varchar(12)

	constraint PK_MAKH
	primary key (MAKH)
)
create table NHANVIEN
(
	MANV varchar(15),
	TEN varchar(15),
	DCHI varchar(50),
	DTHOAI varchar(12),
	LUONG decimal(10,2),
	LOAINV bit

	constraint PK_MANV
	primary key (MANV)
)
create table LOAIMB
(
	HANGSX varchar(15),
	MALOAI varchar(15)

	constraint PK_LOAIMB
	primary key (MALOAI)
)
create table MAYBAY
(
	SOHIEU int,
	MALOAI varchar(15)

	constraint PK_MAYBAY
	primary key (SOHIEU, MALOAI)
)
create table CHUYENBAY
(
	MACB varchar(4),	
	SBDI varchar(3),	
	SBDEN varchar(3),	
	GIODI time,	
	GIODEN time

	constraint PK_CHUYENBAY
	primary key (MACB)
)
create table LICHBAY
(
	NGAYDI date,
	MACB varchar(4),	
	SOHIEU int,
	MALOAI varchar(15)

	constraint PK_LICHBAY
	primary key (NGAYDI, MACB)
)
create table DATCHO
(
	MAKH varchar(15),
	NGAYDI date,
	MACB varchar(4),

	constraint PK_DATCHO
	primary key (MAKH, NGAYDI, MACB)
)
create table KHANANG
(
	MANV varchar(15),
	MALOAI varchar(15)

	constraint PK_KN
	primary key(MANV, MALOAI)
)
create table PHANCONG
(
	MANV varchar(15),
	NGAYDI date,
	MACB varchar(4)

	constraint PK_PHANCONG
	primary key(MANV, NGAYDI, MACB)
)

insert NHANVIEN
values ('1006', 'Chi', '12/6 Nguyen	Kiem', '8120012', 150000, 0), ('1005', 'Giao', '65 Nguyen	Thai Son', '8324467', 500000, 0),
('1001', 'Huong', '8 Dien Bien Phu', '8330733', 500000, 1), ('1002', 'Phong', '1 Ly Thuong Kiet', '8308117', 450000, 1),
('1004', 'Phuong', '351 Lac Long Quan', '8308155', 250000, 0), ('1003', 'Quang', '78 Truong Dinh', '8324461', 350000, 1),
('1007', 'Tam', '36 Nguyen Van Cu', '8458188', 500000, 0)
--select * from NHANVIEN
insert KHACHHANG
values ('0009', 'Nga', '223 Nguyen Trai', '8932320'), ('0101', 'Anh', '567 Tran Phu', '8826729'), ('0045', 'Thu', '285 Le Loi', '8932203'),
('0012', 'Ha', '435 Quang Trung', '8933232'), ('0238', 'Hung', '456 Pasteur', '9812101'), ('0397', 'Thanh', '234 Le Van Si', '8952943'),
('0582', 'Mai', '789 Nguyen Du', null), ('0934', 'Minh', '678 Le Lai', null), ('0091', 'Hai', '345 Hung Vuong', '8893223'),
('0314', 'Phuong', '395 Vo Van Tan', '8232320'), ('0613', 'Vu', '348 CMT8', '8343232'), ('0586', 'Son', '123 Bach Dang', '8556223'),
('0422', 'Tien', '75 Nguyen Thong', '8332222')
--select * from KHACHHANG
insert KHANANG
values ('1001', 'B727'), ('1001', 'B747'), ('1001', 'DC10'), ('1001', 'DC9'), ('1002', 'A320'), ('1002', 'A340'), ('1002', 'B757'),
('1002', 'DC9'), ('1003', 'A310'), ('1003', 'DC9')
--select * from KHANANG
insert LOAIMB
values ('Airbus', 'A310'), ('Airbus', 'A320'), ('Airbus', 'A330'), ('Airbus', 'A340'), ('Boeing', 'B727'), ('Boeing', 'B747'),
('Boeing', 'B757'), ('MD', 'DC10'), ('MD', 'DC9')
--select * from LOAIMB
insert DATCHO
values ('0009', '11/01/2000', '100'), ('0009', '10/31/2000', '449'), ('0045', '11/01/2000', '991'), ('0012', '10/31/2000', '206'),
('0238', '10/31/2000', '334'), ('0582', '11/01/2000', '991'), ('0091', '11/01/2000', '100'), ('0314', '10/31/2000', '449'),
('0613', '11/01/2000', '100'), ('0586', '11/01/2000', '991'), ('0586', '10/31/2000', '100'), ('0422', '10/31/2000', '449')
--select * from DATCHO
insert PHANCONG
values ('1001', '11/01/2000', '100'), ('1001', '10/31/2000', '100'), ('1002', '11/01/2000', '100'), ('1002', '10/31/2000', '100'),
('1003', '10/31/2000', '100'), ('1003', '10/31/2000', '337'), ('1004', '10/31/2000', '100'), ('1004', '10/31/2000', '337'),
('1005', '10/31/2000', '337'), ('1006', '11/01/2000', '991'), ('1006', '10/31/2000', '337'), ('1007', '11/01/2000', '112'),
('1007', '11/01/2000', '991'), ('1007', '10/31/2000', '206')
--select * from PHANCONG
insert LICHBAY
values ('11/1/2000', '100', 80, 'A310'), ('11/1/2000', '112', 21, 'DC10'), ('11/1/2000', '206', 22, 'DC9'), ('11/1/2000', '334', 10, 'B747'),
('11/1/2000', '395', 23, 'DC9'), ('11/1/2000', '991', 22, 'B757'), ('11/01/2000', '337', 10, 'B747'), ('10/31/2000', '100', 11, 'B727'),
('10/31/2000', '112', 11, 'B727'), ('10/31/2000', '206', 13, 'B727'), ('10/31/2000', '334', 10, 'B747'), ('10/31/2000', '335', 10, 'B747'),
('10/31/2000', '337', 24, 'DC9'), ('10/31/2000', '449', 70, 'A310')
--select * from LICHBAY
insert CHUYENBAY
values ('100', 'SLC', 'BOS', '08:00', '17:50'), ('112', 'DCA', 'DEN', '14:00', '18:07'), ('121', 'STL', 'SLC', '07:00', '09:13'),
('122', 'STL', 'YYV', '08:30', '10:19'), ('206', 'DFW', 'STL', '09:00', '11:40'), ('330', 'JFK', 'YYV', '16:00', '18:53'),
('334', 'ORD', 'MIA', '12:00', '14:14'), ('335', 'MIA', 'ORD', '15:00', '17:14'), ('336', 'ORD', 'MIA', '18:00', '20:14'),
('337', 'MIA', 'ORD', '20:30', '23:53'), ('394', 'DFW',	'MIA', '19:00', '21:30'), ('395', 'MIA', 'DFW', '21:00', '23:43'),
('449', 'CDG', 'DEN', '10:00', '19:29'), ('930', 'YYV', 'DCA', '13:00', '16:10'), ('931', 'DCA', 'YYV', '17:00', '18:10'),
('932', 'DCA', 'YYV', '18:00', '19:10'), ('991', 'BOS',	'ORD', '17:00',	'18:22')
--select * from CHUYENBAY
insert MAYBAY
values (10, 'B747'), (11, 'B727'), (13, 'B727'), (13, 'B747'), (21, 'DC10'), (21, 'DC9'), (22, 'B757'),
(22, 'DC9'), (23, 'DC9'), (24, 'DC9'), (70, 'A310'), (80, 'A310'), (93, 'B757')
--select * from MAYBAY

alter table DATCHO
add
	constraint FK_DATCHO_KH
	foreign key(MAKH)
	references KHACHHANG,
	constraint FK_DATCHO_LICHBAY
	foreign key(NGAYDI, MACB)
	references LICHBAY
alter table LICHBAY
add
	constraint FK_LICHBAY_CHUYENBAY
	foreign key(MACB)
	references CHUYENBAY,
	constraint FK_LICHBAY_MAYBAY
	foreign key(SOHIEU, MALOAI)
	references MAYBAY
alter table PHANCONG
add
	constraint FK_PHANCONG_NV
	foreign key(MANV)
	references NHANVIEN,
	constraint FK_PHANCONG_LICHBAY
	foreign key(NGAYDI, MACB)
	references LICHBAY
alter table KHANANG
add
	constraint FK_KHANANG_NV
	foreign key(MANV)
	references NHANVIEN,
	constrainT FK_KHANANG_LOAIMB
	foreign key(MALOAI)
	references LOAIMB
alter table MAYBAY
add
	constraint FK_MAYBAY_KHANANG
	foreign key(MALOAI)
	references LOAIMB