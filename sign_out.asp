<!--#include file="utility/log.asp"-->
<%
Session("login")=false
Call logInOut("###<ID:"&Session("UserID")&"> |sign out| TIME:")
response.Redirect "resources/templates/signin.html"
%>