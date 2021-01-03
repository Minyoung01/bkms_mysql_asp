<!--#include file="utility/log.asp"-->
<%
    Sub GetSession(UserID,UserPWD)
        Session("UserID")=UserID
        Session("UserPWD")=UserPWD
    End Sub

    if request("action")="checkLogin" then
        dim sql,conn
        UserID = replace(trim(request("account")),"'","")
        UserPWD = replace(trim(request("password")),"'","")
        set conn = server.CreateObject("adodb.connection")
        conn.open "driver={MySQL ODBC 8.0 ANSI Driver};server=127.0.0.1; uid=root;password=root;database=books_management"  
        Set rs = Server.CreateObject( "ADODB.Recordset" )
        sql="select * from admin where admin_id="&UserID&" and password="&UserPwd&""
        rs.open sql,conn,2,3
        if rs.eof and rs.bof then
%>
<script language="javascript">
    alert("用户名或密码错误！请重新输入！")
top.document.location="login.asp"
</script>
<%
        else
            Session("UserID")=rs("admin_id")
            Session("UserPWD")=rs("password")
            Session("login")=true
            Session.Timeout=30
            Call logInOut("###<ID:"&Session("UserID")&"> |log   in| TIME:")
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
<html lang="en" xmlns:th="http://www.thymeleaf.org">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Jekyll v4.0.1">
    <title>登录</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.0/dist/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
    <!-- Bootstrap core CSS -->
    <style>
        .bd-placeholder-img {
            font-size: 1.125rem;
            text-anchor: middle;
            -webkit-user-select: none;
            -moz-user-select: none;
            -ms-user-select: none;
            user-select: none;
        }

        @media (min-width: 768px) {
            .bd-placeholder-img-lg {
                font-size: 3.5rem;
            }
        }
    </style>
    <!-- Custom styles for this template -->
    <link href="css/signin.css" rel="stylesheet">
</head>

<body class="text-center">
    <form class="form-signin" action="login.asp?action=checkLogin" method="post">
        <img class="mb-4" src="assets/bkmsLog.png" alt="" width="72" height="72">
        <h1 class="h3 mb-3 font-weight-normal">Please sign in</h1>
        <label for="inputEmail" class="sr-only">Administrator Account</label>
        <input id="inputEmail" name="account" class="form-control" placeholder="Email address" required autofocus>
        <label for="inputPassword" class="sr-only">Administrator Password</label>
        <input type="password" name="password" id="inputPassword" class="form-control" placeholder="Password" required>
        <div class="checkbox mb-3">
            <label>
                <input type="checkbox" value="remember-me"> Remember me
            </label>
        </div>
        <div class="modal fade" id="loginModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">提示</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body" name="feedback" id="feedback-login">
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
                        <!--
                                                    <button type="button" class="btn btn-primary" >确定</button>
                    -->
                    </div>
                </div>
            </div>
        </div>
        <button class="btn btn-lg btn-primary btn-block" type="submit" data-toggle="modal" data-target="#loginModal">登录</button>
        <p class="mt-5 mb-3 text-muted">&copy; 2017-2020</p>
    </form>
    <script src="js/jquery-3.5.1.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.0/dist/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script>
    <script>
    $('#loginModal').on('shown.bs.modal', function() {
        var data = {};
        //必要信息，需要判断
        data.adminAccount = $.trim($("input[name=account]").val());
        data.adminPassword = $.trim($("input[name=password]").val());
        if (data.adminAccount === '') {
            $("#feedback-login").html("账户不能为空");
            $('#loginModal').modal('show')
            return;
        }
        if (data.adminPassword === '') {
            $("#feedback-login").html("密码不能为空");
            $('#loginModal').modal('show')
        } else {
            $('#loginModal').modal('show')
        }
        /*$.ajax({
            url: "/background",
            async: true,
            type: "post",
            dataType: "text",
            data: data,
            success: function (data) {
                if (data === 'success') {
                    return;
                }
                $("#feedback").html(data);
                $('#loginModal').modal('show')
            }
        });*/

    });
    </script>
</body>

</html>