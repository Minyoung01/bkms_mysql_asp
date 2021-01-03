<%
	'查询数据
	Set rs = Server.CreateObject( "ADODB.Recordset" )
	sql = "select * from a_book_info  order by info_id desc limit 0,5"
	rs.open sql,conn,1,3  '（1,1为只读数据,1,3为插入数据，2,3是修改数据)
	%>
<td><input style="width: 100%; height: 100%;border: none; outline-color:red;" type="text" name="<%=rs(" info_id")%>" value="
    <%=rs("title")%>"></td>
<td><a href="?action=del&id=<%=rs(" info_id")%>">删除</a> <a name="btn_<%=rs(" info_id")%>" οnclick="update(this)">确认修改</a></td>
values('"&book_id&"','"&name&"','"&author&"','"&publish&"','"&ISBN&"','"&introduction&"',,'"&price&"','"&language&"','"&pubdate&"','"&class_id&"','"&pressmark&"','"&state&"')"
`author`,`publish`,`ISBN`,`introduction`,`price`,`language`,`pubdate`,`class_id`,`pressmark`,`state`
,'"&author&"','"&publish&"','"&ISBN&"','"&introduction&"','"&price&"','"&language&"','"&pubdate&"','"&class_id&"','"&pressmark&"','"&state&"'