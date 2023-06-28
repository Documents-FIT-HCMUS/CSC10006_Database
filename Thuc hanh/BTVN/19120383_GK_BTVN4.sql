use master
go
if DB_ID('QL_DIEM_THAM_QUAN') is not null
	drop database QL_DIEM_THAM_QUAN
go
create database QL_DIEM_THAM_QUAN
go
use QL_DIEM_THAM_QUAN
go
create table TINH_THANH
(
	QuocGia varchar(5),
	MaTinhThanh varchar(5),
	TenTT nvarchar(30),
	DanSo int,
	DienTich float

	constraint PK_TINH_THANH
	primary key(MaTinhThanh)
)
create table DIEM_THAM_QUAN
(
	MaDTQ varchar(10),
	TenDTQ nvarchar(30),
	TinhThanh varchar(5),
	QuocGia varchar(5),
	DacDiem nvarchar(50)

	constraint PK_DTQ
	primary key(MaDTQ)
)
create table QUOC_GIA
(
	MaQG varchar(5),
	TenQG nvarchar(20),
	ThuDo varchar(5),
	DanSo int,
	DienTich float

	constraint PK_QUOC_GIA
	primary key(MaQG)
)

alter table TINH_THANH
add
	constraint FK_TT_QG
	foreign key(QuocGia)
	references QUOC_GIA
alter table DIEM_THAM_QUAN
add
	constraint FK_DTQ_TT
	foreign key(TinhThanh)
	references TINH_THANH,

	constraint FK_DTQ_QG
	foreign key(QuocGia)
	references QUOC_GIA
alter table QUOC_GIA
add
	constraint FK_QG_TT
	foreign key(ThuDo)
	references TINH_THANH

insert QUOC_GIA
values
('QG001', N'Việt Nam', null, 115000000, 331688.00),
('QG002', N'Nhật Bản', null, 129500000, 337834.00)

insert TINH_THANH
values
('QG001', 'TT001', N'Hà Nội', 2500000, 927.39),
('QG001', 'TT002', N'Huế', 5344000, 5009.00),
('QG002', 'TT003', N'Tokyo', 12084000, 2187.00)

update QUOC_GIA set ThuDo = 'TT001' where MaQG = 'QG001'
update QUOC_GIA set ThuDo = 'TT003' where MaQG = 'QG002'

insert DIEM_THAM_QUAN
values
('DTQ001', N'Văn Miếu', 'TT001', 'QG001', N'Di tích cổ'),
('DTQ002', N'Hoàng lăng', 'TT002', 'QG001', N'Di tích cổ'),
('DTQ003', N'Tháp Tokyo', 'TT003', 'QG002', N'Công trình hiện đại')


-- TRUY VẤN
select DTQ.MaDTQ, DTQ.TenDTQ
from DIEM_THAM_QUAN DTQ join TINH_THANH TT on DTQ.TinhThanh = TT.MaTinhThanh join QUOC_GIA QG on DTQ.QuocGia = QG.MaQG
where TT.DienTich > QG.DienTich * 0.01

select QG.MaQG, QG.TenQG
from QUOC_GIA QG join TINH_THANH TT on QG.MaQG = TT.QuocGia
group by QG.MaQG, QG.TenQG
having count(TT.MaTinhThanh) > 30