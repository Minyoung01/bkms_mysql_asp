<!-- 权限验证 -->
<%
if not Session("login") then response.redirect("resources/templates/signin.html")  
%>
<%
dim conn
set conn = server.CreateObject("adodb.connection")
conn.open "driver={MySQL ODBC 8.0 ANSI Driver};server=127.0.0.1; uid=root;password=root;database=books_management"  
response.write conn.state '是否连接成功 
%>
<%	
	dim action
    action = request.QueryString("action")
	    ' 查询操作book_id
    if action="sel_by_book_id_asc" then
    '查询数据按照book_id正序查找
        Set rs = Server.CreateObject( "ADODB.Recordset" )
        sql = "select * from book_info  order by book_id asc"
        rs.open sql,conn,1,1 '（1,1为只读数据,1,3为插入数据，2,3是修改数据)
    elseif action="sel_by_book_id_desc" then
    '查询数据按照book_id逆序查找
        Set rs = Server.CreateObject( "ADODB.Recordset" )
        sql = "select * from book_info  order by book_id desc"
        rs.open sql,conn,1,1 '（1,1为只读数据,1,3为插入数据，2,3是修改数据)

        ' 查询操作name
    elseif action="sel_by_name_asc" then
    '查询数据按照book_id逆序查找
        Set rs = Server.CreateObject( "ADODB.Recordset" )
        sql = "select * from book_info  order by name asc"
        rs.open sql,conn,1,1 '（1,1为只读数据,1,3为插入数据，2,3是修改数据)
    elseif action="sel_by_name_desc" then
    '查询数据按照book_id逆序查找
        Set rs = Server.CreateObject( "ADODB.Recordset" )
        sql = "select * from book_info  order by name desc"
        rs.open sql,conn,1,1 '（1,1为只读数据,1,3为插入数据，2,3是修改数据)
        ' 查血操作author
    elseif action="sel_by_author_asc" then
    '查询数据按照book_id逆序查找
        Set rs = Server.CreateObject( "ADODB.Recordset" )
        sql = "select * from book_info  order by author asc"
        rs.open sql,conn,1,1 '（1,1为只读数据,1,3为插入数据，2,3是修改数据)
    elseif action="sel_by_author_desc" then
    '查询数据按照book_id逆序查找
        Set rs = Server.CreateObject( "ADODB.Recordset" )
        sql = "select * from book_info  order by author desc"
        rs.open sql,conn,1,1 '（1,1为只读数据,1,3为插入数据，2,3是修改数据)
    end if
    response.redirect("../admin.asp")
    response.end()
%>