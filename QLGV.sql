USE MASTER
GO
IF DB_ID ('QL_GV') IS NOT NULL
	DROP DATABASE QL_GV
GO
CREATE DATABASE QL_GV
GO
USE QL_GV
GO

CREATE TABLE KHOA
(
	MAKHOA VARCHAR(4),
	TENKHOA NVARCHAR(40),
	NAMTL INT,
	PHONG VARCHAR(5),
	DIENTHOAI VARCHAR(12),
	TRUONGKHOA VARCHAR(5),
	NGAYNHANCHUC DATE,
	CONSTRAINT PK_KHOA
	PRIMARY KEY (MAKHOA)
)

CREATE TABLE BOMON
(
	MABM NVARCHAR(5),
	TENBM NVARCHAR(40),
	PHONG VARCHAR(5),
	DIENTHOAI VARCHAR(12),
	TRUONGBM VARCHAR(5),
	MAKHOA VARCHAR(4),
	NGAYNHANCHUC DATE,
	CONSTRAINT PK_BOMON
	PRIMARY KEY (MABM)
)

CREATE TABLE GIAOVIEN
(
	MAGV VARCHAR(5),
	HOTEN NVARCHAR(40),
	LUONG FLOAT,
	PHAI NVARCHAR(3),
	NGSINH DATE,
	DIACHI NVARCHAR (100),
	GVQLCM VARCHAR(5),
	MABM NVARCHAR(5),
	CONSTRAINT PK_GV
	PRIMARY KEY (MAGV)
)

CREATE TABLE THAMGIADT
(
	MAGV VARCHAR(5),
	MADT VARCHAR(3),
	STT INT,
	PHUCAP FLOAT,
	KETQUA NVARCHAR(40),
	CONSTRAINT PK_TGDT
	PRIMARY KEY(MAGV,MADT,STT)
)

CREATE TABLE CONGVIEC
(
	MADT VARCHAR(3),
	SOTT INT,
	TENCV NVARCHAR(40),
	NGAYBD DATE,
	NGAYKT DATE,
	CONSTRAINT PK_CV
	PRIMARY KEY (MADT,SOTT)
)

CREATE TABLE DETAI
(
	MADT VARCHAR(3),
	TENDT NVARCHAR(100),
	CAPQL NVARCHAR(40),
	KINHPHI FLOAT,
	NGAYBD DATE,
	NGAYKT DATE,
	MACD NVARCHAR(5),
	GVCNDT VARCHAR(5),
	CONSTRAINT PK_DT
	PRIMARY KEY (MADT)
)

CREATE TABLE CHUDE
(
	MACD NVARCHAR(5),
	TENCD NVARCHAR(50),
	CONSTRAINT PK_CD
	PRIMARY KEY (MACD)
)

CREATE TABLE NGUOITHAN
(
	MAGV VARCHAR(5),
	TEN NVARCHAR(20),
	NGSINH DATE,
	PHAI NVARCHAR(3),
	CONSTRAINT PK_NT
	PRIMARY KEY (MAGV,TEN)
)

CREATE TABLE GV_DT
(
	MAGV VARCHAR(5),
	DIENTHOAI VARCHAR(12),
	CONSTRAINT PK_GVDT
	PRIMARY KEY (MAGV,DIENTHOAI)
)

ALTER TABLE KHOA
ADD
	CONSTRAINT FK_K_GV
	FOREIGN KEY (TRUONGKHOA)
	REFERENCES GIAOVIEN

ALTER TABLE BOMON
ADD
	CONSTRAINT FK_BM_K
	FOREIGN KEY (MAKHOA)
	REFERENCES KHOA,
	CONSTRAINT FK_BM_GV
	FOREIGN KEY (TRUONGBM)
	REFERENCES GIAOVIEN

ALTER TABLE GIAOVIEN
ADD
	CONSTRAINT FK_GV_GV
	FOREIGN KEY (GVQLCM)
	REFERENCES GIAOVIEN,
	CONSTRAINT FK_GV_BM
	FOREIGN KEY (MABM)
	REFERENCES BOMON

ALTER TABLE THAMGIADT
ADD
	CONSTRAINT FK_TGDT_GV
	FOREIGN KEY (MAGV)
	REFERENCES GIAOVIEN
	
ALTER TABLE CONGVIEC
ADD
	CONSTRAINT FK_CV_DT
	FOREIGN KEY (MADT)
	REFERENCES DETAI

