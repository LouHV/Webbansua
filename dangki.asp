<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file="connect.asp" -->

<%

        id = Request.QueryString("id")
        taikhoan = Request.form("taikhoan")
        name = Request.form("name")
        matkhau = Request.form("matkhau")
        sdt = Request.form("sdt")
        diachi = Request.form("diachi")
        if (isnull (id) OR trim(id) = "") then id=0 end if
         if (NOT isnull(taikhoan) and taikhoan<>"" and NOT isnull(matkhau) and matkhau<>""and NOT isnull(name) and name<>""and NOT isnull(sdt) and sdt<>""and NOT isnull(diachi) and diachi<>"") then
                Set cmdPrep = Server.CreateObject("ADODB.Command")
                connDB.Open()                
                cmdPrep.ActiveConnection = connDB
                cmdPrep.CommandType = 1
                cmdPrep.Prepared = True
                cmdPrep.CommandText = "INSERT INTO TKNguoiDung(TaiKhoan,MatKhau,HoTen,SoDT,DiaChi,TrangThai) VALUES(?,?,?,?,?,1)"
                cmdPrep.parameters.Append cmdPrep.createParameter("taikhoan",202,1,255,taikhoan)
                cmdPrep.parameters.Append cmdPrep.createParameter("matkhau",202,1,255,matkhau)
                cmdPrep.parameters.Append cmdPrep.createParameter("name",202,1,255,name)
                cmdPrep.parameters.Append cmdPrep.createParameter("sdt",202,1,255,sdt)
                cmdPrep.parameters.Append cmdPrep.createParameter("diachi",202,1,255,diachi)

                cmdPrep.execute               
               
                If Err.Number = 0 Then 
                ' Set rs = connDB.execute("SELECT @@IDENTITY AS NewID")
                '     Response.write(rs("NewID"))  
                    Session("Success") = "Thêm người dùng thành công!"                    
                    Response.redirect("login.asp")  
                Else  
                    handleError(Err.Description)
                End If
                On Error GoTo 0
            else
                Session("Error") = "Bạn phải nhập đủ thông tin."                
            end if
%>

<html>
<head>
   <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.4/font/bootstrap-icons.css">
    <link rel='shortcut icon' href='./img/milk-store-logo-symbol-template-design-your-company-community-whatever-needs-200975497.ico' />
    <title>Khách hàng đăng kí</title>
</head>
<body>

<section class="vh-100%" style="background-color: #508bfc;">
  <div class="container py-5 h-100%">
    <div class="row d-flex justify-content-center align-items-center h-100%">
      <div class="col-12 col-md-8 col-lg-6 col-xl-5">
        <div class="card shadow-2-strong" style="border-radius: 1rem;">
          <div class="card-body p-6 text-center">

            <h3 class="mb-5">Đăng ký</h3>
            <form method="post" action="dangki.asp" >
            <div class="form-floating mb-3">
              <input type="text" class="form-control" id="taikhoan" name="taikhoan" value="<%=taikhoan%>" placeholder="text">
              <label for="taikhoan">Tên đăng nhập</label>
              <div class="invalid-feedback">Vui lòng kiểm tra lại tên đăng nhập (Không để trống và có ít nhất 5 ký tự).</div>

            </div>
            <div class="form-floating mb-3">
              <input type="password" class="form-control" id="matkhau" name="matkhau"value="<%=matkhau%>" placeholder="Password">
              <label for="matkhau">Mật khẩu</label>
              <div class="invalid-feedback">Vui lòng kiểm tra lại mật khẩu (Có độ dài 8 ký tự trong đó có ít nhất 1 ký tự thường, ký tự hoa, số, ký tự đặc biệt).</div>
            </div>
            <div class="form-floating mb-3">
              <input type="text" class="form-control" id="name" name="name" value="<%=name%>" placeholder="text">
              <label for="name">Họ và tên</label>
              <div class="invalid-feedback">Vui lòng không để trống Họ và tên.</div>

            </div>
            <div class="form-floating mb-3">
              <input type="text" class="form-control" id="sdt" name="sdt" value="<%=sdt%>" placeholder="text">
              <label for="sdt">Số điện thoại</label>
              <div class="invalid-feedback">Vui lòng kiểm tra lại SĐT (bắt đầu từ 0 và có 10 số).</div>
            </div>
            <div class="form-floating mb-3">
              <input type="text" class="form-control" id="diachi" name="diachi" value="<%=diachi%>" placeholder="text">
              <label for="diachi">Địa chỉ</label>
              <div class="invalid-feedback">Vui lòng không để trống địa chỉ.</div>
            </div>

            <!-- Checkbox -->
            <div class="form-check d-flex justify-content-start mb-4" >
              <input class="form-check-input" type="checkbox" value="" id="invalidCheck" required />
                    <label class="form-check-label" for="invalidCheck"> Tôi đồng ý với các điều khoản sử dụng và chính sách bảo mật của Store. </label>
               <div class="invalid-feedback">
                Bạn cần đồng ý với điều khoản trước khi đăng ký.
                </div>
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
            <a href="\login.asp" class="btn btn-light btn-lg btn-outline-primary" role="button">Đăng nhập</a>
            <button class="btn btn-primary btn-lg btn-block " type="submit">Đăng Ký</button>

              
            </form>
  
          </div>
        </div>
      </div>
    </div>
  </div>
