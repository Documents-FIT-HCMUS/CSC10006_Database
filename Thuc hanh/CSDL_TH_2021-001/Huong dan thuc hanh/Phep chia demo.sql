--VD1: Tìm giáo viên (MÃ, HỌ TÊN) tham gia tất cả đề tài do giáo viên 002 làm chủ nhiệm
/* Xác định KQ, S, R? KQ = R/S ==> R=KQ(MaGV)xS(MaDT)
   KQ: thông tin cần tìm 
		==> Giáo viên [xxx
   S: tất cả S 
		==> Đề tài [GVCNDT = '002']
   R: có thông tin cả KQ lẫn S và thể hiện đúng mối quan hệ (trong TH có nhiều bảng chứa thông tin KQ và S 
		==> ThamGiaDT
*/
SELECT * FROM DETAI
/*C1: Dùng not exists
SELECT * FROM KQ 
WHERE not exists 
	(SELECT * FROM S 
	 WHERE not exists 
		 (SELECT * FROM R 
		  WHERE (đk kết R với S) and (đk kết R với KQ)))
*/
SELECT GV.MAGV, GV.HOTEN FROM GIAOVIEN GV
WHERE not exists 
	(SELECT * FROM DETAI DT
	 WHERE DT.GVCNDT = '002'
	 AND not exists 
		 (SELECT * FROM THAMGIADT TG 
		  WHERE (TG.MAGV = GV.MAGV) and (TG.MADT = DT.MADT)))

/*C2: Dùng except
SELECT * FROM KQ 
WHERE not exists (
	(SELECT A, B FROM S) 
	EXCEPT		
	(SELECT C, D FROM R 
		WHERE (đk kết R với KQ))
)
Lưu ý: EXCEPT là phép toán trừ trên tập hợp ==> A, B và C, D phải lần lượt tương ứng về KDL và ngữ nghĩa
*/
SELECT GV.MAGV, GV.HOTEN FROM GIAOVIEN GV
WHERE not exists (
	(SELECT DT.MADT FROM DETAI DT --tat ca de tai do 002 chu nhiem
	 WHERE DT.GVCNDT = '002')
	 EXCEPT 
	(SELECT TG.MADT FROM THAMGIADT TG, DETAI DT -- de tai co gvcndt 002 co gv tham gia
	 WHERE TG.MAGV = GV.MAGV and TG.MADT = DT.MADT and DT.GVCNDT = '002')
)

/*C3: Dùng group by KQ(A) = R(AB)/S(B)
SELECT KQ.A FROM R, KQ, S
WHERE ...
GROUP BY KQ.A
HAVING COUNT(DISTINCT R.B) = (SELECT COUNT(DISTINCT S.B) FROM S
							  WHERE ...)
*/
SELECT GV.MAGV, GV.HOTEN FROM THAMGIADT TG, GIAOVIEN GV, DETAI DT
WHERE GV.MAGV = TG.MAGV and TG.MADT = DT.MADT and DT.GVCNDT = '002'
GROUP BY GV.MAGV, GV.HOTEN
HAVING COUNT(DISTINCT TG.MADT) = (SELECT COUNT(DISTINCT DT_002.MADT) FROM DETAI DT_002
							      WHERE DT_002.GVCNDT = '002')



/*VD2: Tìm trưởng bộ môn của bộ môn có giáo viên tham gia tất cả các công việc của đề tài "Nghiên cứu tế bào gốc"*/

/* Xác định KQ, S, R? ==> từ đoạn mô tả "giáo viên tham gia tất cả công việc ...
   KQ: thông tin cần tìm 
		==> Giáo viên gv(magv) --> Trưởng bm của gv này
   S: tất cả S (madt, stt)
		==> Công việc [thuộc Đề tài tên "Nghiên cứu tế bào gốc..."] ==> S cần kết thêm bảng khác để kiểm tra điều kiện
   R: có thông tin cả KQ lẫn S và thể hiện đúng mối quan hệ (trong TH có nhiều bảng chứa thông tin KQ và S 
		==> ThamGiaDT --> Lưu ý: S quan tâm là công việc (madt, stt), ko phải đề tài
*/

