<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
        'code for delete a product from my cart
        'lay ve product id
        If (isnull(Session("TaiKhoan")) OR TRIM(Session("TaiKhoan")) = "") Then
        Response.redirect("login.asp")
        End If
        Dim mycarts
        If (NOT IsEmpty(Session("mycarts"))) Then
            Set mycarts = Session("mycarts")
            If (Request.ServerVariables("REQUEST_METHOD") = "GET") THEN
                Dim pid
                pid = Request.QueryString("id")
                if mycarts.Exists(pid) = true then
                    mycarts.Remove(pid)
                    If (mycarts.Count>0) Then
                    'True
                        Set Session("mycarts") = mycarts
                    Else
                    'remove session mycarts
                    Session.Contents.Remove("mycarts")
                    End If
                    'saving new session value
                
                Session("Success") = "Sản phẩm đã được xoá ra khỏi giỏ hàng của bạn."  
                Else
                Session("Error") = "Sản phẩm không tồn tại vui lòng xem lại."   
                end if            
            ElseIf (Request.ServerVariables("REQUEST_METHOD") = "POST") Then
            'Do something... 
              'Button update de cap nhat lai so luong va gia
            'check when button update submit
            'tinh toan so tien
            'lay ve quantity
                    Dim quantityArray
                    quantityArray = Request.Form("quantity")
                    quantityArrays = Split(quantityArray,",")
                    Dim count
                    count = 0  
                    For Each tmp In mycarts.Keys
                    mycarts.Item(tmp) = Clng(quantityArrays(count))
                    count = count + 1
                    Next
            'saving new session value
                    Set Session("mycarts") = mycarts            
                End If
        End If
        Response.Redirect("shoppingcart.asp")              
%>