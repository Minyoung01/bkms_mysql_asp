<%@Language="vbscript" Codepage="65001"   %>
<%
if not Session("login") then response.redirect("login.asp")  


dim conn
set conn = server.CreateObject("adodb.connection")
conn.open "driver={MySQL ODBC 8.0 ANSI Driver};server=127.0.0.1; uid=root;password=root;database=books_management"  


on error resume next 'Err对象保存了“错误信息”
sql = "update book_info set name = '"&name&"' where book_id = '"&target_id&"'"
set res =  conn.execute(sql) 
sql = "select * from book_info order by book_id desc"
       
        rs.open sql,conn,1,1 '（1,1为只读数据,1,3为插入数据，2,3是修改数据)
        if Err.number = 0 then
            
            call successFn("修改")
        else
            call errFn("数据修改失败或未修改")
        end if
%>