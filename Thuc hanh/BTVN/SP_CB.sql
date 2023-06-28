/****************Phần 1: SP Tính toán (câu a --> câu i)****************/
-- Cau a
create procedure printHelloWorld
as
	print 'Hello World'
go
-- Cau b
create procedure printSumTwoNumbers @a int, @b int
as
	print @a + @b
go
exec printSumTwoNumbers 11, 14
go
-- Cau c
create procedure sumTwoNumbers @a int, @b int, @kq int out
as
	set @kq = @a + @b
go
declare @sum int
exec sumTwoNumbers 11, 4, @sum out
print @sum
go
-- Cau d
create procedure printSumThreeNumbers @a int, @b int, @c int
as
	declare @temp int
	declare @kq int
	exec sumTwoNumbers @a, @b, @temp out
	exec sumTwoNumbers @temp, @c, @kq out
	print @kq
go
exec printSumThreeNumbers 5, 10, 15
go
-- Cau e
create procedure printSumOfList @m int, @n int
as
	declare @sum int, @i int
	set @sum = 0
	set @i = @m
	while (@i <= @n)
	begin
		set @sum = @sum + @i
		set @i = @i + 1
	end
	print @sum
go
exec printSumOfList 1, 100
go
-- Cau f
create procedure checkPrime @x int, @kq int out
as
	if (@x < 2) begin set @kq = 0 return end
	declare @check int, @i int
	set @check = 1
	set @i = 2
	while (@i <= sqrt(@x))
	begin
		if (@x % @i = 0) begin set @check = 0 break end
		set @i = @i + 1		
	end
	set @kq = @check
go
-- Cau g
create procedure sumOfPrimes @m int, @n int
as 
	declare @sum int, @i int, @check int
	set @sum = 0
	set @i = @m
	while (@i <= @n)
	begin
		exec checkPrime @i, @check out
		if (@check = 1) set @sum = @sum + @i
		set @i = @i + 1
	end
	print @sum
go
exec sumOfPrimes 1, 10
go
-- Cau h
create procedure GCD @a int, @b int, @kq int out
as
	declare @bounder int, @i int
	if (@a > @b) set @bounder = @b
	else set @bounder = @a

	set @i = 1
	while (@i <= @bounder)
	begin
		if (@a % @i = 0 and @b % @i = 0) set @kq = @i
		set @i = @i + 1
	end
go
declare @kq int
exec GCD 60, 24, @kq out
print @kq
go
-- Cau i
create procedure LCM @a int, @b int, @kq int out
as
	declare @bounder int, @i int
	set @bounder = @a * @b
	set @i = @a
	 while (@i <= @bounder)
	 begin
		if (@i % @a = 0 and @i % @b = 0) 
		begin set @kq = @i break end
		set @i = @i + 1
	 end
go
declare @kq int
exec LCM 15, 12, @kq out
print @kq
go
-- Drop Section
drop procedure printHelloWorld
drop procedure printSumTwoNumbers
drop procedure sumTwoNumbers
drop procedure printSumThreeNumbers
drop procedure printSumOfList
drop procedure checkPrime
drop procedure sumOfPrimes
drop procedure GCD
drop procedure LCM


/*******************Phần 2: SP QLDT (câu j --> câu t)****************/
use QL_DT
go
-- Cau j
create procedure xuatTatCaGV
as
	select * from GIAOVIEN
go
exec xuatTatCaGV
go
-- Cau k
create procedure SLDeTaiGVThucHien @magv varchar(5), @kq int out
as
	set @kq = (select count(distinct TG.MADT) 'SLDT'
	from GIAOVIEN GV join THAMGIADT TG on GV.MAGV = TG.MAGV
	where GV.MAGV = @magv
	group by GV.MAGV)
