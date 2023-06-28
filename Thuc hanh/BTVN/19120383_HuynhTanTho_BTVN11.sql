use QL_DT
go
-- Cau 1
create procedure spPhanCong @magv varchar(5), @madt varchar(3), @stt int, @phucap float, @kq nvarchar(40)
as
	if (not exists (select * from GIAOVIEN where @magv = MAGV))
		return -1
	if (not exists (select * from DETAI where @madt = MADT))
		return -2
	if ((select count(*) from THAMGIADT where @madt = MADT and @magv = MAGV) >= 3)
		return -3
	if ((select count(distinct MAGV) from THAMGIADT where @magv != MAGV and @madt = MADT) >= 3)
		return -4
	insert THAMGIADT values (@magv, @madt, @stt, @phucap, @kq)
	return 1
go
exec spPhanCong '007', '001', 2, 20, N'Đạt'
exec spPhanCong '006', '002', 1, 10, N'Đạt'
exec spPhanCong '003', '001', 2, 5, N'Không đạt'
go
-- Cau 2
create procedure spXoaGV @magv varchar(5)
as
	-- Kiem tra giao vien ton tai
	if (not exists (select * from GIAOVIEN where @magv = MAGV))
		print N'Giáo viên không tồn tại'
	else
	begin
		-- Kiem tra giao vien co la truong khoa hay ko
		if (exists (select * from KHOA where @magv = TRUONGKHOA))
			update KHOA set TRUONGKHOA = null where TRUONGKHOA = @magv
		-- Kiem tra giao vien co la truong bo mon hay ko
		if (exists (select * from BOMON where @magv = TRUONGBM))
			update BOMON set TRUONGBM = null where TRUONGBM = @magv
		-- Kiem tra giao vien co quan ly giao vien nao khac hay ko
		if (exists (select * from GIAOVIEN where @magv = GVQLCM))
			update GIAOVIEN set GVQLCM = null where GVQLCM = @magv
		-- Kiem tra giao vien co chu nhiem de tai nao hay ko
		if (exists (select * from DETAI where @magv = GVCNDT))
			update DETAI set GVCNDT = null where GVCNDT = @magv
		-- Kiem tra giao vien co tham gia de tai nao hay ko
		if (exists (select * from THAMGIADT where @magv = MAGV))
			delete THAMGIADT where MAGV = @magv
		-- Kiem tra giao vien co than nhan nao ko
		if (exists (select * from NGUOITHAN where @magv = MAGV))
			delete NGUOITHAN where @magv = MAGV
		
		-- Xoa giao vien
		delete GIAOVIEN where MAGV = @magv
		print N'Xóa thành công'
	end
go
exec spXoaGV '001'
exec spXoaGV '015'
go
-- Cau 3
create procedure spCapNhatTruongBM @magv varchar(5), @mabm nvarchar(5), @ngaync datetime
as
	-- Kiem tra ton tai ma giao vien hay ko
	if (not exists (select * from GIAOVIEN where @magv = MAGV))
		return -1
	-- Kiem tra ton tai ma bomon hay ko
	if (not exists (select * from BOMON where @mabm = MABM))
		return -2
	-- Lay MABM cua giao vien muon lam truongbm, so sanh voi MABM mà giao vien nay sap lam truongbm
	if (@mabm != (select MABM from GIAOVIEN where @magv = MAGV))
		return -3
	-- Lay het truongkhoa ra xem MAGV co nam trong do ko
	if (@magv in (select TRUONGKHOA from KHOA))
		return -4
	-- Tinh tuoi cua giao vien do xem co > 22 hay ko
	if ((select datediff(year, NGSINH, getdate()) from GIAOVIEN where @magv = MAGV) <= 22)
		return -5
	update BOMON set TRUONGBM = @magv, NGAYNHANCHUC = @ngaync where MABM = @mabm
	return 1
go
exec spCapNhatTruongBM '002', N'HTTT', '10/12/2020'
exec spCapNhatTruongBM '005', N'HPT', '5/5/2019'
exec spCapNhatTruongBM '090', N'CNTT', '7/11/2017'
go
-- Cau 4
create procedure spThemCongViec @madt varchar(3), @tencv nvarchar(4), @ngaybd datetime, @ngaykt datetime
as
	declare @check int = 1
	-- Kiem tra de tai ton tai hay ko
	if (not exists (select * from DETAI where @madt = MADT))
		begin print N'Đề tài không tồn tại' set @check = 0 end
	-- Kiem tra ngaybd co nho hon ngaykt hay ko
	if (@ngaybd >= @ngaykt)
		begin print N'Ngày bắt đầu phải nhỏ hơn ngày kết thúc' set @check = 0 end
	-- Kiem tra ngaybd co nho hon ngay hien tai hay ko
	if (@ngaybd <= getdate())
		begin print N'Ngày bắt đầu phải lớn hơn ngày hiện hành' set @check = 0 end
	-- Kiem tra so luong cong viec cua madt co >= 10 hay ko
	if ((select count(*) from CONGVIEC where @madt = MADT) >= 10)
		begin print N'Vượt quá số công việc tối đa cho đề tài' set @check = 0 end

	-- Neu khong co loi gi, them cong viec
	if (@check = 1)
	begin
		-- STT moi cho cong viec trong de tai
		declare @stt int
		-- Neu de tai chua co cong viec nao, stt cua cong viec them vao la 1
		if (not exists (select * from CONGVIEC where @madt = MADT))
			set @stt = 1
		-- Neu da co cong viec, lay max(STT) + 1
		else set @stt = 1 + (select max(SOTT) from CONGVIEC where @madt = MADT)
		-- Them vao bang CONGVIEC
		insert CONGVIEC values (@madt, @stt, @tencv, @ngaybd, @ngaykt)
		print N'Thêm thành công'
	end
go
exec spThemCongViec '001', N'Đo đạc', '10/12/2020', '01/12/2021'
exec spThemCongViec '002', N'Kiểm định', '6/9/2021', '9/9/2021'
exec spThemCongViec '003', N'Kiểm tra', '8/1/2021', '2/1/2022'
go
-- Drop Section
drop procedure spPhanCong
drop procedure spXoaGV
drop procedure spCapNhatTruongBM
drop procedure spThemCongViec
