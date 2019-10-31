1. /* Hãy cho biết có những khách hàng nào lại chính là đối tác cung cấp hàng của công ty
(tức là có cùng tên giao dịch). */
SELECT khachhang.makhachhang, khachhang.tencongty, nhacungcap.macongty, khachhang.tengiaodich
FROM khachhang
INNER JOIN nhacungcap ON khachhang.tengiaodich=nhacungcap.tengiaodich;
2. /* Những đơn đặt hàng nào yêu cầu giao hàng ngay tại cty đặt hàng và những đơn đó là
của công ty nào? */
SELECT dondathang.noigiaohang, dondathang.makhachhang, khachhang.tencongty
FROM dondathang
INNER JOIN khachhang ON dondathang.noigiaohang=khachhang.diachi;
3. /* Những mặt hàng nào chưa từng được khách hàng đặt mua?*/
SELECT * FROM mathang
LEFT JOIN chitietdathang on mathang.mahang =  chitietdathang.mahang
WHERE chitietdathang.sohoadon IS NULL
4. /* Những nhân viên nào của công ty chưa từng lập bất kỳ một hoá đơn đặt hàng nào? */
SELECT * FROM nhanvien
LEFT JOIN dondathang ON nhanvien.manhanvien = dondathang.manhanvien
WHERE dondathang.sohoadon IS NULL
5. /* Trong năm 2003, những mặt hàng nào chỉ được đặt mua đúng một lần*/
select * from dondathang
where YEAR(ngaydathang) = 2003
and sohoadon = 1
6. /*Hãy cho biết mỗi một khách hàng đã phải bỏ ra bao nhiêu tiền để đặt mua hàng của
công ty?  */
select makhachhang, sum(tongtien) from (
	select chitietdathang.sohoadon, khachhang.makhachhang, khachhang.tencongty,sum(chitietdathang.giaban*chitietdathang.soluong-chitietdathang.mucgiamgia) as tongtien
	from chitietdathang
	inner join dondathang on chitietdathang.sohoadon = dondathang.sohoadon
	inner join khachhang on dondathang.makhachhang = khachhang.makhachhang
	group by chitietdathang.sohoadon, khachhang.makhachhang, khachhang.tencongty
) as bangtam group by makhachhang
7. /*Mỗi một nhân viên của công ty đã lập bao nhiêu đơn đặt hàng (nếu nhân viên chưa hề
lập một hoá đơn nào thì cho kết quả là 0)  */
SELECT nhanvien.manhanvien, COUNT(nhanvien.manhanvien) AS SoLanLapHoaDon
FROM  nhanvien INNER JOIN dondathang ON nhanvien.manhanvien = dondathang.manhanvien
GROUP BY nhanvien.manhanvien
UNION
SELECT nhanvien.manhanvien , 0 AS SoLanLapHoaDon
FROM nhanvien
WHERE nhanvien.manhanvien NOT IN (SELECT nhanvien.manhanvien FROM nhanvien INNER JOIN dondathang ON nhanvien.manhanvien=dondathang.manhanvien)

ORDER BY SoLanLapHoaDon DESC
8. /* Cho biết tổng số tiền hàng mà cửa hàng thu được trong mỗi tháng của năm 2003 (thời
được gian tính theo ngày đặt hàng). */
select MONTH(ngaydathang) as Thang, sum(giaban*soluong-mucgiamgia) as TongSoTien from(
	select dondathang.sohoadon, dondathang.ngaydathang, chitietdathang.mahang, chitietdathang.giaban, chitietdathang.soluong, chitietdathang.mucgiamgia
	from dondathang
	inner join chitietdathang on dondathang.sohoadon = chitietdathang.sohoadon
	where YEAR(ngaydathang) = 2003
) as bangtam group by MONTH(ngaydathang)
9. /* Hãy cho biết tổng số lượng hàng của mỗi mặt hàng mà cty đã có (tổng số lượng hàng
hiện có và đã bán).  */
select mahang, soluong as TongSoLuongHangDaCo from mathang
select mahang, sum(soluong) as TongSoLuongHangDaBan from chitietdathang
group by mahang
10. /* Nhân viên nào của cty bán được số lượng hàng nhiều nhất và số lượng hàng bán được
của nhân viên này là bao nhiêu? */
select top(1) manhanvien , sum(soluong) as TongSoLuongHangDaBan from(
	select dondathang.manhanvien, dondathang.sohoadon, chitietdathang.soluong
	from dondathang
	inner join chitietdathang on dondathang.sohoadon = chitietdathang.sohoadon
) as bangtam group by manhanvien order by TongSoLuongHangDaBan desc
11. /* Mỗi một đơn đặt hàng đặt mua những mặt hàng nào và tổng số tiền mà mỗi đơn đặt
hàng phải trả là bao nhiêu? */
select dondathang.sohoadon, chitietdathang.mahang, mathang.tenhang, mathang.soluong, mathang.giahang, mathang.donvitinh
from chitietdathang
inner join dondathang on dondathang.sohoadon = chitietdathang.sohoadon
inner join mathang on mathang.mahang = chitietdathang.mahang