/*Cách 1: not exists*/
SELECT TBM.*FROM GIAOVIEN KQ, BOMON BM, GIAOVIEN TBMWHERE TBM.MAGV = BM.TRUONGBM AND KQ.MABM = BM.MABM 	AND NOT EXISTS (	--TÌM DS CÔNG VIỆC S (CỦA DETAI ...) MÀ GIÁO VIÊN KQ KHÔNG THAM GIA BẰNG CÁCH DÙNG KIỂM TRA KHÔNG TỒN TẠI NOT EXISTS	----1/KHÔNG CÓ DỮ LIỆU TRẢ RA --> NOT EXISTS TRẢ VỀ TRUE --> GIÁO VIÊN KQ THAM GIA TẤT CẢ	----2/CÓ ÍT NHẤT 1 DÒNG CÔNG VIỆC TRẢ RA --> NOT EXISTS TRẢ VỀ FALSE --> DÒNG CV NÀY LÀ CV GIÁO VIÊN KQ KHÔNG THAM GIA		SELECT S.MADT, S.SOTT		FROM CONGVIEC S, DETAI DT		WHERE DT.MADT = S.MADT AND DT.TENDT = N'Nghiên cứu tế bào gốc'		AND NOT EXISTS (			SELECT *			FROM THAMGIADT R			WHERE R.MAGV = KQ.MAGV AND R.MADT = S.MADT and R.STT = S.SOTT		)	)

/*Cách 2: except*/
SELECT TBM.*FROM GIAOVIEN KQ, BOMON BM, GIAOVIEN TBMWHERE TBM.MAGV = BM.TRUONGBM AND KQ.MABM = BM.MABM 	AND NOT EXISTS (	--TÌM DS CÔNG VIỆC S (CỦA DETAI ...) MÀ GIÁO VIÊN KQ KHÔNG THAM GIA BẰNG CÁCH DÙNG PHÉP TRỪ EXCEPT	--CÔNG VIỆC S GIÁO VIÊN KQ KO THAM GIA = TẤT CẢ CÔNG VIỆC S CÓ - CÔNG VIỆC GIÁO VIÊN KQ THAM GIA		(SELECT S.MADT, S.SOTT --DS CÔNG VIỆC S CÓ		 FROM CONGVIEC S, DETAI DT		 WHERE DT.MADT = S.MADT AND DT.TENDT = N'Nghiên cứu tế bào gốc')		EXCEPT		(SELECT R.MADT, R.STT --DS CÔNG VIỆC KQ THAM GIA		 FROM THAMGIADT R		 WHERE R.MAGV = KQ.MAGV)	)

/*Cách 3: group by*/
--đếm số cv của đề tài 'Nghiên cứu...' mà anh KQ tham gia
SELECT TBM.MAGV, TBM.HOTEN FROM GIAOVIEN KQ, THAMGIADT R, DETAI DT, BOMON BM, GIAOVIEN TBMWHERE R.MAGV = KQ.MAGV AND R.MADT = DT.MADT AND DT.TENDT = N'Nghiên cứu tế bào gốc' --KẾT XỬ LÝ CHO PHÉP CHIA	  AND KQ.MABM = BM.MABM AND TBM.MAGV = BM.TRUONGBM --KẾT TÌM TRƯỞNG BỘ MÔNGROUP BY KQ.MAGV, TBM.MAGV, TBM.HOTEN --SO SÁNH (SỐ CÔNG VIỆC MÀ KQ THAM GIA == SỐ CÔNG VIỆC CÓ???)HAVING count(R.MADT) = (SELECT count(S.MADT) AS SLCV_DTNC
						FROM CONGVIEC S, DETAI DT 
						WHERE DT.MADT = S.MADT AND DT.TENDT = N'Nghiên cứu tế bào gốc')


