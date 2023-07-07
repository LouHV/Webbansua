<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="connect.asp"-->
<%
        'code for delete a product from my cart
        'lay ve product id
        If (isnull(Session("TaiKhoan")) OR TRIM(Session("TaiKhoan")) = "") Then
        Response.redirect("login.asp")
        End If
        If (Request.ServerVariables("REQUEST_METHOD") = "GET") THEN
            
            Dim total,mycarts, mhdht
             total = Request.QueryString("total")
             mhdht = cint(Request.QueryString("id"))
            if(total > 0) then    
                Set cmdPrep = Server.CreateObject("ADODB.Command")
                connDB.Open()
                cmdPrep.ActiveConnection = connDB
                cmdPrep.CommandType = 1
                cmdPrep.Prepared = True
                cmdPrep.CommandText = "INSERT INTO HoaDon(TaiKhoan,TongHD,NgayBan,TrangThaiHD) VALUES(?,?, getdate(),0)"
                cmdPrep.Parameters(0)= Session("TaiKhoan")
                cmdPrep.Parameters(1)=total
                cmdPrep.execute 
               
                connDB.Close()
            end if  
           Set mycarts = Session("mycarts")
            

            For Each List In mycarts.Keys
                ' Response.Write("The value of key gr is: " & mycarts.Item(List))   
                dim id
                id=  cint(List)     
                    Dim sql
                    sql = "select * from SanPham where MaSp = ?"
                    Dim cmdPrep
                    set cmdPrep = Server.CreateObject("ADODB.Command")
                    connDB.Open()
                    cmdPrep.ActiveConnection = connDB
                    cmdPrep.CommandType=1
                    cmdPrep.Prepared=true
                    cmdPrep.CommandText = sql
                    cmdPrep.Parameters(0)= id
                    Dim result
                    set result = cmdPrep.execute()
                    'kiem tra ket qua result o day
                    If not result.EOF Then  
                        If( cint(result("SoLuong")) > 0 and cint(result("SoLuong")) >  cint(mycarts.Item(List))) then
                                Set cmdPrep = Server.CreateObject("ADODB.Command")
                                cmdPrep.ActiveConnection = connDB
                                cmdPrep.CommandType = 1
                                cmdPrep.Prepared = True
                                cmdPrep.CommandText = "INSERT INTO CTHDBan(Masp,IdHoadon,GiaBan,SoLuong) VALUES(?,?,?,?)"
                                cmdPrep.Parameters(0)= result("MaSp")
                                cmdPrep.Parameters(1)=  mhdht
                                cmdPrep.Parameters(2)=  result("Gia")
                                cmdPrep.Parameters(3)=  mycarts.Item(List)
                                cmdPrep.execute 
                        else 
                             Set cmdPrep = Server.CreateObject("ADODB.Command")
                                cmdPrep.ActiveConnection = connDB
                                cmdPrep.CommandType = 1
                                cmdPrep.CommandText = "DELETE FROM HoaDon WHERE IdHoaDon=?"
                                cmdPrep.parameters.Append cmdPrep.createParameter("IdHoaDon",3,1, ,mhdht)
                                cmdPrep.execute
                         End if  

                    end if  
                    connDB.Close()
            Next

                   
            Session.Contents.Remove("mycarts")  
            Response.Redirect("donhang.asp")
        End If
                      
%>