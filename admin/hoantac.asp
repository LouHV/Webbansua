<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file="..\connect.asp" -->
<%
    If (isnull(Session("TaiKhoan")) OR TRIM(Session("TaiKhoan")) <> "admin") Then
        Response.redirect("login.asp")
    End If
    On Error Resume Next
    id = Request.QueryString("id")

   

    Set cmdPrep = Server.CreateObject("ADODB.Command")
    connDB.Open()
    cmdPrep.ActiveConnection = connDB
    cmdPrep.CommandType = 1
    cmdPrep.CommandText = "UPDATE SanPham SET TrangThai = '1' WHERE Masp=?"
    cmdPrep.parameters.Append cmdPrep.createParameter("MaSp",3,1, ,id)

    cmdPrep.execute
    connDB.Close()
    If Err.Number = 0 Then
    Session("Success") = "Đã hoàn tác."    
    Else
        Session("Error") = Err.Description
    End If
    Response.Redirect("sanpham.asp")
    On Error Goto 0    

    
%>