/*VD3: Tìm mã và họ tên giáo viên chủ nhiệm 
đề tài có tất cả trưởng bộ môn của khoa 'Sinh học' tham gia.*/
--KQ (của phép chia): detai(madt)
--S: Bomon(truongbomon), Khoa [khoa sinh hoc] 
--R: thamgiadt(magv, madt)
/*Cách 1: not exists*/
SELECT GV.MAGV, GV.HOTEN FROM GIAOVIEN GV JOIN DETAI DT ON DT.GVCNDT = GV.MAGVWHERE NOT EXISTS(				/*TÌM TRUONG BM KHÔNG THAM GIA ĐỀ TÀI DT BẰNG CÁCH DÙNG KIỂM TRA KHÔNG TỒN TẠI NOT EXISTS				1/KHÔNG CÓ DỮ LIỆU TRẢ RA --> NOT EXISTS TRẢ VỀ TRUE --> KHÔNG CÓ TRUONGBM KO THAM GIA 						--> DE TAI CO TAT CA TRUONG BO MON THAM GIA				2/CÓ ÍT NHẤT 1 DÒNG TRẢ RA --> NOT EXISTS TRẢ VỀ FALSE --> DÒNG NÀY LÀ TRUONG BM KHÔNG THAM GIA DE TAI				*/				SELECT BM.TRUONGBM FROM BOMON BM JOIN KHOA K ON K.MAKHOA = BM.MAKHOA				 WHERE K.TENKHOA = N'Sinh học' AND BM.TRUONGBM IS NOT NULL AND NOT EXISTS  								   (SELECT *								    FROM THAMGIADT TGDT 								    WHERE TGDT.MADT = DT.MADT AND TGDT.MAGV = BM.TRUONGBM))

/*Cách 2: except*/
SELECT  GV.MAGV,GV.HOTENFROM GIAOVIEN GV JOIN DETAI DT ON DT.GVCNDT=GV.MAGV WHERE  NOT EXISTS(			/*TÌM TRUONG BM KHÔNG THAM GIA ĐỀ TÀI DT BẰNG CÁCH DÙNG PHÉP TRỪ EXCEPT			TRUONG BM KHÔNG THAM GIA ĐỀ TÀI DT = TRƯƠNG BM (DS TRONG BẢNG BỘ MÔN) - GV CO THAM GIA ĐỀ TÀI DT			*/			SELECT BM.TRUONGBM			FROM BOMON BM JOIN KHOA K ON K.MAKHOA=BM.MAKHOA 			WHERE K.TENKHOA=N'Sinh học' and BM.TRUONGBM is not null			EXCEPT			SELECT TG.MAgv			FROM THAMGIADT TG			where TG.MADT=DT.MADT)


/*Cách 3: group by*/
SELECT GV.MAGV, GV.HOTENFROM GIAOVIEN GV,BOMON BM, KHOA K, THAMGIADT TGDT, DETAI DTWHERE K.TENKHOA = N'Sinh học' AND K.MAKHOA = BM.MAKHOA AND BM.TRUONGBM = TGDT.MAGV AND TGDT.MADT = DT.MADTAND DT.GVCNDT = GV.MAGVGROUP BY TGDT.MADT,GV.MAGV, GV.HOTEN--ĐẾM SỐ TRƯỞNG BM CÓ THAM GIA DT==SỐ TRƯỞNG BỘ MÔN CSDL ĐANG CÓHAVING COUNT(DISTINCT BM.TRUONGBM)  = (SELECT COUNT(DISTINCT BM.TRUONGBM)										   FROM KHOA K, BOMON BM									   WHERE K.MAKHOA = BM.MAKHOA AND K.TENKHOA = N'Sinh học')