<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file="..\connect.asp" -->
<%
    If (isnull(Session("TaiKhoan")) OR TRIM(Session("TaiKhoan")) <> "admin") Then
        Response.redirect("login.asp")
    End If
    Dim sqlString, rs, mahoadoncu
        sqlString = "Select Max(MaHDnhap) as Max from HDNhap"
        connDB.Open()
        set rs = connDB.execute(sqlString) 
        If not rs.EOF Then
             mahoadoncu = rs("Max")
        else
            mahoadoncu = 0
        End If
        mahoadonht = mahoadoncu + 1
    If (Request.ServerVariables("REQUEST_METHOD") = "POST") THEN        
        manhacc = Request.form("nhacc")
        soluongloaimhnhap = Request.form("sl")
        tongnhap = 0 
        if (NOT isnull(manhacc) and manhacc<>"" and NOT isnull(soluongloaimhnhap) and soluongloaimhnhap<>"" and NOT isnull(tongnhap) and tongnhap<>"" and soluongloaimhnhap > 0 ) then
                Set cmdPrep = Server.CreateObject("ADODB.Command")
              
                cmdPrep.ActiveConnection = connDB
                cmdPrep.CommandType = 1
                cmdPrep.Prepared = True
                cmdPrep.CommandText = "INSERT INTO HDNhap(MaNhacc,TongNhap,NgayNhap,SoLoaiMHNhap) VALUES(?,?,getdate(),?)"
                cmdPrep.Parameters(0)=manhacc
                cmdPrep.Parameters(1)=tongnhap
                cmdPrep.Parameters(2)=soluongloaimhnhap
                cmdPrep.execute    
                Session("Success") = "Thêm hoá đơn thành công."
                Response.redirect("hoadonnhap.asp")
        else
                Session("Error") = "Bạn phải nhập đủ thông tin."                
        end if
    End If    
%><!DOCTYPE html>
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
     
    <form method="post" >
    <div class="mb-3">
    <label for="nhacc" class="form-label">Mã nhà cung cấp</label>
    <input type="number" class="form-control" name="nhacc" id="nhacc">
    </div>
    <div class="mb-3">
    <label for="sl" class="form-label">Số lượng loại mặt hàng nhập: </label>
    <input type="number" class="form-control" name="sl" id="sl">
    </div>
    
        <%
        If (NOT IsEmpty(Session("Error")) AND NOT isnull(Session("Error"))) AND (TRIM(Session("Error"))<>"") Then
    %>
            <div class="alert alert-danger mt-2" role="alert">
                <%=Session("Error")%>
            </div>
    <%
            Session.Contents.Remove("Error")
        End If
    %>   
    <button type="submit" class="btn btn-primary">Thêm</button>
        <a href="hoadonnhap.asp" class="btn btn-info">Huỷ</a>        
    </form>
    
    <div> 
</div>
        <!-- #include file="footer.asp" -->
</body>
</html>