</section>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
    <script>
 

        document.querySelector('#taikhoan').addEventListener('blur', validateTaikhoan);

        document.querySelector('#matkhau').addEventListener('blur', validateMatkhau);

        document.querySelector('#name').addEventListener('blur', validateName);
        
        document.querySelector('#sdt').addEventListener('blur', validateSdt);
        
         document.querySelector('#diachi').addEventListener('blur', validateDiachi);

        const reSpaces = /^\S*$/;

       
        
        function validateTaikhoan(e){
            const taikhoan = document.querySelector('#taikhoan');
            const re =  /^.{5,}$/;
             if (reSpaces.test(taikhoan.value) && re.test(taikhoan.value)) {
                taikhoan.classList.remove('is-invalid');
                taikhoan.classList.add('is-valid');

                return true;
            } else {
                taikhoan.classList.add('is-invalid');
                taikhoan.classList.remove('is-valid');

                return false;
            }
        }

        function validateSdt(e){
            const sdt = document.querySelector('#sdt');
            const re = /^0\d{9}$/;
             if (reSpaces.test(sdt.value) && re.test(sdt.value)) {
                sdt.classList.remove('is-invalid');
                sdt.classList.add('is-valid');

                return true;
            } else {
                sdt.classList.add('is-invalid');
                sdt.classList.remove('is-valid');

                return false;
            }
        }

        function validateMatkhau(e){
            const sdt = document.querySelector('#matkhau');
            const re = /(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.{8,})(?=.*[!@#$%^&*])/;
             if (reSpaces.test(matkhau.value) && re.test(matkhau.value)) {
                matkhau.classList.remove('is-invalid');
                matkhau.classList.add('is-valid');

                return true;
            } else {
                matkhau.classList.add('is-invalid');
                matkhau.classList.remove('is-valid');

                return false;
            }
        }
        function validateName(){
            const name = document.querySelector('#name');            

             if (name.value!="") {
                name.classList.remove('is-invalid');
                name.classList.add('is-valid');

                return true;
            } else {
                name.classList.add('is-invalid');
                name.classList.remove('is-valid');

                return false;
            }
        }

        function validateDiachi(e){
            const diachi = document.querySelector('#diachi');

             if (diachi.value !="") {
                diachi.classList.remove('is-invalid');
                diachi.classList.add('is-valid');

                return true;
            } else {
                diachi.classList.add('is-invalid');
                diachi.classList.remove('is-valid');

                return false;
            }
        }

      

        (function() {
            const forms = document.querySelectorAll('.needs-validation');

            for (let form of forms) {
                form.addEventListener('submit',function(event) {
                        if (!form.checkValidity() ||
                            !validateTaikhoan()||
                            !validateMatkhau()||
                            !validateName()||
                            !validateSdt()||
                            !checkValidity()
                        ) {
                            event.preventDefault();
                            event.stopPropagation();
                        } else {
                            form.classList.add('was-validated');
                        }
                    alert("Đăng kí thành công")
                    },
                    false
                );
            }
        })();
    </script>
           <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js" 
integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ" 
crossorigin="anonymous">
</script> 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>  
<script>
    window.setTimeout(function() {
    $(".alert").fadeTo(500, 0).slideUp(500, function(){
        $(this).remove(); 
    });
}, 2000);
</script>
</body>

</html>