ALTER TABLE DETAI
ADD
	CONSTRAINT FK_DT_GV
	FOREIGN KEY (GVCNDT)
	REFERENCES GIAOVIEN,
	CONSTRAINT FK_DT_CD
	FOREIGN KEY (MACD)
	REFERENCES CHUDE

ALTER TABLE NGUOITHAN
ADD
	CONSTRAINT FK_NT_GV
	FOREIGN KEY (MAGV)
	REFERENCES GIAOVIEN

ALTER TABLE GV_DT
ADD
	CONSTRAINT FK_GVDT_GV
	FOREIGN KEY (MAGV)
	REFERENCES GIAOVIEN

INSERT INTO GIAOVIEN
VALUES ('001',N'Nguyễn Hoài An',2000.0,'Nam','02/15/1973',N'25/3 Lạc Long Quân, Q.10, TP HCM', NULL,NULL),
	 ('002',N'Trần Trà Hương',2500.0,N'Nữ','06/20/1960',N'125 Trần Hưng Đạo, Q.1, TP HCM', NULL,NULL),
	 ('003',N'Nguyễn Ngọc Ánh',2200.0,N'Nữ','05/11/1975',N'12/21 Võ Văn Ngân, Thủ Đức, TP HCM', NULL,NULL),
	 ('004',N'Trương Nam Sơn',2300.0,'Nam','06/20/1959',N'215 Lý Thường Kiệt, TP Biên Hòa', NULL,NULL),
	 ('005',N'Lý Hoàng Hà',2500.0,'Nam','10/23/1954',N'22/5 Nguyễn Xí, Q.Bình Thạnh, TP HCM', NULL,NULL),
	 ('006',N'Trần Bạch Tuyết',1500.0,N'Nữ','05/20/1980',N'127 Hừng Vương, TP Mỹ Tho',NULL,NULL),
	 ('007',N'Nguyễn An Trung',2100.0,'Nam','06/05/1976',N'234 3/2, TP Biên Hòa', NULL,NULL),
	 ('008',N'Trần Trung Hiếu',1800.0,'Nam','08/06/1977',N'22/11 Lý Thường Kiệt, TP Mỹ Tho',NULL,NULL),
	 ('009',N'Trần Hoàng Nam',2000.0,'Nam','11/22/1975',N'234 Trần Não, An Phú, TP HCM', NULL,NULL),
	 ('010',N'Phạm Nam Thanh',1500.0,'Nam','12/12/1980',N'221 Hùng Vương, Q.5, TP HCM', NULL,NULL)

UPDATE GIAOVIEN
SET GVQLCM = '002' WHERE MAGV = '003'
UPDATE GIAOVIEN
SET GVQLCM = '004' WHERE MAGV = '006'
UPDATE GIAOVIEN
SET GVQLCM = '007' WHERE MAGV = '008' AND MAGV = '010'
UPDATE GIAOVIEN
SET GVQLCM = '001' WHERE MAGV = '009'


INSERT INTO CHUDE
VALUES ('NCPT',N'Nghiên cứu phát triển'),
	('QLGD',N'Quản lý giáo dục'),
	(N'ƯDCN',N'Ứng dụng công nghệ')

INSERT INTO DETAI
VALUES ('001',N'HTTT quản lý các trường ĐH',N'ĐHQG',20.0,'10/20/2007','10/20/2008','QLGD','002'),
	('002',N'HTTT quản lý giáo vụ cho một Khoa',N'Trường',20.0,'10/12/2000','10/12/2001','QLGD','002'),
	('003',N'Nghiên cứu chế tạo sợi Nano Platin',N'ĐHQG',300.0,'05/15/2008','05/15/2010','NCPT','005'),
	('004',N'Tạo vật liệu sinh học bằng màng ối người',N'Nhà nước',100.0,'01/01/2007','12/31/2009','NCPT','004'),
	('005',N'Ứng dụng hóa học xanh',N'Trường',200.0,'10/10/2003','12/10/2004',N'ƯDCN','007'),
	('006',N'Nghiên cứu tế bào gốc',N'Nhà nước',4000.0,'10/20/2006','10/20/2009','NCPT','004'),
	('007',N'HTTT quản lý thư viện ở các trường ĐH',N'Trường',20.0,'05/10/2009','05/10/2009','QLGD','001')