go
declare @kq int
exec SLDeTaiGVThucHien '003', @kq out
print @kq
go
-- Cau l
create procedure xuatThongTinGV @magv varchar(5)
as
	if (exists (select MAGV from GIAOVIEN where MAGV = @magv))
	begin
		declare @ht nvarchar(40), @luong float, @gt nvarchar(3), @ns date, @dc nvarchar(100)
		set @ht = (select HOTEN from GIAOVIEN where @magv = MAGV)
		set @luong = (select LUONG from GIAOVIEN where @magv = MAGV)
		set @gt = (select PHAI from GIAOVIEN where @magv = MAGV)
		set @ns = (select NGSINH from GIAOVIEN where @magv = MAGV)
		set @dc = (select DIACHI from GIAOVIEN where @magv = MAGV)
		declare @sldt int, @sltn int
		exec SLDeTaiGVThucHien @magv, @sldt out
		set @sltn =(select count(distinct NT.TEN) 'SLTN'
					from GIAOVIEN GV join NGUOITHAN NT on NT.MAGV = GV.MAGV
					where GV.MAGV = @magv
					group by GV.MAGV)

		print 'Ho ten: ' + cast(@ht as nvarchar) + '. Luong: ' + cast(@luong as varchar) + '. Phai: ' + cast(@gt as nvarchar) 
		print 'Ngay sinh: ' + cast(@ns as varchar) + '. Dia chi: ' + cast(@dc as nvarchar(100)) 
		print 'So luong de tai tham gia: ' + cast(@sldt as varchar) 
		print 'So luong than nhan: ' + cast(@sltn as varchar)
	end
	else print 'Ma giao vien khong ton tai'
go
exec xuatThongTinGV '002'
go
-- Cau m
create procedure KTGVTonTai @magv varchar(5), @kq int out
as
	if (exists (select MAGV from GIAOVIEN where MAGV = @magv))
		set @kq = 1	-- 1 là tồn tại
	else
		set @kq = 0 -- 0 là không tồn tại
go
-- Cau n
create procedure KTQuyDinhGV @magv varchar(5), @kq int out
as
	declare @mabm nvarchar(5)
	set @mabm = (select MABM from GIAOVIEN where @magv = MAGV)	-- lấy MABM của GV truyền vào

	if(not exists(select * from THAMGIADT TG join DETAI DT on TG.MADT = DT.MADT join GIAOVIEN GV on DT.GVCNDT = GV.MAGV
	where @magv = TG.MAGV and @mabm != GV.MABM))
	-- Tìm những dòng mà tại đó, MABM của GVCNDT khác với MABM của @magv tham gia
	-- Nếu không tồn tại dòng nào, tức là không có đề tài nào mà GVCNDT khác MABM với MABM của @magv, nghĩa là đúng quy định
	-- 1 là đúng, 0 là sai
		set @kq = 1	
	else
		set @kq = 0	
go
-- Cau o
create procedure ThemPhanCongGV @magv varchar(5),@madt varchar(3), @stt int, @phucap float, @kq nvarchar(40)
as
	declare @checkGV int, @checkCV int, @checkTG int
	
	-- Kiểm tra tồn tại GV
	exec KTGVTonTai @magv, @checkGV out
	
	-- Kiểm tra tồn tại CV
	if(exists(select * from CONGVIEC where @madt = MADT and @stt = SOTT))
		set @checkCV = 1
	else
		set @checkCV = 0
	
	-- Nếu 2 cái trên thỏa, kiểm tra ngày BD và ngày KT hợp lệ hay ko
	-- Bằng cách coi coi có dòng nào mà khớp MADT, STT và thgian tham gia > 0
	if(@checkGV = 1 and @checkCV = 1)
	begin
		if(exists(select * from CONGVIEC where @madt = MADT and @stt = SOTT and datediff(day, NGAYKT, NGAYBD) > 0))
			set @checkTG = 1
		else
			set @checkTG = 0
	end
	
	-- Nếu tất cả thỏa, tiến hành thêm. Nếu không, in thông báo lỗi
	if(@checkGV = 1 and @checkCV = 1 and @checkTG = 1)
	begin
		insert THAMGIADT values (@magv, @madt, @stt, @phucap, @kq)
		print 'Them phan cong cho giao vien thanh cong'
	end
	else print 'Khong the them phan cong cho giao vien nay'
