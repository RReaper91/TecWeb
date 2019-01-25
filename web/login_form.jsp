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
                <form action="LoginController" onsubmit="save()" method="post">
                    <h1>Login</h1>
                    
                    <input type="text" name="user" id="user" class="testo" value="<jsp:getProperty name="user" property="user"/>" placeholder="Username" required>
                    
                    <input type="password" name="pwd" class="testo" value="<jsp:getProperty name="user" property="pwd"/>" placeholder="Password" required>
                    
                    <center><input type="submit" id="login-btn1" value="Entra"></center>
                                       
                    <script>
                        <!--Salvo l'user in modo da stampare il nome nel titolo di benvenuto-->
                        function save(){
                            localStorage.setItem('nick', document.getElementById('user').value);
                        }
                    </script>
                </form>
                    
                     <form>
                        <center><input type="submit" formaction="index.html" id="login-btn1" value="Back Home"></center>
                    </form> 
                
                <!--form per la pagina del cambia password-->
                <form action="password_form.jsp" method="post">
                    <center><td><input type="submit" id="login-btn2" value="Password Dimenticata"></center>
                </form>
            </div>
        </div>
    </body>
</html>
