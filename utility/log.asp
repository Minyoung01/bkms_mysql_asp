<!DOCTYPE doctype html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1, shrink-to-fit=no" name="viewport">
</head>
<title></title>

<body>
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
%>
    <%
    Sub logInOut(logStr)
        Const ForAppending = 8 '8追加，2重写
        LogFile = Server.MapPath("/bkms/bkms_mysql_asp/log/user_log/log_in_out.txt")
        Set objFSO = CreateObject("Scripting.FileSystemObject")
        If objFSO.FileExists(LogFile) Then
            Set objFile = objFSO.OpenTextFile(LogFile,ForAppending)
        Else
            Set objFile = objFSO.CreateTextFile(LogFile)
        End If
        objFile.Writeline logStr&Now
        objFile.Close
    End Sub
%>
    <%
    Sub updateLog(logStr)
        Const ForAppending = 8 '8追加，2重写
        LogFile = Server.MapPath("/bkms/bkms_mysql_asp/log/dbs_log/update_book_info.txt")
        Set objFSO = CreateObject("Scripting.FileSystemObject")
        If objFSO.FileExists(LogFile) Then
            Set objFile = objFSO.OpenTextFile(LogFile,ForAppending)
        Else
            Set objFile = objFSO.CreateTextFile(LogFile)
        End If
        objFile.Writeline logStr&Now
        objFile.Close
    End Sub
%>
</body>

</html>