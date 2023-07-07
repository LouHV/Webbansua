<!--#include file="connect.asp"-->
<%
    ' code here to retrive the data from product table
       function Ceil(Number)
        Ceil = Int(Number)
        if Ceil<>Number Then
            Ceil = Ceil + 1
        end if
    end function

    function checkPage(cond, ret) 
        if cond=true then
            Response.write ret
        else
            Response.write ""
        end if
    end function
' trang hien tai
    page = Request.QueryString("page")
    limit = 10

    if (trim(page) = "") or (isnull(page)) then
        page = 1
    end if

    offset = (Clng(page) * Clng(limit)) - Clng(limit)

    strSQL = "SELECT COUNT(MaSp) AS count FROM SanPham where TrangThai = '1'"
    connDB.Open()
    Set CountResult = connDB.execute(strSQL)

    totalRows = CLng(CountResult("count"))

    Set CountResult = Nothing
' lay ve tong so trang
    pages = Ceil(totalRows/limit)
    'gioi han tong so trang la 5
    Dim range
    If (pages<=5) Then
        range = pages
    Else
        range = 5
    End if   
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
<style>
@import url('https://fonts.googleapis.com/css?family=Montserrat:300,400,500,600,700,800,900|Rubik:300,400,500,700,900');
@charset "utf-8";
</style>
<body>

<!-- #include file="header.asp" -->
    <section style="background-color: #eee;">        
        <div class="container py-3">
        <%
        Set cmdPrep = Server.CreateObject("ADODB.Command")
        cmdPrep.ActiveConnection = connDB
        cmdPrep.CommandType = 1
        cmdPrep.Prepared = True
        cmdPrep.CommandText = "SELECT MaSp,TenSp,LoaiSp,ThuongHieu,MoTa,Gia FROM SanPham where TrangThai = '1' ORDER BY MaSp OFFSET ? ROWS FETCH NEXT ? ROWS ONLY"
        cmdPrep.parameters.Append cmdPrep.createParameter("offset",3,1, ,offset)
        cmdPrep.parameters.Append cmdPrep.createParameter("limit",3,1, , limit)

        Set rs = cmdPrep.execute
        do while not rs.EOF
        %>
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
        <div class="row justify-content-center mb-3">
                <div class="col-md-12 col-xl-10">
                    <div class="card shadow-0 border rounded-3">
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-12 col-lg-3 col-xl-3 mb-4 mb-lg-0">
                                    <div class="bg-image hover-zoom ripple rounded ripple-surface">
                                        <img src="/admin/upload/anh<%= rs("MaSp")%>.png"
                                            class="w-100" />
                                        <a href="">
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
                                        <a class="btn btn-primary btn-sm"  href="chitietsp.asp?idproduct=<%= rs("MaSp")%>">Chi tiết</a>
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
    <nav aria-label="Page Navigation">
                <ul class="pagination pagination-sm justify-content-center my-5">
                    <% if (pages>1) then
                    'kiem tra trang hien tai co >=2
                        if(Clng(page)>=2) then
                    %>
                        <li class="page-item"><a class="page-link" href="product.asp?page=<%=Clng(page)-1%>">Trước</a></li>
                    <%    
                        end if 
                        for i = 1 to range
                    %>
                            <li class="page-item <%=checkPage(Clng(i)=Clng(page),"active")%>"><a class="page-link" href="product.asp?page=<%=i%>"><%=i%></a></li>
                    <%
                        next
                        if (Clng(page)<pages) then

                    %>
                        <li class="page-item"><a class="page-link" href="product.asp?page=<%=Clng(page)+1%>">Sau</a></li>
                    <%
                        end if    
                    end if
                    %>
                </ul>
            </nav>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"
        integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3"
        crossorigin="anonymous"></script> 

<!-- #include file="footer.asp" -->
</body>

</html>