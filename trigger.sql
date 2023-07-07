create trigger tg_ThemSl on HangHoa 
after insert as
begin
	update LoaiHangHoa
	set LoaiHangHoa.SoLuong = LoaiHangHoa.SoLuong + inserted.SoLuong
	from LoaiHangHoa
	JOIN inserted on LoaiHangHoa.MaLoai = inserted.MaLoai
end
 go

 Create TRIGGER tg_suasl ON HangHoa AFTER UPDATE AS
BEGIN
	If UPDATE(SoLuong)
	update LoaiHangHoa
	Set LoaiHangHoa.SoLuong = LoaiHangHoa.SoLuong -
		(inserted.SoLuong - deleted.SoLuong)
	From (deleted inner join inserted on
	deleted.MaLoai = inserted.MaLoai) inner join LoaiHangHoa on
                 LoaiHangHoa.MaLoai = deleted.MaLoai	
END
GO