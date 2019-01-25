<!--Pagina di login dell'user per entrare nella pagina dell'utente registrato-->

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="beans.User"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css.css" type="text/css" />
        <title>Login</title>
    </head>
    <body>
        
        <div id="foto">
            <div id="login">
                <jsp:useBean id="user" scope="request" class="beans.User"></jsp:useBean>
                
             
                <!--form per il controllo delle credenziali utente -->
                <form action="AdminController" method="post">
                    <h1>Login Admin</h1>
                    <!--Inseriamo l'username dell'utente registrato preso dal db-->
                    <input type="text" name="user" class="testo" value="<jsp:getProperty name="user" property="user"/>" placeholder="Username" required>
                    <!--Inseriamo la password dell'user presa dal db-->
                    <input type="password" name="pwd" class="testo" value="<jsp:getProperty name="user" property="pwd"/>" placeholder="Password" required>
                    <!--Bottone che ci porta nella pagina dell'user-->
                    <center><input type="submit" id="login-btn" value="Entra"></center>
                    
            </form>
                   <form>
                        <center><input type="submit" formaction="index.html" id="login-btn1" value="Back Home"></center>
                    </form>    
            </div>
        </div>
    </body>
</html>
