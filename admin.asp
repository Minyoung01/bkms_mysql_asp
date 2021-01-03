<%@Language="vbscript" Codepage="65001"   %>
<!-- 中文显示 -->
<!-- 权限验证 -->
<%
if not Session("login") then response.redirect("login.asp")  
%>
<!-- 数据库连接 -->
<%
dim conn
set conn = server.CreateObject("adodb.connection")
conn.open "driver={MySQL ODBC 8.0 ANSI Driver};server=127.0.0.1; uid=root;password=root;database=books_management"  
response.write conn.state '是否连接成功 %>
<%
    dim action,book_id,sql,name
    target_id = request.QueryString("target_id")
    name =request.QueryString("name")
    action = request.QueryString("action")
    book_id=request.QueryString("book_id")
    response.Write action
    Set rs = Server.CreateObject( "ADODB.Recordset" )
    ' 默认操作
    if action="" then
        Set rs = Server.CreateObject( "ADODB.Recordset" )
        sql = "select * from book_info  order by book_id desc"
        rs.open sql,conn,1,1 '（1,1为只读数据,1,3为插入数据，2,3是修改数据)
    elseif action = "update" then
        '改
        on error resume next 'Err对象保存了“错误信息”
        sql = "update book_info set name = '"&name&"' where book_id = '"&target_id&"'"
        set res =  conn.execute(sql) 
        sql = "select * from book_info order by book_id desc"
        rs.open sql,conn,1,1 '（1,1为只读数据,1,3为插入数据，2,3是修改数据)
        if Err.number = 0 then
            
            call successFn("修改")
        else
            call errFn("数据修改失败或未修改")
        end if
     
    elseif action="del" then
        '删
        on error resume next 'Err对象保存了“错误信息”
        sql = "delete from book_info where book_id ='"&book_id&"'"
        response.Write(sql)
        set res =  conn.execute(sql)
        if Err.number = 0 then
            sql = "select * from book_info  order by book_id desc"
            rs.open sql,conn,1,1 '（1,1为只读数据,1,3为插入数据，2,3是修改数据)
            call successFn("删除")
        else
            call errFn("数据删除失败")
        end if
    elseif action="add" then
        ' 增
        '

        if request.form("book_id") = "" then
            response.Write("<script>alert('ID为空');window.history.back().reload;</script>")
        elseif request.form("name") = "" then
            response.Write("<script>alert('书名为空');window.history.back().reload;</script>")
        elseif request.form("author") = "" then
            response.Write("<script>alert('作者为空');window.history.back().reload;</script>")
        elseif request.form("publish") = "" then
            response.Write("<script>alert('出版社为空');window.history.back().reload;</script>")
        elseif request.form("ISBN") = "" then
            response.Write("<script>alert(ISBND为空');window.history.back().reload;</script>")
        elseif request.form("introduction") = "" then
            response.Write("<script>alert('介绍为空');window.history.back().reload;</script>")
        elseif request.form("price") = "" then
            response.Write("<script>alert('价格为空');window.history.back().reload;</script>")
        elseif request.form("language") = "" then
            response.Write("<script>alert('语言为空');window.history.back().reload;</script>")
        elseif request.form("pubdate") = "" then
            response.Write("<script>alert('发行时间为空');window.history.back().reload;</script>")
        elseif request.form("class_id") = "" then
            response.Write("<script>alert('类别为空');window.history.back().reload;</script>")
        elseif request.form("pressmark") = "" then
            response.Write("<script>alert('书架号为空');window.history.back().reload;</script>")
        elseif request.form("state") = "" then
            response.Write("<script>alert('state为空');window.history.back().reload;</script>")
        else
        ' '判断空值
            sql = "select * from book_info order by book_id desc"
            rs.open sql,conn,1,1 '（1,1为只读数据,1,3为插入数据，2,3是修改数据)
            ' 遍历数据开始
            do while not rs.eof '如果指针不再最后一行
            response.Write request.form("book_id")
            response.Write rs("book_id")
                if trim(request.form("book_id")) = trim(rs("book_id")) then
                    response.Write("<script>alert('ID重复');window.history.back().reload;</script>")





                    Response.End()





                end if 
                rs.movenext '让指针向下移动一行,不然会报错
            loop
            ' 遍历数据结束
            on error resume next 'Err对象保存了“错误信息”
            sql = "insert into book_info(`book_id`,`name`,`author`,`publish`,`ISBN`,`introduction`,`price`,`language`,`pubdate`,`class_id`,`pressmark`,`state`) values('"&request.form("book_id")&"','"&request.form("name")&"','"&request.form("author")&"','"&request.form("publish")&"','"&request.form("ISBN")&"','"&request.form("introduction")&"','"&request.form("price")&"','"&request.form("language")&"','"&request.form("pubdate")&"','"&request.form("class_id")&"','"&request.form("pressmark")&"','"&request.form("state")&"')"
            set res =  conn.execute(sql)
            if Err.number = 0 then
                sql = "select * from book_info  order by author desc"
                rs.open sql,conn,1,3 '（1,1为只读数据,1,3为插入数据，2,3是修改数据)
                call successFn("插入")
            else
                call errFn("数据插入失败")
            end if
        end if

        ' 查询操作book_id
    elseif action="sel_by_book_id_asc" then
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
<!doctype html>
<html lang="en" xmlns:th="http://www.thymeleaf.org">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Jekyll v4.0.1">
    <title>Signin Template · Bootstrap</title>
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/4.3.1/css/bootstrap.min.css">
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
    <link href="resources/static/css/dashboard.css" rel="stylesheet">
    <link href="resources/static/css/admin.css" rel="stylesheet">
