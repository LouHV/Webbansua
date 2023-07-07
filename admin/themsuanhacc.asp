<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--Step 1: Register Uploader to your page -->  

<!-- #include file="..\connect.asp" -->
<%
    If (isnull(Session("TaiKhoan")) OR TRIM(Session("TaiKhoan")) = "") Then
        Response.redirect("login.asp")
    End If
    If (Request.ServerVariables("REQUEST_METHOD") = "GET") THEN        
        id = Request.QueryString("id")
        If (isnull(id) OR trim(id) = "") then 
            id=0 
        End if
        If (cint(id)<>0) Then
            Set cmdPrep = Server.CreateObject("ADODB.Command")
            connDB.Open()
            cmdPrep.ActiveConnection = connDB
            cmdPrep.CommandType = 1
            cmdPrep.CommandText = "SELECT TenNhacc,DCNhacc,SDTNhacc FROM Nhacc WHERE MaNhacc=?"
            ' cmdPrep.parameters.Append cmdPrep.createParameter("MaNV",3,1, ,id)
            cmdPrep.Parameters(0)=id
            Set Result = cmdPrep.execute 

            If not Result.EOF then
                TenNhacc = Result("TenNhacc")
                DCNhacc = Result("DCNhacc")
                SDTNhacc = Result("SDTNhacc")
              
            End If

            ' Set Result = Nothing
            Result.Close()
        End If
    Else
        id = Request.QueryString("id")
        TenNhacc = Request.form("TenNhacc")
        DCNhacc = Request.form("DCNhacc")
        SDTNhacc = Request.form("SDTNhacc")

        if (isnull (id) OR trim(id) = "") then id=0 end if
        
        if (cint(id)=0) then
            if (NOT isnull(TenNhacc) and TenNhacc<>"" and NOT isnull(DCNhacc) and DCNhacc<>"" and NOT isnull(SDTNhacc) and SDTNhacc<>"" ) then
                Set cmdPrep = Server.CreateObject("ADODB.Command")
                connDB.Open()
                cmdPrep.ActiveConnection = connDB
                cmdPrep.CommandType = 1
                cmdPrep.Prepared = True
                cmdPrep.CommandText = "INSERT INTO Nhacc(TenNhacc,DCNhacc,SDTNhacc) VALUES(?,?,?)"
              
                cmdPrep.Parameters(0)=TenNhacc
                cmdPrep.Parameters(1)=DCNhacc
                cmdPrep.Parameters(2)=SDTNhacc

                cmdPrep.execute    
                Session("Success") = "Thêm nhà cung cấp thành công."
                Response.redirect("Nhacc.asp")
            else
                Session("Error") = "Bạn phải nhập đủ thông tin."                
            end if
        else
            if (NOT isnull(TenNhacc) and TenNhacc<>"" and NOT isnull(DCNhacc) and DCNhacc<>"" and NOT isnull(SDTNhacc) and SDTNhacc<>"" ) then
                Set cmdPrep = Server.CreateObject("ADODB.Command")
                connDB.Open()
                cmdPrep.ActiveConnection = connDB
                cmdPrep.CommandType = 1
                cmdPrep.Prepared = True
                cmdPrep.CommandText = "UPDATE Nhacc SET TenNhacc=?,DCNhacc=?,SDTNhacc=? WHERE MaNhacc=?"
                cmdPrep.parameters.Append cmdPrep.createParameter("TenNhacc",202,1,255,TenNhacc)
                cmdPrep.parameters.Append cmdPrep.createParameter("DCNhacc",202,1,255,DCNhacc)
                cmdPrep.parameters.Append cmdPrep.createParameter("SDTNhacc",202,1,255,SDTNhacc)
                cmdPrep.parameters.Append cmdPrep.createParameter("MaNhacc",3,1, ,id)

                cmdPrep.execute
                Session("Success") = "Sửa thành công."
                Response.redirect("Nhacc.asp") 
            else
                Session("Error") = "Bạn phải nhập đủ thông tin"
            end if
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
    <%
    id = Request.QueryString("id")
    if(cint(id) = 0) Then
    Dim sqlString, rs
    sqlString = "Select Max(MaNhacc) as Max from Nhacc "
    connDB.Open()
    set rs = connDB.execute(sqlString) 
    If not rs.EOF Then
    %>   
    <h5> Mã nhà cung cấp hiện tại: <%=rs("Max")+1%></h5>
    <%
    End If
    End If
    %>
   <div class="mb-3">  
   
    </div>  
    <form method="post"  >
    <div class="mb-3">
    <label for="TenNhacc" class="form-label">Tên nhà cung cấp</label>
    <input type="text" class="form-control" name="TenNhacc" id="TenNhacc" value="<%=TenNhacc%>">
    </div>
    <div class="mb-3">
    <label for="DCNhacc" class="form-label">Địa chỉ nhà cung cấp</label>
    <input type="text" class="form-control" name="DCNhacc" id="DCNhacc" value="<%=DCNhacc%>">
    </div>
    <div class="mb-3">
   <label for="SDTNhacc" class="form-label">Số điện thoại nhà cung cấp</label>
    <input type="text" class="form-control" name="SDTNhacc" id="SDTNhacc" value="<%=SDTNhacc%>">
    </div>
    <div> 
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
    <button type="submit" class="btn btn-primary">
        <%
            if (id=0) then
                Response.write("Thêm")
            else
                Response.write("Sửa")
            end if
        %>
        </button>
        <a href="Nhacc.asp" class="btn btn-info">Quay lại</a>  
              
    </form>
    
    <div> 
</div>
        <!-- #include file="footer.asp" -->
</body>
</html>