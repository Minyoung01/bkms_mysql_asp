<!--#include file="utility/log.asp"-->
<%
Session("login")=false
if not Session("UserID")="" then 
	Call logInOut("###<ID:"&Session("UserID")&"> |sign out| TIME:")
	response.Redirect "resources/templates/signin.html"
else response.Redirect "resources/templates/signin.html"
end if
%>