go
-- Cau p
create procedure XoaGV @magv varchar(5)
as
	declare @checkGV int
	exec KTGVTonTai @magv, @checkGV out
	if (@checkGV = 0) print 'Khong the xoa do ma giao vien khong ton tai'
	else
		begin
			declare @sldt int, @sltn int
			exec SLDeTaiGVThucHien @magv, @sldt out
			set @sltn =(select count(distinct NT.TEN) 'SLTN'
						from GIAOVIEN GV join NGUOITHAN NT on NT.MAGV = GV.MAGV
						where GV.MAGV = @magv group by GV.MAGV)
			if(@sldt > 0) print 'Khong the xoa do giao vien co tham gia de tai'
			if(@sltn > 0) print 'Khong the xoa do giao vien co than nhan'
			if(@sldt = 0 and @sltn = 0)
			begin
				delete GIAOVIEN where @magv = MAGV
				print 'Xoa giao vien thanh cong'
			end
		end
go
-- Cau q
-- Cau r
create procedure KT2GV @magv1 varchar(5), @magv2 varchar(5), @kq int out
as
	declare @checkTBM int
	-- Kiểm tra xem GV1 có là trưởng bm của GV2 ko
	if(@magv1 = (select TRUONGBM from BOMON where MABM = (select MABM from GIAOVIEN where @magv2 = MAGV))) 
	begin
		declare @luong1 float, @luong2 float
		-- Lấy lương của GV1 và GV2, nếu lương1 > lương2 thì kq = 1 (đúng), ngược lại = 0 (sai)
		set @luong1 = (select LUONG from GIAOVIEN where @magv1 = MAGV)
		set @luong2 = (select LUONG from GIAOVIEN where @magv2 = MAGV)
		if (@luong1 > @luong2)
			set @kq = 1
		else
			set @kq = 0
	end
go
-- Cau s
create procedure ThemGV @magv varchar(5), @ht nvarchar(40), @l float, @gt nvarchar(3), @ns datetime, 
						@dc nvarchar(100), @gvql varchar(5), @mabm nvarchar(5)
as
	if(not exists (select * from GIAOVIEN where HOTEN = @ht) and @l > 0 and datediff(year, getdate(), @ns) > 18)
		insert GIAOVIEN values (@magv, @ht, @l, @gt, @ns, @dc, @gvql, @mabm)
	else
		print 'Khong the them giao vien nay'
go
-- Cau t
-- Drop Section
drop procedure xuatTatCaGV
drop procedure SLDeTaiGVThucHien
drop procedure xuatThongTinGV
drop procedure KTGVTonTai
drop procedure KTQuyDinhGV
drop procedure ThemPhanCongGV
drop procedure XoaGV
drop procedure KT2GV
drop procedure ThemGV

/*******************Phần 3: QLKS****************/
use master
go
if DB_ID('QL_DP') is not null drop database QL_DP
go
create database QL_DP
go
use QL_DP
go
create table PHONG
(
	MAPHONG varchar(5),
	TINHTRANG nvarchar(5) check (TINHTRANG = N'Rảnh' or TINHTRANG = N'Bận'),
	LOAIPHONG nvarchar(10),
	DONGIA float

	constraint PK_PHONG 
	primary key (MAPHONG)
)
create table KHACHHANG
(
	MAKH varchar(5),
	HOTEN nvarchar(40),
	DIACHI nvarchar(60),
	DTH varchar(11)

	constraint PK_KHACHHANG
	primary key (MAKH)
)
create table DATPHONG
(
	MADP int,
	MAKH varchar(5),
	MAPHONG varchar(5),
	NGAYDP date,
	NGAYTRA date,
	THANHTIEN float

	constraint PK_DATPHONG 
	primary key (MADP)
)

insert PHONG
values ('B0101', N'Bận', N'Thường', 200000), ('B0102', N'Rảnh', N'Thường', 200000), ('B0103', N'Rảnh', N'Thường', 200000), 
('P0101', N'Rảnh', N'Cao cấp', 350000), ('P0102', N'Rảnh', N'Cao cấp', 350000), ('P0103', N'Bận', N'Cao cấp', 350000), 
('V0101', N'Rảnh', N'VIP', 500000), ('V0102', N'Bận', N'VIP', 500000), ('V0103', N'Bận', N'VIP', 500000), ('V0104', N'Rảnh', N'VIP', 500000)