select sohoadon, sum(giahang*soluong) as TongSoTien from(
select dondathang.sohoadon, chitietdathang.mahang, mathang.tenhang, mathang.soluong, mathang.giahang, mathang.donvitinh
from chitietdathang
inner join dondathang on dondathang.sohoadon = chitietdathang.sohoadon
inner join mathang on mathang.mahang = chitietdathang.mahang
) as bangtam group by sohoadon
12. /* Hãy cho biết mỗi một loại hàng bao gồm những mặt hàng nào, tổng số lượng hàng của
mỗi loại và tổng số lượng của tất cả các mặt hàng hiện có trong công ty là bao nhiêu?  */
select * from loaihang

select maloaihang, sum(soluong) as TongSoLuong
from mathang
group by maloaihang

select * from mathang
select sum(soluong) as TongSoLuongBanDau from mathang
select * from chitietdathang
select sum(soluong) as TongSoLuongDaBan from chitietdathang

select((select sum(soluong) as TongSoLuongBanDau from mathang) - (select sum(soluong) as TongSoLuongDaBan from chitietdathang))

13. /* Thống kê xem trong năm 2003, mỗi một mặt hàng trong mỗi tháng và trong cả năm bán
được với số lượng bao nhiêu */

select mahang, sum(soluong) as TongSoLuongBanCaNam from(
	select chitietdathang.sohoadon, chitietdathang.mahang, chitietdathang.soluong, dondathang.ngaydathang
	from chitietdathang
	inner join dondathang on dondathang.sohoadon = chitietdathang.sohoadon
	where year(ngaydathang) = 2003
) as bangtam group by mahang

select MONTH(ngaydathang) as Thang, mahang, sum(soluong) as TongSoLuongBanMoiThang from(
	select chitietdathang.sohoadon, chitietdathang.mahang, chitietdathang.soluong, dondathang.ngaydathang
	from chitietdathang
	inner join dondathang on dondathang.sohoadon = chitietdathang.sohoadon
	where year(ngaydathang) = 2003
) as bangtam group by MONTH(ngaydathang), mahang
order by thang desc

14. /* Cập nhật lại giá trị NGAYCHUYENHANG của những bản ghi có giá trị
NGAYCHUYENHANG chưa xác định (NULL) trong bảng DONDATHANG bằng với giá
trị của trường NGAYDATHANG. */
update dondathang
set ngaychuyenhang = ngaydathang
where ngaychuyenhang is null
15. /* Cập nhật giá trị của trường NOIGIAOHANG trong bảng DONDATHANG bằng địa chỉ
của khách hàng đối với những đơn đặt hàng chưa xác định được nơi giao hàng (có giá
trị trường NOIGIAOHANG bằng NULL) */
UPDATE
    dbo.dondathang
SET
    dbo.dondathang.noigiaohang = (select
	dbo.khachhang.diachi from dbo.khachhang where dbo.khachhang.makhachhang = dbo.dondathang.makhachhang)
	where dbo.dondathang.noigiaohang is null
16. /* Cập nhật lại dữ liệu trong bảng KHACHHANG sao cho nếu tên công ty và tên giao dịch
của khách hàng trùng với tên công ty và tên giao dịch của một nhà cung cấp nào đó thì
địa chỉ, điện thoại, fax và email phải giống nhau. */
update khachhang
set 
	diachi = nhacungcap.diachi ,
	email = nhacungcap.email ,
	dienthoai = nhacungcap.dienthoai ,
	fax = nhacungcap.fax
from khachhang, nhacungcap
where khachhang.tencongty = nhacungcap.tencongty AND khachhang.tengiaodich = nhacungcap.tengiaodich
17. /* Tăng lương lên gấp rưỡi cho những nhân viên bán được số lượng hàng nhiều hơn 100
trong năm 2003  */
select nhanvien.manhanvien, dondathang.sohoadon, chitietdathang.soluong, nhanvien.luongcoban, year(dondathang.ngaydathang) as Nam
from dondathang
inner join nhanvien on nhanvien.manhanvien = dondathang.manhanvien
inner join chitietdathang on chitietdathang.sohoadon = dondathang.sohoadon
where soluong > 100 and YEAR(dondathang.ngaydathang) = 2003
order by manhanvien desc

