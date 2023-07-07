<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="connect.asp"-->
<%
'lay ve danh sach product theo id trong my cart
   connDB.Open()
    dim giam
     If (Request.ServerVariables("REQUEST_METHOD") = "POST") THEN
     MaGG = Request.form("nhapkm")
     Set cmdPrep = Server.CreateObject("ADODB.Command")
      cmdPrep.ActiveConnection = connDB
      cmdPrep.CommandType = 1
      cmdPrep.Prepared = True
      cmdPrep.CommandText = "Select * from GiamGia where IdMagiamgia = ? and getdate() < NgayKT and getdate() > NgayBD "
      cmdPrep.parameters.Append cmdPrep.createParameter("IdMagiamgia",3,1, ,MaGG)
      Set Result = cmdPrep.execute
    If not Result.EOF then
      giam = Result("Giatri")
    else
      giam = 0
    end if
    Result.Close()
 End If

 
Dim idList, mycarts, totalProduct, subtotal, statusViews, statusButtons, rs
If (NOT IsEmpty(Session("mycarts"))) Then
  statusViews = "d-none"
  statusButtons = "d-block"
' true
	Set mycarts = Session("mycarts")
	idList = ""
	totalProduct=mycarts.Count    
	For Each List In mycarts.Keys
		If (idList="") Then
' true
			idList = List
		Else
			idList = idList & "," & List
		End if                               
	Next
	Dim sqlString
	sqlString = "Select * from SanPham where MaSp IN (" & idList &")"
	set rs = connDB.execute(sqlString)
	calSubtotal(rs)
  Else
    'Session empty
    statusViews = "d-block"
    statusButtons = "d-none"
    totalProduct=0
  End If
  Sub calSubtotal(rs)
' Do Something...
		subtotal = 0
		do while not rs.EOF
			subtotal = subtotal + Clng(mycarts.Item(CStr(rs("MaSp")))) * CDbl(CStr(rs("Gia")))
			rs.MoveNext
		loop
		rs.MoveFirst
	End Sub
  Sub defineItems(v)
    If (v>1) Then
      Response.Write(" Sản phẩm")
    Else
      Response.Write(" Sản phẩm")
    End If
  End Sub
  dim total
  total = subtotal - giam
  Dim sqlString2, rs2, mhdht
    sqlString2 = "Select Max(IdHoadon) as Max from HoaDon"
     set rs2 = connDB.execute(sqlString2) 
    If not rs2.EOF Then
       if( rs2("Max") ) then
         mhdht = rs2("Max") + 1
       else
         mhdht = 1
       end if
    end if
  
%>
<!DOCTYPE html>
<html lang="en">

<head>

   <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.4/font/bootstrap-icons.css">
    <link rel='shortcut icon' href='./img/milk-store-logo-symbol-template-design-your-company-community-whatever-needs-200975497.ico' />
    <title>Giỏ hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">

</head>

<body>
<!-- #include file="header.asp" -->
   <%
        If (NOT isnull(Session("Success"))) AND (TRIM(Session("Success"))<>"") Then
    %>
            <div class="alert alert-success mt-2" role="alert">
                <%=Session("Success")%>
            </div>
    <%
            Session.Contents.Remove("Success")
        End If
    %>
<section class="h-100 h-custom" style="background-color: #eee; ">
  <div class="container py-2 h-100">
    <div class="row d-flex justify-content-center align-items-center h-100">
      <div class="col-12">
        <div class="card card-registration card-registration-2" style="border-radius: 15px;">
          <div class="card-body p-0">
            <div class="row g-0">
              <div class="col-lg-8">
                <div class="p-4">
                  <div class="d-flex justify-content-between align-items-center mb-5">
                    <h1 class="fw-bold mb-0 text-black">Giỏ hàng</h1>
                    <h6 class="mb-0 text-muted"><%= totalProduct %> <%call defineItems(totalProduct) %></h6>
                  </div>
                  <form action="removecart.asp" method=post>
                  <hr class="my-4">
                  <h5 class="mt-3 text-center text-body-secondary <%= statusViews %>">Bạn không có sản phẩm nào được thêm vào giỏ hàng của bạn.</h5>
