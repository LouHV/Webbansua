<!-- #include file="..\connect.asp" -->
<%
    If (isnull(Session("TaiKhoan")) OR TRIM(Session("TaiKhoan")) <> "admin") Then
        Response.redirect("login.asp")
    End If
    

    If (Request.ServerVariables("REQUEST_METHOD") = "POST") THEN  
        Dim slmathang, mahoadon, thanhtien
        id = Request.QueryString("id")
        sl = Request.QueryString("sl")
        tongnhap = Request.QueryString("tongnhap")
        If (cint(sl)<> "" and cint(id)<> "" and  tongnhap <> "") Then
            mahoadon = id
            slmathang = sl
            thanhtien = tongnhap 
        End if 
        msp = Request.form("msp")
        tensp = Request.form("tensp")
        loaisp = Request.form("loaisp")
        gianhap = Request.form("gianhap")
        slnhap = Request.form("slnhap")
        gia = thanhtien + (gianhap * slnhap)
        mhconlai = slmathang - 1
        if(gia > 0 and slmathang <> 0) then
                Set cmdPrep = Server.CreateObject("ADODB.Command")
                connDB.Open()
                cmdPrep.ActiveConnection = connDB
                cmdPrep.CommandType = 1
                cmdPrep.Prepared = True
                cmdPrep.CommandText = "UPDATE HDNhap SET SoLoaiMHNhap=?,TongNhap=? WHERE MaHDnhap = ?"
                cmdPrep.Parameters(0)=mhconlai
                cmdPrep.Parameters(1)=gia
                 cmdPrep.Parameters(2)= id
                cmdPrep.execute
                Session("Success") = "Nha cung cấp đã được sửa"
        else
            if(slmathang < 0) then
                Response.redirect("hoadonnhap.asp") 
            end if
        end if
        if (NOT isnull(msp) and msp<>"" and NOT isnull(gianhap) and gianhap<>""and NOT isnull(slnhap) and slnhap<>"" and gianhap > 0 and slnhap > 0 ) then
                Set cmdPrep = Server.CreateObject("ADODB.Command")
                cmdPrep.ActiveConnection = connDB
                cmdPrep.CommandType = 1
                cmdPrep.Prepared = True
                cmdPrep.CommandText = "INSERT INTO CTHDNhap(MaHDnhap,Masp,GiaNhap,SLNhap) VALUES(?,?,?,?)"
                cmdPrep.Parameters(0)= mahoadon
                cmdPrep.Parameters(1)=msp

                cmdPrep.Parameters(2)=gianhap
                cmdPrep.Parameters(3)=slnhap
                cmdPrep.execute    
                Session("Success") = "da them 1 hoa don"
                Response.redirect("chitiethoadonnhap.asp?id="+ cstr(id) +"&sl="+ cstr(mhconlai)  +"&tongnhap="+ cstr(gia))
        else
                Session("Error") = "You have to input enough info"                
        end if
    End If 
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.4/font/bootstrap-icons.css">
    <link rel='shortcut icon' href='./upload/download.ico' />
    <title>Admin</title>
    
    <!-- Font Awesome JS -->
    <script defer src="https://use.fontawesome.com/releases/v5.0.13/js/solid.js" integrity="sha384-tzzSw1/Vo+0N5UhStP3bvwWPq+uvzCMfrN1fEFe+xBmv1C/AtVX5K0uZtmcHitFZ" crossorigin="anonymous"></script>
    <script defer src="https://use.fontawesome.com/releases/v5.0.13/js/fontawesome.js" integrity="sha384-6OIrr52G08NpOFSZdxxz1xdNSndlD4vdcf/q2myIUVO0VsqaGHJsB0RaBE01VTOY" crossorigin="anonymous"></script>


<!-- jQuery CDN - Slim version (=without AJAX) -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <!-- Popper.JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js" integrity="sha384-cs/chFZiN24E4KMATLdqdvsezGxaGsi4hLGOzlXwp5UZB1LY//20VyM2taTB4QvJ" crossorigin="anonymous"></script>
    <!-- Bootstrap JS -->
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js" integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm" crossorigin="anonymous"></script>
</head>
<style>
.wrapper {
    display: flex;
    width: 100%;
    align-items: stretch;
}
.content {
    width: 100%;
    padding: 20px;
    min-height: 100vh;
    transition: all 0.3s;
}
</style>
<body>
<div class="wrapper">
    <!-- #include file="sidebar.asp" -->
    <div class="content">
    <!-- #include file="header.asp" -->
        <form method="post"  >
            <div class="mb-3">
            <label for="msp" class="form-label">Mã sản phẩm</label>
            <input type="number" class="form-control" name="msp" id="msp">
            </div>

            <div class="mb-3">
            <label for="gianhap" class="form-label">Giá nhập</label>
            <input type="number" class="form-control" name="gianhap" id="gianhap">
            </div> 
            <div class="mb-3">
            <label for="slnhap" class="form-label">Số lượng nhập</label>
            <input type="number" class="form-control" name="slnhap" id="slnhap">
            </div> 
            <button type="submit" class="btn btn-primary" >Thêm</button>
                <a href="hoadonnhap.asp" class="btn btn-info">Huỷ</a>        
        </form>
    <div> 
</div>
            <!-- #include file="footer.asp" -->
</body>
</html>