</head>

<body>
    <nav class="navbar navbar-dark sticky-top bg-dark flex-md-nowrap p-0 shadow">
        <a class="navbar-brand col-md-3 col-lg-2 mr-0 px-3" href="#">Company name</a>
        <button class="navbar-toggler position-absolute d-md-none collapsed" type="button" data-toggle="collapse" data-target="#sidebarMenu" aria-controls="sidebarMenu" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <input class="order-control order-control-dark w-100" type="text" placeholder="Search" aria-label="Search">
        <ul class="navbar-nav px-3">
            <li class="nav-item text-nowrap">
                <a class="nav-link" href="sign_out.asp">退出登录</a>
            </li>
        </ul>
    </nav>
    <div class="container-fluid">
        <div class="row">
            <nav id="sidebarMenu" class="col-md-3 col-lg-2 d-md-block bg-light sidebar collapse">
                <div class="sidebar-sticky pt-3">
                    <ul class="nav flex-column">
                        <li class="nav-item">
                            <a class="nav-link active" href="#">
                                <span data-feather="home"></span>
                                图书管理系统<span class="sr-only">(current)</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">
                                <span data-feather="file"></span>
                                Orders
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">
                                <span data-feather="shopping-cart"></span>
                                Products
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">
                                <span data-feather="users"></span>
                                Customers
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">
                                <span data-feather="bar-chart-2"></span>
                                Reports
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">
                                <span data-feather="layers"></span>
                                Integrations
                            </a>
                        </li>
                    </ul>
                    <h6 class="sidebar-heading d-flex justify-content-between align-items-center px-3 mt-4 mb-1 text-muted">
                        <span>Saved reports</span>
                        <a class="d-flex align-items-center text-muted" href="#" aria-label="Add a new report">
                            <span data-feather="plus-circle"></span>
                        </a>
                    </h6>
                    <ul class="nav flex-column mb-2">
                        <li class="nav-item">
                            <a class="nav-link" href="#">
                                <span data-feather="file-text"></span>
                                Current month
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">
                                <span data-feather="file-text"></span>
                                Last quarter
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">
                                <span data-feather="file-text"></span>
                                Social engagement
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">
                                <span data-feather="file-text"></span>
                                Year-end sale
                            </a>
                        </li>
                    </ul>
                </div>
            </nav>
            <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-md-4">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2">图书管理系统</h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <div class="btn-group mr-2">
                            <button type="button" class="btn btn-sm btn-outline-secondary">Share</button>
                            <button type="button" class="btn btn-sm btn-outline-secondary">Export</button>
                        </div>
                        <button type="button" class="btn btn-sm btn-outline-secondary dropdown-toggle">
                            <span data-feather="calendar"></span>
                            This week
                        </button>
                    </div>
                </div>
                <div>
                    <!-- Button trigger modal -->
                    <button type="button" class="btn btn-outline-success" data-toggle="modal" data-target="#exampleModal">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-file-plus" viewBox="0 0 16 16">
                            <path fill-rule="evenodd" d="M4 0h8a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2V2a2 2 0 0 1 2-2zm0 1a1 1 0 0 0-1 1v12a1 1 0 0 0 1 1h8a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1H4z" />
                            <path fill-rule="evenodd" d="M8 5.5a.5.5 0 0 1 .5.5v1.5H10a.5.5 0 0 1 0 1H8.5V10a.5.5 0 0 1-1 0V8.5H6a.5.5 0 0 1 0-1h1.5V6a.5.5 0 0 1 .5-.5z" />
                        </svg>添加图书
                    </button>
                    <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="exampleModalLabel">填写数据（每项都为必填）</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <form name="add_data" action="dbs_handle/insert_book_info.asp" method="post">
                                        <div class="form-group">
                                            <input type="text" name="book_id" id="book_id" class="form-control" placeholder="ID">
                                        </div>
                                        <div class="form-group">
                                            <input type="text" name="name" d="name" class="form-control" placeholder="书名">
                                        </div>
                                        <div class="form-group">
                                            <input type="text" name="author" class="form-control" placeholder="作者">
                                        </div>
                                        <div class="form-group">
                                            <input type="text" name="publish" class="form-control" placeholder="出版社">
                                        </div>
                                        <div class="form-group">
                                            <input type="text" name="ISBN" class="form-control" placeholder="ISBN">
                                        </div>
                                        <div class="form-group">
                                            <input type="text" name="introduction" class="form-control" placeholder="简介">
                                        </div>
                                        <div class="form-group">
                                            <input type="text" name="language" class="form-control" placeholder="语言">
                                        </div>
                                        <div class="form-group">
                                            <input type="text" name="price" class="form-control" placeholder="价格/人民币">
                                        </div>
                                        <div class="form-group">
                                            <input type="text" name="pubdate" class="form-control" placeholder="发行时期2017-06-21">
                                        </div>
                                        <div class="form-group">
                                            <input type="text" name="class_id" class="form-control" placeholder="类别">
                                        </div>
                                        <div class="form-group">
                                            <input type="text" name="pressmark" class="form-control" placeholder="书架号">
                                        </div>
                                        <div class="form-group">
                                            <input type="text" name="state" class="form-control" placeholder="state">
                                        </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
                                    <button type="submit" class="btn btn-primary">提交</button>
                                </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                <br>
                <div class="table-responsive">
                    <table class="table table-striped table-sm">
                        <thead>
                            <tr>
                                <th>
                                    <div class="btn-group">
                                        <button type="button" class="btn btn-outline-primary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                            ID
                                        </button>
                                        <div class="dropdown-menu">
                                            <a class="dropdown-item" href="admin.asp?action=sel_by_book_id_asc">正序</a>
                                            <a class="dropdown-item" href="admin.asp?action=sel_by_book_id_desc">逆序</a>
                                        </div>
                                    </div>
                                </th>
                                <th>
                                    <div class="btn-group">
                                        <button type="button" class="btn btn-outline-primary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                            书名
                                        </button>
                                        <div class="dropdown-menu">
                                            <a class="dropdown-item" href="admin.asp?action=sel_by_name_asc">正序</a>
                                            <a class="dropdown-item" href="admin.asp?action=sel_by_name_desc">逆序</a>
                                        </div>
                                    </div>
                                </th>
                                <th>
                                    <div class="btn-group">
                                        <button type="button" class="btn btn-outline-primary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                            作者
                                        </button>
                                        <div class="dropdown-menu">
                                            <a class="dropdown-item" href="admin.asp?action=sel_by_author_asc">正序</a>
                                            <a class="dropdown-item" href="admin.asp?action=sel_by_author_desc">逆序</a>
                                        </div>
                                    </div>
                                </th>
                                <th>
                                    <div class="btn-group">
                                        <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                            出版社
                                        </button>
                                        <div class="dropdown-menu">
                                            <a class="dropdown-item" href="#">Action</a>
                                            <a class="dropdown-item" href="#">Another action</a>
                                            <a class="dropdown-item" href="#">Something else here</a>
                                            <div class="dropdown-divider"></div>
                                            <a class="dropdown-item" href="#">Separated link</a>
                                        </div>
                                    </div>
                                </th>
                                <th>ISBN</th>
                                <th>简介</th>
                                <th>语言</th>
                                <th>
                                    <div class="btn-group">
                                        <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                            价格
                                        </button>
                                        <div class="dropdown-menu">
                                            <a class="dropdown-item" href="#">Action</a>
                                            <a class="dropdown-item" href="#">Another action</a>
                                            <a class="dropdown-item" href="#">Something else here</a>
                                            <div class="dropdown-divider"></div>
                                            <a class="dropdown-item" href="#">Separated link</a>
                                        </div>
                                    </div>
                                </th>
                                <th>
                                    <div class="btn-group">
                                        <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                            发行时期
                                        </button>
                                        <div class="dropdown-menu">
                                            <a class="dropdown-item" href="#">Action</a>
                                            <a class="dropdown-item" href="#">Another action</a>
                                            <a class="dropdown-item" href="#">Something else here</a>
                                            <div class="dropdown-divider"></div>
                                            <a class="dropdown-item" href="#">Separated link</a>
                                        </div>
                                    </div>
                                </th>
                                <th>
                                    <div class="btn-group">
                                        <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                            类别
                                        </button>
                                        <div class="dropdown-menu">
                                            <a class="dropdown-item" href="#">Action</a>
                                            <a class="dropdown-item" href="#">Another action</a>
                                            <a class="dropdown-item" href="#">Something else here</a>
                                            <div class="dropdown-divider"></div>
                                            <a class="dropdown-item" href="#">Separated link</a>
                                        </div>
                                    </div>
                                </th>
                                <th>
                                    <div class="btn-group">
                                        <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                            书架号
                                        </button>
                                        <div class="dropdown-menu">
                                            <a class="dropdown-item" href="#">Action</a>
                                            <a class="dropdown-item" href="#">Another action</a>
                                            <a class="dropdown-item" href="#">Something else here</a>
                                            <div class="dropdown-divider"></div>
                                            <a class="dropdown-item" href="#">Separated link</a>
                                        </div>
                                    </div>
                                </th>
                                <th>
                                    <div class="btn-group">
                                        <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                            状态
                                        </button>
                                        <div class="dropdown-menu">
                                            <a class="dropdown-item" href="#">Action</a>
                                            <a class="dropdown-item" href="#">Another action</a>
                                            <a class="dropdown-item" href="#">Something else here</a>
                                            <div class="dropdown-divider"></div>
                                            <a class="dropdown-item" href="#">Separated link</a>
                                        </div>
                                    </div>
                                </th>
                                <th>
                                    操作
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
            if (rs.EOF and rs.BOF) then
                    '1、BOF 和 EOF 属性返回bai布尔型值。 
                    '2、BOF 当前指针的位置是在第一行记录之前，则... EOF 当前指针的位置是在最后一行记录之后，则...
                    '3、那么这句话的意思就是：如果 rs没有结束并且没有开始（表示在文本排列中），则满足条件,即没有这个数据
                response.write "no this data"
            else
                ' 遍历数据开始
                do while not rs.eof '如果指针不再最后一行
                %>
                            <tr>
                                <%
                                response.write "<td ondblclick='ShowElement(this)' id='book_id_"&rs("book_id")&"''>"&rs("book_id")&"</td>"
                                response.write "<td ondblclick='ShowElement(this)' id='name_"&rs("book_id")&"''>"&rs("name")&"</td>"
                                response.write "<td ondblclick='ShowElement(this)' id='author_"&rs("book_id")&"''>"&rs("author")&"</td>"
                                response.write "<td ondblclick='ShowElement(this)' id='publish_"&rs("book_id")&"''>"&rs("publish")&"</td>"
                                response.write "<td ondblclick='ShowElement(this)' id='ISBN_"&rs("book_id")&"''>"&rs("ISBN")&"</td>"
                                response.write "<td ondblclick='ShowElement(this)' id='introduction_"&rs("book_id")&"'' class='text-len-limted'>"&rs("introduction")&"</td>"
                                response.write "<td ondblclick='ShowElement(this)' id='language_"&rs("book_id")&"''>"&rs("language")&"</td>"
                                response.write "<td ondblclick='ShowElement(this)' id='price_"&rs("book_id")&"''>"&rs("price")&"</td>"
                                response.write "<td ondblclick='ShowElement(this)' id='pubdate_"&rs("book_id")&"''>"&rs("pubdate")&"</td>"
                                response.write "<td ondblclick='ShowElement(this)' id='class_id_"&rs("book_id")&"''>"&rs("class_id")&"</td>"
                                response.write "<td ondblclick='ShowElement(this)' id='pressmark_"&rs("book_id")&"''>"&rs("pressmark")&"</td>"
                                response.write "<td ondblclick='ShowElement(this)' id='pressmark_"&rs("book_id")&"''>"&rs("state")&"</td>" 
                                response.write "<td> <a class='btn btn-outline-danger' href='?action=del&book_id="&rs("book_id")&"'>Delete</a>"

                                response.write "<button type='button' class='btn btn-outline-primary' ondblclick='update("&rs("book_id")&")'><svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-pen' viewBox='0 0 16 16'><path fill-rule='evenodd' d='M13.498.795l.149-.149a1.207 1.207 0 1 1 1.707 1.708l-.149.148a1.5 1.5 0 0 1-.059 2.059L4.854 14.854a.5.5 0 0 1-.233.131l-4 1a.5.5 0 0 1-.606-.606l1-4a.5.5 0 0 1 .131-.232l9.642-9.642a.5.5 0 0 0-.642.056L6.854 4.854a.5.5 0 1 1-.708-.708L9.44.854A1.5 1.5 0 0 1 11.5.796a1.5 1.5 0 0 1 1.998-.001zm-.644.766a.5.5 0 0 0-.707 0L1.95 11.756l-.764 3.057 3.057-.764L14.44 3.854a.5.5 0 0 0 0-.708l-1.585-1.585z'></path></svg>Update</button>"
                                %>
                            </tr>
                            <%
                rs.movenext '让指针向下移动一行,不然会报错
                loop
                ' 遍历数据结束
            end if
 
                            %>
                        </tbody>
                    </table>
                </div>
            </main>
        </div>
    </div>
    <script src="https://cdn.staticfile.org/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/popper.js/1.15.0/umd/popper.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/feather-icons/4.9.0/feather.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.3/Chart.min.js"></script>
    <!-- 使用bt4务必引入此文件！！！！！！！ -->
    <script src="https://cdn.staticfile.org/twitter-bootstrap/4.3.1/js/bootstrap.min.js"></script>
    <script src="resources/static/js/dashboard.js"></script>
    <script type="text/javascript">
    function ShowElement(element) {
        var oldhtml = element.innerHTML;
        //创建新的input元素
        var newobj = document.createElement('input');
        //为新增元素添加类型
        newobj.type = 'text';
        //为新增元素添加value值
        newobj.value = oldhtml;
        //为新增元素添加光标离开事件
        newobj.onblur = function() {
            element.innerHTML = this.value == oldhtml ? oldhtml : this.value;
            //当触发时判断新增元素值是否为空，为空则不修改，并返回原有值
        }
        //设置该标签的子节点为空
        element.innerHTML = '';
        //添加该标签的子节点，input对象
        element.appendChild(newobj);
        //设置选择文本的内容或设置光标位置（两个参数：start,end；start为开始位置，end为结束位置；如果开始位置和结束位置相同则就是光标位置）
        newobj.setSelectionRange(0, oldhtml.length);
        //设置获得光标
        newobj.focus();
    }
    </script>
    <script type="text/javascript">
    function update(target_id) {
        var data = {};
        //必要信息，需要判断
        data.target_id = target_id;
        data.book_id = $.trim($("#book_id_" + data.target_id).text());
        data.name = $.trim($("#name_" + data.target_id).text());
        data.author = $.trim($("#author_" + data.target_id).text());
        $.ajax({
            url: window.location.href + "?action=update&target_id=" + data.target_id + "&name=" + data.name,
            async: true,
            type: "get"
        });
    }
    </script>
</body>

</html>
<%
rs.close '关闭 记录集bai  
set rs=nothing '释放对象 显式声明该变量为du"无"，期望占用的内存能回收（实际情况是常常无zhi法回收）dao
conn.close '关闭 数据库连接
set conn=nothing '释放空间 显式声明该变量为"无"，期望占用的内存能回收（实际情况跟上面一样糟！）
 %>