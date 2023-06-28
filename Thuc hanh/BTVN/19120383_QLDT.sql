use master
go
if DB_ID('QL_DT') is not null
	drop database QL_DT
go
create database QL_DT
go
use QL_DT
go
set dateformat dmy
create table GIAOVIEN
(
	MAGV varchar(5), 
	HOTEN nvarchar(40),
	LUONG float,
	PHAI nvarchar(3),
	NGSINH datetime,
	DIACHI nvarchar(100), 
	GVQLCM varchar(5),
	MABM nvarchar(5)

	constraint PK_MAGV
	primary key(MAGV)
)
create table BOMON
(
	MABM nvarchar(5),
	TENBM nvarchar(40), 
	PHONG varchar(5),
	DIENTHOAI varchar(12),
	TRUONGBM varchar(5),
	MAKHOA varchar(4),
	NGAYNHANCHUC datetime

	constraint PK_MABM
	primary key (MABM)

)
create table KHOA
(
	MAKHOA varchar(4),
	TENKHOA nvarchar(40),
	NAMTL int,
	PHONG varchar(5),
	DIENTHOAI varchar(12),	
	TRUONGKHOA varchar(5),
	NGAYNHANCHUC datetime

	constraint PK_MAKHOA
	primary key (MAKHOA)
)
create table GV_DT
(
	MAGV varchar(5),
	DIENTHOAI varchar(12)

	constraint PK_GV_DT
	primary key(MAGV, DIENTHOAI)
)
create table THAMGIADT
(
	MAGV varchar(5), 
	MADT varchar(3),
	STT int,
	PHUCAP float,
	KETQUA nvarchar(40)

	constraint PK_TGIA_DT
	primary key(MAGV, MADT, STT)
)
create table DETAI
(
	MADT varchar(3),
	TENDT nvarchar(100), 
	CAPQL nvarchar(40),
	KINHPHI float, 
	NGAYBD datetime,
	NGAYKT datetime,
	MACD nvarchar(4),
	GVCNDT varchar(5)
	
	constraint PK_DETAI
	primary key(MADT)
)
create table CHUDE
(
	MACD nvarchar(4),
	TENCD nvarchar(50)

	constraint PK_CHUDE
	primary key(MACD)
)
create table CONGVIEC
(
	MADT varchar(3),
	SOTT int, 
	TENCV nvarchar(40),
	NGAYBD datetime,
	NGAYKT datetime

	constraint PK_CV
	primary key(MADT, SOTT)
)
create table NGUOITHAN
(
	MAGV varchar(5),
	TEN nvarchar(20),
	NGSINH datetime,
	PHAI nvarchar(3)

	constraint PK_NGTHAN
	primary key(MAGV, TEN)
)

insert DETAI
values ('001', N'HTTT quản lý các trường ĐH', N'ĐHQG', 20, '20/10/2007', '20/10/2008', N'QLGD', '002'),
('002', N'HTTT quản lý giáo vụ cho một Khoa', N'Trường', 20, '12/10/2000', '12/10/2001', N'QLGD', '002'),
('003', N'Nghiên cứu chế tạo sợi Nanô Platin', N'ĐHQG', 300, '15/5/2008', '15/5/2010', N'NCPT', '005'),
('004', N'Tạo vật liệu sinh học bằng màng ối người', N'Nhà nước', 100, '1/1/2007', '31/12/2009', N'NCPT', '004'),
('005', N'Ứng dụng hóa học xanh', N'Trường', 200, '10/10/2003', '10/12/2004', N'ƯDCN', '007'),
('006', N'Nghiên cứu tế bào gốc', N'Nhà nước', 4000, '20/10/2006', '20/10/2009', N'NCPT', '004'),
('007', N'HTTT quản lý thư viện ở các trường ĐH', N'Trường', 20, '10/5/2009', '10/5/2010', N'QLGD', '001')

insert GV_DT
values ('001', '0838912112'), ('001', '0903123123'), ('002', '0913454545'), ('003', '0838121212'), ('003', '0903656565'), ('003', '0937125125'), 
('006', '0937888888'), ('008', '0653717171'), ('008', '0913232323')

insert BOMON
values (N'CNTT', N'Công nghệ tri thức', 'B15', '0838126126', null, 'CNTT', null),
(N'HHC', N'Hóa hữu cơ', 'B44', '848222222', null, 'HH', null),
(N'HL', N'Hóa lý', 'B42', '0838878787', null, 'HH', null),
(N'HPT', N'Hóa phân tích', 'B43', '0838777777', '007', 'HH', '15/10/2007'),
(N'HTTT', N'Hệ thống thông tin', 'B13', '0838125125', '002', 'CNTT', '20/9/2004'),
(N'MMT', N'Mạng máy tính', 'B16', '0838676767', '001', 'CNTT', '15/5/2005'),
(N'SH', N'Sinh hóa', 'B33', '0838898989', null, 'SH', null),
(N'VLĐT', N'Vật lý điện tử', 'B23', '0838234234', null, 'VL', null),
(N'VLƯD', N'Vật lý ứng dụng', 'B24', '0838454545', '005', 'VL', '18/2/2006'),
(N'VS', N'Vi sinh', 'B32', '0838909090', '004', 'SH', '1/1/2007')