update nhanvien
set 
	luongcoban = luongcoban*1.5
from nhanvien, dondathang, chitietdathang
where nhanvien.manhanvien = dondathang.manhanvien and dondathang.sohoadon = chitietdathang.sohoadon and chitietdathang.soluong > 100 and YEAR(dondathang.ngaydathang) = 2003

18. /* Tăng phụ cấp lên bằng 50% lương cho những nhân viên bán được hàng nhiều nhất. lỗi là do cú pháp sai (ko có định danh) đặt tên as "name" */
update nhanvien
set phucap = luongcoban*0.5
where manhanvien = 
			(select manhanvien from(
			select top 1 manhanvien, sum(soluong) as SoLuongHangBanDuoc from(
			select nhanvien.manhanvien, dondathang.sohoadon, chitietdathang.soluong, nhanvien.luongcoban, nhanvien.phucap
			from dondathang
			inner join nhanvien on nhanvien.manhanvien = dondathang.manhanvien
			inner join chitietdathang on chitietdathang.sohoadon = dondathang.sohoadon
			) as bangtam group by manhanvien, phucap, luongcoban
			order by SoLuongHangBanDuoc desc
		) as abc
		)
19. /* Giảm 25% lương của những nhân viên trong năm 2003 ko lập được bất kỳ đơn đặt
hàng nào */
UPDATE nhanvien
SET luongcoban = luongcoban * 3/4
WHERE NOT EXISTS ( SELECT manhanvien FROM dondathang WHERE nhanvien.manhanvien = dondathang.manhanvien)
20. /* Giả sử trong bảng DONDATHANG có them trường SOTIEN cho biết số tiền mà khách
hàng phải trả trong mỗi dơnđặt hàng. Hãy tính giá trị cho trường này. */
UPDATE dondathang
 SET sotien =
 (SELECT SUM(soluong*giaban-soluong*giaban*mucgiamgia/100)
 FROM chitietdathang
 WHERE chitietdathang.sohoadon = dondathang.sohoadon
 GROUP BY sotien)
 21. /* Xoá khỏi bảng MATHANG những mặt hàng có số lượng bằng 0 và không được đặt mua
trong bất kỳ đơn đặt hàng nào. */
 delete from mathang
where soluong = 0 and
not exists (
	select sohoadon 
	from chitietdathang
	where chitietdathang.mahang = mathang.mahang)

3.Yêu cầu nâng cao
1. /* Tạo thủ tục lưu trữ để thông qua thủ tục này có thể bổ sung thêm một bản ghi mới cho
bảng MATHANG (thủ tục phải thực hiện kiểm tra tính hợp lệ của dữ liệu cần bổ sung:
không trùng khoá chính và đảm bảo toàn vẹn tham chiếu)  */
CREATE PROCEDURE thu_tuc_luu_tru_InsertMatHang(
		@mahang NVARCHAR(10)
      , @tenhang NVARCHAR(50)
      , @macongty NVARCHAR(10)
      , @maloaihang INT
      , @soluong INT
      , @donvitinh NVARCHAR(20)
      , @giahang MONEY)
	  AS
	  BEGIN
			DECLARE @ma_Hang INT
			SELECT @ma_Hang = COUNT(*) FROM mathang WHERE mahang = @mahang
				IF(@ma_Hang = 0)
					BEGIN
						DECLARE @ma_Cty INT
						SELECT @ma_Cty = COUNT(*) FROM nhacungcap WHERE macongty = @macongty
						IF(@ma_Cty = 0)
							BEGIN
								DECLARE @ma_Loai INT
								SELECT @ma_Loai = COUNT(*) FROM loaihang WHERE maloaihang = @maloaihang
								IF(@ma_Loai = 0)
									BEGIN
										IF(@soluong >= 0)
											BEGIN
												INSERT INTO mathang 
												VALUES(@mahang, @tenhang, @macongty, @maloaihang, @soluong, @donvitinh, @giahang)
											END
										ELSE
										  PRINT 'SỐ LƯỢNG PHẢI LỚN HƠN 0'
									END
								ELSE
									PRINT 'MÃ LOẠI HÀNG CHƯA TỒN TẠI'	
						
							END
						ELSE
						   PRINT 'MÃ CÔNG TY CHƯA TỒN TẠI'	
				
					END
				ELSE
					PRINT 'MÃ HÀNG BỊ TRÙNG'
	  INSERT INTO mathang
	  VALUES (@mahang, @tenhang, @macongty, @maloaihang, @soluong, @donvitinh, @giahang)
	  END
