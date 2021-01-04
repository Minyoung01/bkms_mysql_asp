<%@Language="vbscript" Codepage="65001"   %>
<%
if not Session("login") then response.redirect("../../resources/templates/signin.html")  


dim conn
set conn = server.CreateObject("adodb.connection")
conn.open "driver={MySQL ODBC 8.0 ANSI Driver};server=127.0.0.1; uid=root;password=root;database=books_management"  


on error resume next 'Err对象保存了“错误信息”
sql = "update book_info set name = '"&name&"' where book_id = '"&target_id&"'"
set res =  conn.execute(sql) 
sql = "select * from book_info order by book_id desc"
       
        rs.open sql,conn,1,1 '（1,1为只读数据,1,3为插入数据，2,3是修改数据)
        if Err.number = 0 then
            Call updateLog("###<ID:"&Session("UserID")&"> UPDATE ID=|"&request.QueryString("target_id")&"| 的数据  |SUCCESS|  TIME:")
            call successFn("修改")
        else
            Call updateLog("###<ID:"&Session("UserID")&"> UPDATE ID=|"&request.QueryString("target_id")&"| 的数据  |ERROR  |  TIME:")
            call errFn("数据修改失败或未修改")
        end if

    
    ' 函数定义
    sub successFn(title)
        response.Write("<script>alert('数据"&title&"成功');window.location.Reload()</script>")
    end sub
    sub errFn(title)
        errMessage = "错误号:"&Err.Number & chr(10) & "错误来源:"&Err.Source & chr(10)&"错误描述:"&Err.Description & chr(10)
        response.Write(errMessage)
        response.Write("<script>alert('"&title&",页面未跳转');</script>")
    end sub
%>