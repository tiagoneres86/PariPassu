<%-- 
    Document   : monitor
    Created on : 16/09/2015, 16:55:47
    Author     : Tiago Neres da Silva
--%>

<%@page import="java.io.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>SysPWD - Monitor</title>
        <meta http-equiv="refresh" content="1; url=monitor.jsp">
    </head>
    <body>
        <h1>Acompanhe sua senha</h1>
        <input type="text" name="edt_senha" value="<%= session.getAttribute("senhapx") %>">
    </body>
</html>