2. /*Tạo thủ tục lưu trữ có chức năng thống kê tổng số lượng hàng bán được của một mặt
hàng có mã bất kỳ (mã mặt hàng cần thống kê là tham số của thủ tục). */

CREATE PROCEDURE thu_tuc_luu_tru_ThongKe(@mahang nvarchar(10))
	  AS
	  BEGIN
		select mahang, sum(soluong) as TongSoLuongBan from(
		select chitietdathang.sohoadon, chitietdathang.mahang, chitietdathang.soluong, dondathang.ngaydathang
		from chitietdathang
		inner join dondathang on dondathang.sohoadon = chitietdathang.sohoadon
		) as bangtam group by mahang
	  END
3. /* Viết trigger cho bảng CHITIETDATHANG theo yêu cầu sau:
 Khi một bản ghi mới được bổ sung vào bảng này thì giảm số lượng hàng hiện có nếu
số lượng hàng hiện có lớn hơn hoặc bằng số lượng hàng được bán ra. Ngược lại thì
huỷ bỏ thao tác bổ sung.*/
CREATE TRIGGER trg_DatHang ON chitietdathang AFTER INSERT AS 
BEGIN
	DECLARE @soLuongHienTai INT
	DECLARE @soLuongBan INT
	DECLARE @maHang VARCHAR(20)

	SELECT @maHang = mahang FROM inserted
	SELECT @soLuongHienTai = soluong FROM mathang WHERE mathang.mahang = @maHang
	SELECT @soLuongBan = soluong FROM inserted

	IF(@soLuongBan <= @soLuongHienTai)
		BEGIN 
			UPDATE mathang SET soluong = soluong - @soluongban WHERE mathang.mahang=@mahang 
		END
	ELSE
		PRINT 'so luong mat hang khong du'
	ROLLBACK TRANSACTION /*Một transaction là một sự lan truyền của một hoặc nhiều thay đổi tới Database, điều khiển các transaction để bảo đảm toàn vẹn dữ liệu và để xử lý các Database Error. */
END

/*
 Khi cập nhật lại số lượng hàng được bán, kiểm tra số lượng hàng được cập nhật lại có
phù hợp hay không (số lượng hàng bán ra không được vượt quá số lượng hàng hiện
có và không được nhỏ hơn 1). Nếu dữ liệu hợp lệ thì giảm (hoặc tăng) số lượng hàng
hiện có trong công ty, ngược lại thì huỷ bỏ thao tác cập nhật. 
*/
	/* cập nhật mặt hàng sau khi đặt hàng hoặc cập nhật */

/* cập nhật mặt hàng sau khi cập nhật đặt hàng */
CREATE TRIGGER trg_CapNhatSoLuongBan ON chitietdathang FOR UPDATE AS 
BEGIN
	DECLARE @soLuongHienTai INT
	DECLARE @soLuongBan INT
	DECLARE @maHang VARCHAR(20)

	SELECT @maHang = mahang FROM inserted
	SELECT @soLuongHienTai = soluong FROM mathang WHERE mathang.mahang = @maHang
	SELECT @soLuongBan = soluong FROM inserted

	IF(@soLuongBan >= @soLuongHienTai OR @soLuongBan < 1)
		BEGIN 
			  PRINT 'Số lượng hàng bán ra không được vượt quá số lượng hàng hiện có và không được nhỏ hơn 1'
			  ROLLBACK TRANSACTION 
		END
	ELSE
		UPDATE mathang SET soluong = soluong - @soluongban WHERE mathang.mahang=@mahang	
	ROLLBACK TRANSACTION /*Một transaction là một sự lan truyền của một hoặc nhiều thay đổi tới Database, điều khiển các transaction để bảo đảm toàn vẹn dữ liệu và để xử lý các Database Error. */
END
4. /* Viết trigger cho bảng CHITIETDATHANG để sao cho chỉ chấp nhận giá hàng bán ra
phải nhỏ hơn hoặc bằng giá gốc (giá của mặt hàng trong bảng MATHANG) */
CREATE TRIGGER trigger_giaban
ON dbo.chitietdathang FOR INSERT,UPDATE
AS 
	BEGIN
	    DECLARE @mahang NVARCHAR(10)
		DECLARE @giaban MONEY
		DECLARE @giahang MONEY
		
		SELECT @mahang=mahang FROM inserted
		SELECT @giaban=giaban FROM chitietdathang
		SELECT @giahang=giahang FROM mathang WHERE mathang.mahang = @mahang
		
		if(@giaban>=@giahang)
			BEGIN
				PRINT 'Giá hàng bán ra phải nhỏ hơn hoặc bằng giá gốc '
				ROLLBACK TRAN	
			END
	END
GO	