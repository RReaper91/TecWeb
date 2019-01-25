<%@page contentType="text/html" pageEncoding="UTF-8"%>
 
<!DOCTYPE html>
<html>
    <link rel="stylesheet" href="tabella_css.css" type="text/css" />
    <link rel="stylesheet" href="mappa_css.css" type="text/css" />
     <link rel="stylesheet" href="css.css" type="text/css" />
    <head>
        <script type="text/javascript">
            /**
             * caricamento dei dati salvati nel web storage
             */
            var media = parseFloat(<%=request.getAttribute("avg") %>);
            var nome = localStorage.getItem('nome');
            var inqui = localStorage.getItem('inqui');
            window.onload = function(){
                document.getElementById('nomecitta').innerHTML = nome;
                document.getElementById('nomeinqui').innerHTML = inqui;
                document.getElementById('media').innerHTML = media;
            };
            
            /**
             * controllo sul valore medio dell'inquinante. 
             * se supera una determinata soglia viene visualizzato un pop-up
             */
            if (media >50){
                window.alert("Nella città " + nome + " l'inquinante " + inqui + " ha una media superiore a 50");
            }
        </script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Media</title>
    </head>
    <body>
        <%
            /**
             * controllo sull'autenticazione: 
             * se non si è autenticati non è possibile accedere alla pagina.
             */
            if (session != null){
                if(session.getAttribute("user")!=null){
                    //
                }else   
                    response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
            }
        %>
        <div id="foto"></div>
      <div align="center">
            <table align="center">
                
                <thead>
                    <tr>
                        <th><b>CITTA'</b></th>
                        <th><b>INQUINANTE</b></th>
                        <th><b>MEDIA</b></th>
                    </tr>
                </thead>
                <tbody>
            
            <tr>
			
                <td id="nomecitta"></td>
                <td id="nomeinqui"></td>
                <td id="media"></td>

            </tr>
            
        </table>
      </div>
        <form action="mappa.jsp" onsubmit="clear()">
            <center><input type="submit" value='back'></center>
            <script>
                /**
                 * i dati salvati in web storage vengono cancellati
                 */
                function clear(){
                    localStorage.removeItem('nome');
                    localStorage.removeItem('inqui');
                    localStorage.removeItem('inizio');
                    localStorage.removeItem('fine');
                }
            </script>
        </form>
    </body>
</html>
