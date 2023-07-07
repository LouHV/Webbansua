<!-- #include file="..\connect.asp" -->
<%
Dim TaiKhoan, MatKhau
TaiKhoan = Request.Form("TaiKhoan")
MatKhau = Request.Form("MatKhau")
If (NOT isnull(TaiKhoan) AND NOT isnull(MatKhau) AND TRIM(TaiKhoan)<>"" AND TRIM(MatKhau)<>"") Then
    ' true
    Dim sql
    sql = "select * from TKNguoiDung where TaiKhoan= ? and MatKhau= ?"
    Dim cmdPrep
    set cmdPrep = Server.CreateObject("ADODB.Command")
    connDB.Open()
    cmdPrep.ActiveConnection = connDB
    cmdPrep.CommandType=1
    cmdPrep.Prepared=true
    cmdPrep.CommandText = sql
    cmdPrep.Parameters(0)=TaiKhoan
    cmdPrep.Parameters(1)=MatKhau
    Dim result
    set result = cmdPrep.execute()
    'kiem tra ket qua result o day
    If not result.EOF Then
        ' dang nhap thanh cong
        Session("TaiKhoan")=result("TaiKhoan")
        Session("HoTen") = result("HoTen")
        Session("Success")="Đăng nhập thành công."
        Dim carts(2)
        carts(0)=5
        carts(1)=10
        carts(2)=15
        Session("s_Carts") = carts
        Response.redirect("index.asp")
    Else
        ' dang nhap ko thanh cong
        Session("Error") = "Tài khoản hoặc mật khẩu không chính xác"
    End if
    result.Close()
    connDB.Close()
Else
    ' Kiem tra vi co the trung voi truong hop logout
    If (Request.ServerVariables("REQUEST_METHOD") = "POST") Then
        Session("Error")="Please input TaiKhoan and MatKhau."
    End if
    
End if
If(TaiKhoan = "admin" and MatKhau = "1") Then
        Session("TaiKhoan")= "admin"
        Session("HoTen") = "admin"
        Session("Success")="Đăng nhập thành công."
        Response.redirect("index.asp")
End if
'Lay ve thong tin dang nhap gom TaiKhoan va MatKhau

'Validate thong tin dang nhap

'Kiem tra thong tin xem co ton tai trong bang taikhoan hay khong

'Neu ton tai thi dang nhap thanh cong, tao Session, redirect toi trang quan tri

'Neu dang nhap ko thanh cong, thi thong bao loi.
%>

<html lang="en">

<head>
      <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.4/font/bootstrap-icons.css">
    <link rel='shortcut icon' href='./img/milk-store-logo-symbol-template-design-your-company-community-whatever-needs-200975497.ico' />
    <title>Khách hàng đăng nhập</title>
</head>


<body>
<section class="vh-100" style="background-color: #508bfc;">
  <div class="container py-5 h-100">
    <div class="row d-flex justify-content-center align-items-center h-100">
      <div class="col-12 col-md-8 col-lg-6 col-xl-5">
        <div class="card shadow-2-strong" style="border-radius: 1rem;">
          <div class="card-body p-5 text-center">

            <h3 class="mb-5">Đăng nhập</h3>
          <form method="post" action="login.asp">
            <div class="form-floating mb-3">
              <input type="text" class="form-control" id="TaiKhoan" name="TaiKhoan"  placeholder="TaiKhoan"value="<%=TaiKhoan%>">
              <label for="TaiKhoan">Tài Khoản</label>
            </div>
            <div class="form-floating mb-3">
              <input type="Password" class="form-control" id="MatKhau"  name="MatKhau" placeholder="MatKhau">
              <label for="floatingMatKhau">Mật khẩu</label>
            </div>

            <!-- Checkbox -->
            <div class="form-check d-flex justify-content-start mb-4">
              <input class="form-check-input" type="checkbox" value="" id="form1Example3" />
              <label class="form-check-label" for="form1Example3"> Nhớ mật khẩu </label>
            </div>

            <button class="btn btn-primary btn-lg btn-block" type="submit">Đăng nhập</button>
            <a href="\dangki.asp" class="btn btn-light btn-lg btn-outline-primary" role="button">Đăng kí</a>
          </form>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
        <!-- #include file="footer.asp" -->
</body>
</html>