insert KHACHHANG
values ('AA001', N'Đoàn Ngọc Minh Tâm', N'Quận 1, TPHCM', '0984827849'),
('AA002', N'Lê Nguyễn Tâm Nhi', N'Gò Vấp, TP HCM', '0376837581'),
('AA003', N'Lâm Chấn Thiên', N'Quận 9, TP HCM', '0919274574'),
('AA004', N'Đường Khả Nhi', N'Cầu Giấy, Hà Nội', '0383978473'),
('AA005', N'Mã Anh Trúc', N'Đống Đa, Hà Nội', '0838461794')

insert DATPHONG values (0, null, null, null, null, null)

select * from PHONG
select * from KHACHHANG
select * from DATPHONG
alter table DATPHONG
add
	constraint FK_MAKH
	foreign key (MAKH) 
	references KHACHHANG(MAKH),
	constraint FK_MAPHONG 
	foreign key (MAPHONG) 
	references PHONG(MAPHONG)
go

create procedure spDatPhong @makh varchar(5), @maph varchar(5), @ngaydat date
as
	declare @check int = 1
	-- Nếu không tồn tại dòng nào có MAKH trùng với mã truyền vào, check = 0
	if (not exists(select * from KHACHHANG where @makh = MAKH)) set @check = 0

	-- Nếu không tồn tại phòng nào có MAPHONG trùng với mã truyền vào, check = 0
	if (not exists(select * from PHONG where @maph = MAPHONG)) set @check = 0

	-- Nếu phòng muốn đặt bận, check = 0
	if ((select TINHTRANG from PHONG where @maph = MAPHONG) = N'Bận') set @check = 0

	-- Nếu check vẫn là 1, tức dữ liệu truyền vào hợp lệ
	if (@check = 1)
	begin
		-- MADP mới = max MADP trong bảng + 1
		declare @madp int = (select max(MADP) from DATPHONG) + 1
		-- Insert dữ liệu mới vào bảng DATPHONG
		insert DATPHONG values (@madp, @makh, @maph, @ngaydat, null, null)
		-- Update tình trạng phòng cho phòng được đặt
		update PHONG set TINHTRANG = N'Bận' where @maph = MAPHONG
	end
	else print 'Du lieu khong hop le. Khong the dat phong!' -- Báo lỗi khi check = 0
go
create procedure spTraPhong @madp varchar(5), @makh varchar(5)
as
	declare @check int = 1

	-- Kiểm tra xem trong bảng DATPHONG có MADP và MAKH truyền vào hay không, nếu không check = 0
	if (not exists(select * from DATPHONG where @madp = MADP and @makh = MAKH)) set @check = 0

	-- Nếu check = 1 tức là hợp lệ, thực hiện trả phòng
	if (@check = 1)
	begin
		-- Lấy ngày đặt phòng và ngày trả phòng
		declare @ngaytra date = getdate(), @ngaydat date = (select NGAYDP from DATPHONG where @madp = MADP and @makh = MAKH)
		-- Tính số ngày mượn phòng
		declare @songay int = datediff(day, @ngaytra, @ngaydat)
		-- Lấy mã phòng để sau này dễ tính toán và cập nhật
		declare @maph varchar(5) = (select MAPHONG from DATPHONG where @madp = MADP and @makh = MAKH)
		-- Thành tiền = Số ngày mượn * Đơn giá phòng
		declare @thanhtien float = @songay * (select DONGIA from PHONG where MAPHONG = @maph)

		-- Cập nhật ngày trả và thành tiền trong bảng DATPHONG
		update DATPHONG set NGAYTRA = @ngaytra, THANHTIEN = @thanhtien where @madp = MADP and @makh = MAKH
		-- Cập nhật tình trạng phòng trong bảng PHONG
		update PHONG set TINHTRANG = N'Rảnh' where MAPHONG = @maph
	end
	else print 'Du lieu khong hop le. Khong the tra phong!' -- Báo lỗi khi check = 0
go

drop procedure spDatPhong
drop procedure spTraPhong