insert GIAOVIEN
values ('001', N'Nguyễn Hoài An', 2000, N'Nam', '15/02/1973', N'25/3 Lạc Long Quân, Q.10, TP HCM', null, N'MMT'),
('002', N'Trần Trà Hương', 2500, N'Nữ', '20/06/1960', N'125 Trần Hưng Đạo, Q.1, TP HCM', null, N'HTTT'),
('003', N'Nguyễn Ngọc Ánh', 2200, N'Nữ', '11/05/1975', N'12/21 Võ Văn Ngân Thủ Đức, TP HCM', '002', N'HTTT'),
('004', N'Trương Nam Sơn', 2300, N'Nam', '20/6/1959', N'215 Lý Thường Kiệt, TP Biên Hòa', null, N'VS'),
('005', N'Lý Hoàng Hà', 2500, N'Nam', '23/10/1954', N'22/5 Nguyễn Xí, Q.Bình Thạnh, TP HCM', null, N'VLĐT'),
('006', N'Trần Bạch Tuyết', 1500, N'Nữ', '20/05/1980', N'127 Hùng Vương, TP Mỹ Tho', '004', N'VS'),
('007', N'Nguyễn An Trung', 2100, N'Nam', '05/06/1976', N'234 3/2, TP Biên Hòa', null, N'HPT'),
('008', N'Trần Trung Hiếu', 1800, N'Nam', '06/08/1977', N'22/11 Lý Thường Kiệt, TP Mỹ Tho', '007', N'HPT'),
('009', N'Trần Hoàng Nam', 2000, N'Nam', '22/11/1975', N'234 Trấn Não, An Phú, TP HCM', '001', N'MMT'),
('010', N'Phạm Nam Thanh', 1500, N'Nam', '12/12/1980', N'221 Hùng Vương, Q.5, TP HCM', '007', N'HPT')

insert KHOA
values ('CNTT', N'Công nghệ thông tin', 1995, 'B11', '0838123456', '002', '20/2/2005'),
('HH', N'Hóa học', 1980, 'B41', '0838456456', '007', '15/10/2001'),
('SH', N'Sinh học', 1980, 'B31', '0838454545', '004', '11/10/2000'),
('VL', N'Vật lý', 1976, 'B21', '0838223223', '005', '18/9/2003')

insert CHUDE
values (N'NCPT', N'Nghiên cứu phát triển'),
(N'QLGD', N'Quản lý giáo dục'),
(N'ƯDCN', N'Ứng dụng công nghệ')

insert CONGVIEC
values ('001', 1, N'Khởi tạo và lập kế hoạch', '20/10/2007', '20/12/2008'),
('001', 2, N'Xác định yêu cầu', '21/12/2008', '21/3/2008'),
('001', 3, N'Phân tích hệ thống', '22/3/2008', '22/5/2008'),
('001', 4, N'Thiết kế hệ thống', '23/5/2008', '23/6/2008'),
('001', 5, N'Cài đặt thử nghiệm', '24/6/2008', '20/10/2008'),
('002', 1, N'Khởi tạo và lập kế hoạch', '10/5/2009', '10/7/2009'),
('002', 2, N'Xác định yêu cầu', '11/7/2009', '11/10/2009'),
('002', 3, N'Phân tích hệ thống', '12/10/2009', '20/12/2009'),
('002', 4, N'Thiết kế hệ thống', '21/12/2009', '22/3/2010'),
('002', 5, N'Cài đặt thử nghiệm', '23/3/2010', '10/5/2010'),
('006', 1, N'Lấy mẫu', '20/10/2006', '20/2/2007'),
('006', 2, N'Nuôi cấy', '21/2/2007', '21/8/2008')

insert THAMGIADT
values ('001', '002', 1, 0, null), ('001', '002', 2, 2, null), ('002', '001', 4, 2, N'Đạt'), ('003', '001', 1, 1, N'Đạt'),
('003', '001', 2, 0, N'Đạt'), ('003', '001', 4, 1, N'Đạt'), ('003', '002', 2, 0, null), ('004', '006', 1, 0, N'Đạt'), 
('004', '006', 2, 1, N'Đạt'), ('006', '006', 2, 1.5, N'Đạt'), ('009', '002', 3, 0.5, null), ('009', '002', 4, 1.5, null)

insert NGUOITHAN
values ('001', N'Hùng', '14/1/1990', N'Nam'), ('001', N'Thủy', '8/12/1994', N'Nữ'), ('003', N'Hà', '3/9/1998', N'Nữ'), 
('003', N'Thu', '3/9/1998', N'Nữ'), ('007', N'Mai', '26/3/2003', N'Nữ'), ('007', N'Vy', '14/2/2000', N'Nữ'),
('008', N'Nam', '6/5/1991', N'Nam'), ('009', N'An', '19/8/1996', N'Nam'), ('010', N'Nguyệt', '14/1/2006', N'Nữ')


alter table GIAOVIEN
add
	constraint FK_GVQLCM
	foreign key(GVQLCM)
	references GIAOVIEN,

	constraint FK_GV_BM
	foreign key(MABM)
	references BOMON
alter table BOMON
add
	constraint FK_TRGBM
	foreign key (TRUONGBM)
	references GIAOVIEN,

	constraint FK_BM_MAKHOA
	foreign key(MAKHOA)
	references KHOA
alter table KHOA
add
	constraint FK_TRGKHOA_GV
	foreign key (TRUONGKHOA)
	references GIAOVIEN
alter table GV_DT
add
	constraint FK_GVDT_MAGV
	foreign key (MAGV)
	references GIAOVIEN
alter table NGUOITHAN
add
	constraint FK_NGTHAN_GV
	foreign key(MAGV)
	references GIAOVIEN
alter table THAMGIADT
add
	constraint FK_THGIADT_MAGV
	foreign key(MAGV)
	references GIAOVIEN,

	constraint FK_THGIADT_CV
	foreign key(MADT, STT)
	references CONGVIEC
alter table CONGVIEC
add
	constraint FK_CVIEC_DT
	foreign key(MADT)
	references DETAI
alter table DETAI
add
	constraint FK_DT_CD
	foreign key(MACD)
	references CHUDE,

	constraint FK_GVCNDT_GV
	foreign key(GVCNDT)
	references GIAOVIEN
