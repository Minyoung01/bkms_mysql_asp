<!DOCTYPE doctype html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1, shrink-to-fit=no" name="viewport">
</head>
<title>添加图书</title>

<body>
    <%@Language="vbscript" Codepage="65001"   %>
    <!-- 判断权限 -->
    <%if not Session("login") then response.redirect("../login.asp")
    if Session("UserID")="test" then response.Write("<script>alert('当前用户无此操作权限');window.location.href='../admin.asp'</script>")  
    %>
    <!-- 函数定义 -->
    <%  
        Sub WriteLog(logStr)
                Const ForAppending = 8 '8追加，2重写
                LogFile = Server.MapPath("/bkms/bkms_mysql_asp/log/dbs_log/insert_book_info.txt")
                Set objFSO = CreateObject("Scripting.FileSystemObject")
                If objFSO.FileExists(LogFile) Then
                    Set objFile = objFSO.OpenTextFile(LogFile,ForAppending)
                Else
                    Set objFile = objFSO.CreateTextFile(LogFile)
                End If
                objFile.Writeline logStr&Now
                objFile.Close
        End Sub
        Sub successFn(title)
        response.Write("<script>alert('数据"&title&"成功');window.location.href='../admin.asp'</script>")
        response.End()
        End sub

        Sub errFn(title)
        errMessage = "错误号:"&Err.Number & chr(10) & "错误来源:"&Err.Source & chr(10)&"错误描述:"&Err.Description & chr(10)
        response.Write(errMessage)
        response.Write("<script>alert('"&title&",页面未跳转');window.history.back().reload;</script>")
        response.End()
        End sub

        Sub responseEndWithMsg(res_msg)
        response.Write("<script>alert('"&res_msg&"');window.history.back().reload;</script>")
        response.End()
        End sub
    %>
    <!-- 判断空值 -->
    <%
        if request.form("book_id") = "" then
            call responseEndWithMsg("ID为空")  
        end if
        if request.form("name") = "" then
            call responseEndWithMsg("书名为空")   
        end if
        if request.form("author") = "" then
            call responseEndWithMsg("作者为空")   
        end if
        if request.form("publish") = "" then
            call responseEndWithMsg("出版社为空")   
        end if
        if request.form("ISBN") = "" then
            call responseEndWithMsg("ISBND为空")   
        end if
        if request.form("introduction") = "" then
            call responseEndWithMsg("介绍为空")   
        end if
        if request.form("price") = "" then
            call responseEndWithMsg("价格为空")   
        end if
        if request.form("language") = "" then
            call responseEndWithMsg("发行时间为空")   
        end if
        if request.form("pubdate") = "" then
            call responseEndWithMsg("发行时间为空")   
        end if
        if request.form("class_id") = "" then
            call responseEndWithMsg("类别为空")   
        end if
        if request.form("pressmark") = "" then
            call responseEndWithMsg("书架号为空")   
        end if
        if request.form("state") = "" then
            call responseEndWithMsg("state为空")   
        end if
    %>
    <!-- 连接数据库 -->
    <!-- #include file="../utility/dbs_connect.asp" -->
    <%
        'dim conn
        'set conn = server.CreateObject("adodb.connection")
        'conn.open "driver={MySQL ODBC 8.0 ANSI Driver};server=127.0.0.1; uid=root;password=root;database=books_management"  
        Set rs = Server.CreateObject( "ADODB.Recordset" )
    %>
    <!-- 判断重复ID -->
    <%
        sql = "select * from book_info order by book_id desc"
        rs.open sql,conn,1,1 '（1,1为只读数据,1,3为插入数据，2,3是修改数据)
        ' 遍历数据开始
        do while not rs.eof '如果指针不再最后一行
            if trim(request.form("book_id")) = trim(rs("book_id")) then
                call responseEndWithMsg("ID重复")   
            end if 
            rs.movenext '让指针向下移动一行,不然会报错
        loop' 遍历数据结束
    %>
    <!-- 执行插入操作 -->
    <%
            on error resume next 'Err对象保存了“错误信息”
            sql = "insert into book_info(`book_id`,`name`,`author`,`publish`,`ISBN`,`introduction`,`price`,`language`,`pubdate`,`class_id`,`pressmark`,`state`) values('"&request.form("book_id")&"','"&request.form("name")&"','"&request.form("author")&"','"&request.form("publish")&"','"&request.form("ISBN")&"','"&request.form("introduction")&"','"&request.form("price")&"','"&request.form("language")&"','"&request.form("pubdate")&"','"&request.form("class_id")&"','"&request.form("pressmark")&"','"&request.form("state")&"')"
            set res =  conn.execute(sql)
            if Err.number = 0 then
                Call WriteLog("###<ID:"&Session("UserID")&"> INSERT ID=|"&request.form("book_id")&"| 的数据  |SUCCESS|  TIME:")
                rs.open sql,conn,1,3 '（1,1为只读数据,1,3为插入数据，2,3是修改数据)     
                call successFn("插入")
            else
                Call WriteLog("###<ID:"&Session("UserID")&"> INSERT ID=|"&request.form("book_id")&"| 的数据  |ERRRORS|  TIME:")
                call errFn("数据插入失败")
            end if
    %>
    <!-- 关闭数据库 -->
    <%
        rs.close '关闭 记录集bai  
        set rs=nothing '释放对象 显式声明该变量为du"无"，期望占用的内存能回收（实际情况是常常无zhi法回收）dao
        conn.close '关闭 数据库连接
        set conn=nothing '释放空间 显式声明该变量为"无"，期望占用的内存能回收（实际情况跟上面一样糟！）
    %>
</body>

</html>