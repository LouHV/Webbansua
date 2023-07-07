<!-- #include file="connect.asp" -->
<%
' khi moi san pham duoc add vao gio hang, tien hanh lay ra s_Carts, tang them 1 phan tu cua mang va luu lai trong sesssion
' ham lam tron so nguyen
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

    strSQL = "SELECT COUNT(IdMagiamgia) AS count FROM GiamGia "
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
    <title>Đơn hàng của bạn</title>
    
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
    <div class="content">
    <!-- #include file="header.asp" -->
    <div class="container">
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
        <div class="d-flex bd-highlight mb-3">
            <div class="me-auto p-2 bd-highlight"><h2>Danh sách mã giảm giá</h2></div>
               
            </div>
            <div class="table-responsive">
                <table class="table table-dark">
                    <thead>
                        <tr>
                            <th scope="col">Mã giảm giá </th>
                            <th scope="col">Thông tin</th>
                            <th scope="col">Ngày bắt đầu</th>
                            <th scope="col">Ngày kết thúc</th>
                            <th scope="col">Giá trị mã giảm giá</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            Set cmdPrep = Server.CreateObject("ADODB.Command")
                            cmdPrep.ActiveConnection = connDB
                            cmdPrep.CommandType = 1
                            cmdPrep.Prepared = True
                            cmdPrep.CommandText = "SELECT IdMagiamgia,ThongTin,NgayBD,NgayKT,Giatri FROM GiamGia ORDER BY IdMagiamgia   OFFSET ? ROWS FETCH NEXT ? ROWS ONLY"
                            cmdPrep.parameters.Append cmdPrep.createParameter("offset",3,1, ,offset)
                            cmdPrep.parameters.Append cmdPrep.createParameter("limit",3,1, , limit)

                            Set Result = cmdPrep.execute
                            do while not Result.EOF
                        %>
                                <tr>
                                    <td><%=Result("IdMagiamgia")%></td>
                                    <td><%=Result("ThongTin")%></td>
                                    <td><%=Result("NgayBD")%></td>
                                    <td><%=Result("NgayKT")%></td>
                                    <td><%=Result("Giatri")%></td>
                                </tr>
                        <%
                                Result.MoveNext
                            loop
                        %>
                    </tbody>
                </table>
            </div>

            <nav aria-label="Page Navigation">
                <ul class="pagination pagination-sm justify-content-center my-5">
                    <% if (pages>1) then
                    'kiem tra trang hien tai co >=2
                        if(Clng(page)>=2) then
                    %>
                        <li class="page-item"><a class="page-link" href="ctgiamgia.asp?page=<%=Clng(page)-1%>">Trước</a></li>
                    <%    
                        end if 
                        for i = 1 to range
                    %>
                            <li class="page-item <%=checkPage(Clng(i)=Clng(page),"active")%>"><a class="page-link" href="ctgiamgia.asp?page=<%=i%>"><%=i%></a></li>
                    <%
                        next
                        if (Clng(page)<pages) then

                    %>
                        <li class="page-item"><a class="page-link" href="ctgiamgia.asp?page=<%=Clng(page)+1%>">Sau</a></li>
                    <%
                        end if    
                    end if
                    %>
                </ul>
            </nav>
      
        </div>
    </div> 
</div>
    
        </div>
     <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"
        integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3"
        crossorigin="anonymous"></script> 
<!-- #include file="footer.asp" -->    
</body>
</html>