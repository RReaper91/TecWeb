<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="beans.User"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css.css" type="text/css" />
        <title>Password Form</title>
    </head>
    <body>
        <div id="foto">
            <div id="login">
                <jsp:useBean id="user" scope="request" class="beans.User"></jsp:useBean>
                
                <form action="PasswordController" method="post">
                    <h1>Cambia Password</h1>
                    
                    <input type="text" name="user" value="<jsp:getProperty name="user" property="user"/>" placeholder="Username">
                    
                    <input type="password" name="pwd" value="<jsp:getProperty name="user" property="pwd"/>" placeholder="Nuova Password">
                    
                    <center><input type="submit" id="login-btn1" value="Cambia Password"></center>
                </form>
            </div>
        </div>
    </body>
</html>
