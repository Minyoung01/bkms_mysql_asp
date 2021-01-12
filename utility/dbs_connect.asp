<%
set conn = server.CreateObject("adodb.connection")
    conn.open "driver={MySQL ODBC 8.0 ANSI Driver};server=127.0.0.1; uid=root;password=root;database=books_management"  
%>