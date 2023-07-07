<!--#include file="connect.asp"-->
<%
    ' code here to retrive the data from product table
    searchInput = Request.QueryString("searchinput")
    Dim sqlString, rs
    sqlString = "Select * from SanPham Where TenSp Like N'%" & searchInput & "%'"
    connDB.Open()
    set rs = connDB.execute(sqlString)    


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
    <title>Milk Store</title>
</head>

<body>
<!-- #include file="header.asp" -->

    <section style="background-color: #eee;">        
        <div class="container py-3">
        <%
        do while not rs.EOF
        %>
        <div class="row justify-content-center mb-3">
                <div class="col-md-12 col-xl-10">
                    <div class="card shadow-0 border rounded-3">
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-12 col-lg-3 col-xl-3 mb-4 mb-lg-0">
                                    <div class="bg-image hover-zoom ripple rounded ripple-surface">
                                        <img src="/admin/upload/anh<%= rs("MaSp")%>.png"
                                            class="w-100" />
                                        <a href="#!">
                                            <div class="hover-overlay">
                                                <div class="mask" style="background-color: rgba(253, 253, 253, 0.15);">
                                                </div>
                                            </div>
                                        </a>
                                    </div>
                                </div>
                                <div class="col-md-6 col-lg-6 col-xl-6">
                                    <h5><%
                                            = rs("TenSp")
                                        %></h5>
                                    
                                    <div class="mt-1 mb-0 text-muted small">
                                        <span>
                                         <%
                                            = rs("LoaiSp")
                                        %>
                                        </span>
                                        <span class="text-primary"> • </span>
                                        <span>
                                         <%
                                            = rs("ThuongHieu")
                                        %>
                                        <br />
                                        </span>
                                        
                                    </div>
                                    
                                    <p class="text-truncate mb-4 mb-md-0">
                                        <%
                                            = rs("MoTa")
                                        %>
                                    </p>
                                </div>
                                <div class="col-md-6 col-lg-3 col-xl-3 border-sm-start-none border-start">
                                    <div class="d-flex flex-row align-items-center mb-1">
                                        <h4 class="mb-1 me-1"><%= rs("Gia")%>đ</h4>
                                    </div>
                                    <h6 class="text-success">Miễn phí vận chuyển</h6>
                                    <div class="d-flex flex-column mt-4">
                                        <button class="btn btn-primary btn-sm" type="button">Chi tiết</button>
                                        <a class="btn btn-outline-primary btn-sm mt-2" href="addCart.asp?idproduct=<%= rs("MaSp")%>">
                                            Thêm vào giỏ hàng
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        <%
            rs.MoveNext
        loop
        rs.Close()
        connDB.Close()
        %>            
    </section>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"
        integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3"
        crossorigin="anonymous"></script> 

<!-- #include file="footer.asp" -->
</body>

</html>