INSERT INTO CONGVIEC
VALUES ('001',1,N'Khởi tạo và lập kế hoạch','10/20/2007','12/20/2008'),
	('001',2,N'Xác định yêu cầu','12/21/2008','03/21/2008'),
	('001',3,N'Phân tích hệ thống','03/22/2008','05/22/2008'),
	('001',4,N'Thiết kế hệ thống','05/23/2008','06/23/2008'),
	('001',5,N'Cài đặt thử nghiệm','06/24/2008','10/20/2008'),
	('002',1,N'Khởi tạo và lập kế hoạch','05/10/2009','07/10/2009'),
	('002',2,N'Xác định yêu cầu','07/11/2009','10/11/2009'),
	('002',3,N'Phân tích hệ thống','10/12/2009','12/20/2009'),
	('002',4,N'Thiết kế hệ thống','12/21/2009','03/22/2010'),
	('002',5,N'Cài đặt thử nghiệm','03/23/2010','05/10/2010'),
	('006',1,N'Lấy mẫu','10/20/2006','02/20/2007'),
	('006',2,N'Nuôi cây','02/21/2007','08/21/2008')

INSERT INTO THAMGIADT
VALUES ('001','002',1,0.0,NULL),
	('001','002',2,2.0,NULL),
	('002','001',4,2.0,N'Đạt'),
	('003','001',1,1.0,N'Đạt'),
	('003','001',2,0.0,N'Đạt'),
	('003','001',4,1.0,N'Đạt'),
	('003','002',2,0.0,NULL),
	('004','006',1,0.0,N'Đạt'),
	('004','006',2,1.0,N'Đạt'),
	('006','006',2,1.5,N'Đạt'),
	('009','002',3,0.5,NULL),
	('009','002',4,1.5,NULL)

INSERT INTO NGUOITHAN
VALUES ('001',N'Hùng','01/14/1990',N'Nam'),
	('001',N'Thủy','12/08/1994',N'Nữ'),
	('003',N'Hà','09/03/1998',N'Nữ'),
	('003',N'Thu','09/03/1998',N'Nữ'),
	('007',N'Mai','03/26/2003',N'Nữ'),
	('007',N'Vy','02/14/2000',N'Nữ'),
	('008',N'Nam','05/06/1991',N'Nam'),
	('009',N'An','08/19/1996',N'Nam'),
	('010',N'Nguyệt','01/14/2006',N'Nữ')

INSERT INTO GV_DT
VALUES ('001','0838912112'),
	('001','0903123123'),
	('002','0913454545'),
	('003','0838121212'),
	('003','0903656565'),
	('003','0937125125'),
	('006','0937888888'),
	('008','0653717171'),
	('008','0913232323')

INSERT INTO KHOA
VALUES ('CNTT',N'Công nghệ thông tin',1995,'B11','0838123456','002','02/20/2005'),
	('HH',N'Hóa học',1980,'B41','0838456456','007','10/15/2001'),
	('SH',N'Sinh học',1980,'B31','0838454545','004','10/11/2000'),
	('VL',N'Vật lý',1976,'B21','0838223223','005','09/18/2003')

INSERT INTO BOMON
VALUES (N'CNTT',N'Công nghệ tri thức','B15','0838126126',NULL,'CNTT',NULL),
	 (N'HHC',N'Hóa hữu cơ','B44','0838222222',NULL,'HH',NULL),
	 (N'HL',N'Hóa lý','B42','0838878787',NULL,'HH',NULL),
	 (N'HPT',N'Hóa phân tích','B43','0838777777','007','HH','10/15/2007'),
	 (N'HTTT',N'Hệ thống máy tính','B13','0838125125','002','CNTT','09/20/2004'),
	 (N'MMT',N'Mạng máy tính','B16','0838676767','001','CNTT','05/15/2005'),
	 (N'SH',N'Sinh hóa','B33','0838898989',NULL,'SH',NULL),
	 (N'VLĐT',N'vật lý điện từ','B23','0838234234',NULL,'VL',NULL),
	 (N'VLƯD',N'Vật lý ứng dụng','B24','0838454545','005','VL','02/18/2006'),
	 (N'VS',N'Vi sinh','B32','0838909090','004','SH','01/01/2007')

UPDATE GIAOVIEN
SET MABM = N'MMT' WHERE MAGV = '001' AND MAGV = '009'
UPDATE GIAOVIEN
SET MABM = N'HTTT' WHERE MAGV = '002' AND MAGV = '003'
UPDATE GIAOVIEN
SET MABM = N'VS' WHERE MAGV = '004' AND MAGV = '006'
UPDATE GIAOVIEN
SET MABM = N'VLĐT' WHERE MAGV = '005'
UPDATE GIAOVIEN
SET MABM = 'HPT' WHERE MAGV = '007' AND MAGV = '008' AND MAGV = '010'