<%
                If (totalProduct<>0) Then
                do while not rs.EOF
                %>
                  <div class="row mb-4 d-flex justify-content-between align-items-center">
                    <div class="col-md-2 col-lg-2 col-xl-2">
                      <img
                        src="/admin/upload/anh<%= rs("MaSp")%>.png"
                        class="img-fluid rounded-3" alt="Cotton T-shirt">
                    </div>
                    <div class="col-md-3 col-lg-3 col-xl-3">
                      <h6 class="text-muted"><%= rs("TenSp")%></h6>
                      <h6 class="text-black mb-0"><%= rs("MoTa")%></h6>
                    </div>
                     <div class="col-md-3 col-lg-3 col-xl-2 d-flex">
                      <button class="btn btn-link px-2"
                        onclick="this.parentNode.querySelector('input[type=number]').stepDown()">
                        <i class="fas fa-minus"></i>
                      </button>

                      <input id="form1" min="0" name="quantity" value="<%
                                    Dim id
                                    id  = CStr(rs("masp"))
                                    Response.Write(mycarts.Item(id))                                     
                                    %>" type="number"
                        class="form-control form-control-sm" />

                      <button class="btn btn-link px-2"
                        onclick="this.parentNode.querySelector('input[type=number]').stepUp()">
                        <i class="fas fa-plus"></i>
                      </button>
                    </div>
                     
                    <div class="col-md-3 col-lg-2 col-xl-2 offset-lg-1">
                      <h6 class="mb-0"><%= rs("Gia")%> đ</h6>
                    </div>
                    <div class="col-md-1 col-lg-1 col-xl-1 text-end">
                    
                      <a href="removecart.asp?id=<%= rs("MaSp")%>" class="text-muted"><i class="fas fa-times"></i></a>
                    </div>
                  </div>

                  <hr class="my-4">
<%
                rs.MoveNext
                loop
                'phuc vu cho viec update subtotal
                rs.MoveFirst
                End If
                %> 
                
                  <div class="row pt-2">
                    <h6 class="mb-0 col-lg-10 pt-3"><a href="product.asp" class="text-body"><i
                          class="fas fa-long-arrow-alt-left me-2"></i>Quay trở lại cửa hàng</a></h6>
                          
                  </div>
                </form>
                </div>
              </div>
              <div class="col-lg-4 bg-secondary-subtle <%= statusButtons %>">
                
                <div class="p-5">
                  <h3 class="fw-bold mb-5 mt-2 pt-1">TÓM TẮT</h3>
                  <hr class="my-4">

                  <div class="d-flex justify-content-between mb-4">
                    <h5 class="text-uppercase"><%= totalProduct %> <%call defineItems(totalProduct) %></h5>
                    <h5><%= subtotal%> Đ</h5>
                  </div>
                  
                  <h5 class="text-uppercase mb-3">Vận chuyển</h5>

                  <div class="mb-4 pb-2">
                    Miễn phí
                  </div>

                  <h5 class="text-uppercase mb-3">Mã khuyến mại</h5>
                  <form method='post' >
                  <div class="mb-5">
                    <div class="form-outline">
                      <input type="text" id="form3Examplea2" name="nhapkm" class="form-control form-control-lg" placeholder="Nhập mã của bạn tại đây"/> 
                    </div>
                    <button type="submit" class="mt-2 btn btn-success btn-lg"
                      data-mdb-ripple-color="dark">Áp Dụng</button> 
                  </div>
                  </form>
               
                  <h5 class="d-flex flex-row-reverse" ><%= - giam%> Đ</h5>
                  <hr class="my-4">

                  <div class="d-flex justify-content-between mb-5">
                    <h5 class="text-uppercase">Tổng tiền</h5>
        
                    <h5><%= total %>  Đ</h5>
                  </div>
                  <div class="row">
                 
                    <a href="themhoadon.asp?total=<%= total%>&id=<%=mhdht%>"  class="btn btn-success btn-lg">Mua Hàng</a>
                    
                  </div>
                </div>
              </div>
            </div>
          </div>
         </div>
      </div>
    </div>
  </div>
</section>

<!-- #include file="footer.asp" -->
<script></script>
</body>

</html>