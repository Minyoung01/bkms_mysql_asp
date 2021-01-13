<!--#include file="utility/log.asp"-->
<!-- #include file="utility/dbs_connect.asp"-->
<%
    Sub GetSession(UserID,UserPWD)
        Session("UserID")=UserID
        Session("UserPWD")=UserPWD
    End Sub

    if request("action")="checkLogin" then
        dim sql
        UserID = replace(trim(request("account")),"'","")
        UserPWD = replace(trim(request("password")),"'","")
        'set conn = server.CreateObject("adodb.connection")
        'conn.open "driver={MySQL ODBC 8.0 ANSI Driver};server=127.0.0.1; uid=root;password=root;database=books_management"  
        Set rs = Server.CreateObject( "ADODB.Recordset" )
        sql="select * from admin where admin_id='"&UserID&"' and password='"&UserPwd&"'"
        Call debugLog(sql)
        rs.open sql,conn,2,3
        if rs.eof and rs.bof then
%>
<script language="javascript">
alert("用户名或密码错误！请重新输入！")
top.document.location = "resources/templates/signin.html"
</script>
<%
        else
            Session("UserID")=rs("admin_id")
            Session("UserPWD")=rs("password")
            Session("login")=true
            Session.Timeout=30
            Call logInOut("###<ID:"&Session("UserID")&"> |sign  in| TIME:")
            Response.Redirect("admin.asp")
            rs.close
            set rs=nothing
            conn.close
            set conn=nothing
            response.End()

        ' 不同权限管理员
        ' if rs("jb")>"6" then
        ' Session("Name")=rs("unames")
        ' end if
        ' if rs("jb")<"6" then
        ' response.Write("对不起你没有权限，请与管理员联系。bai联系方式：<a href='mailto:drizzlelmy@126.com'>drizzlelmy@126.com</a> ")
        ' response.End()
        ' end if
            
        end if
    end if
        
%>
<!doctype html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>登录</title>
</head>

<body class="text-center">
</body>

</html>