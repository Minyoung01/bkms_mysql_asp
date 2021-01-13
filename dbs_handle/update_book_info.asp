<%@Language="vbscript" Codepage="65001"   %>
<!--#include file="../utility/log.asp"-->
<!-- #include file="utility/dbs_connect.asp" -->
<%
if not Session("login") then response.redirect("../resources/templates/signin.html")  
if Session("UserID")="test" then response.Write("<script>alert('当前用户无此操作权限');window.location.href='../admin.asp'</script>")  
'dim conn
'set conn = server.CreateObject("adodb.connection")
'conn.open "driver={MySQL ODBC 8.0 ANSI Driver};server=127.0.0.1; uid=root;password=root;database=books_management"  


dim name,target_id

name=request("name")
book_id=request("book_id")
Call debugLog(name)
Call debugLog(book_id)


on error resume next 'Err对象保存了“错误信息”
sql = "update book_info set name = '"&name&"' where book_id = '"&request.QueryString("target_id")&"'"
Call debugLog(sql)
Set rs = Server.CreateObject( "ADODB.Recordset" )
set res =  conn.execute(sql)
'sql = "select * from book_info order by book_id desc"
        rs.open sql,conn,2,3 '（1,1为只读数据,1,3为插入数据，2,3是修改数据)
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
<%
rs.close '关闭 记录集bai  
set rs=nothing '释放对象 显式声明该变量为du"无"，期望占用的内存能回收（实际情况是常常无zhi法回收）dao
conn.close '关闭 数据库连接
set conn=nothing '释放空间 显式声明该变量为"无"，期望占用的内存能回收（实际情况跟上面一样糟！）
 %>