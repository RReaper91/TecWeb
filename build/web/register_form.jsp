<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="beans.User"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css.css" type="text/css" />
        <title>Registration Form</title>
    </head>
    <body>
        <div id="foto">
            <div id="login">
                <jsp:useBean id="user" scope="request" class="beans.User"></jsp:useBean>
                
                <form action="RegisterController" method="post">
                    <h1>Registrazione</h1>
                    
                    <input type="text" name="first_name" value="<jsp:getProperty name="user" property="first_name"/>" placeholder="Nome" required>
                    
                    <input type="text" name="last_name" value="<jsp:getProperty name="user" property="last_name"/>" placeholder="Cognome" required>
                    
                    <input type="text" name="user" value="<jsp:getProperty name="user" property="user"/>" placeholder="Username" required>
                    
                    <input type="password" name="pwd" value="<jsp:getProperty name="user" property="pwd"/>" placeholder="Password" required>
                    
                    <input type="text" name="email" value="<jsp:getProperty name="user" property="email"/>" placeholder="Email" required>
                    
                    <input type="text" name="citta" value="<jsp:getProperty name="user" property="citta"/>" placeholder="Citta" required>
                    
                    <input type="date" name="data" id="dnascita" value="<jsp:getProperty name="user" property="data"/>" placeholder="Data di nascita" required>
                    
                    <center><input type="submit" id="login-btn1" value="Registrazione"></center>
                    
                    <center><input type="reset" id="login-btn2" value="Reset"></center>
                    
                </form>
                    
                    <form>
                        <center><input type="submit" formaction="index.html" id="login-btn1" value="Back Home"></center>
                    </form> 
            </div>
        </div>
    </body>
</html>
