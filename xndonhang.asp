<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file="connect.asp" -->
<%
    If (isnull(Session("TaiKhoan")) OR TRIM(Session("TaiKhoan"))  = " ") Then
        Response.redirect("login.asp")
    End If
    On Error Resume Next
    id = Request.QueryString("id")

   

    Set cmdPrep = Server.CreateObject("ADODB.Command")
    connDB.Open()
    cmdPrep.ActiveConnection = connDB
    cmdPrep.CommandType = 1
    cmdPrep.CommandText = "UPDATE Hoadon SET TrangThaiHD = '1' WHERE IdHoadon=?"
    cmdPrep.parameters.Append cmdPrep.createParameter("IdHoadon",3,1, ,id)

    cmdPrep.execute
    connDB.Close()
    If Err.Number = 0 Then
    Session("Success") = "Xác nhận đã nhận hàng thành công."    
    Else
        Session("Error") = Err.Description
    End If
    Response.Redirect("donhang.asp")
    On Error Goto 0    

    
%>