<!------------------------------------------------------------------------------
    Questa sezione serve per importare le librerie utili per il collegamento al
    db e per crearne quindi la connessione
------------------------------------------------------------------------------->
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.ArrayList"%>

<!--Creo una connessione al database con userid root e password nulla-->
<%
    int val=0;
    ArrayList posizione = new ArrayList();
    String id = request.getParameter("userId");
    String driverName = "com.mysql.jdbc.Driver";
    String connectionUrl = "jdbc:mysql://localhost:3306/techworld3g";
    String userId = "root";
    String password = "";
    
    try {
        Class.forName(driverName);
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
    }
    
    Connection connection = null;
    Statement statement = null;
    ResultSet resultSet = null;
%>

<!--Passo la connessione al db ed eseguo una query per prendermi solamente il nome della citta , la latitudine e la longitudine-->
<script type="text/javascript">
    <%
        try {
            connection = DriverManager.getConnection(connectionUrl, userId, password);
            statement=connection.createStatement();
            String sql ="SELECT DISTINCT nome, latd, longit,inqui FROM map";
            resultSet = statement.executeQuery(sql);
            while(resultSet.next()){
                posizione.add(resultSet.getFloat("latd"));
                posizione.add(resultSet.getFloat("longit"));

            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    %>
</script>

<!-- aggiornamento automatico dei valori degli inquinanti nella tabella-->
<script type="text/javascript">
    <%
        try{
            connection = DriverManager.getConnection(connectionUrl, userId, password);
            statement=connection.createStatement();
            String sql ="INSERT INTO map (nome,latd,longit,inqui,valore) SELECT DISTINCT nome,latd,longit,inqui, RAND()*100 FROM map";
            statement = connection.prepareStatement(sql);
            
            statement.executeUpdate(sql);
        } catch (Exception e) {
            e.printStackTrace();
        }
    %>
</script>
<!------------------------------------------------------------------------------
    FINE
------------------------------------------------------------------------------->

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="beans.Add"%>

<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="initial-scale=1.0, user-scalable=no">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <link rel="stylesheet" href="mappa_css.css" type="text/css" />
        <meta http-equiv=Refresh content="3600; URL=mappa.jsp">
        <link rel="stylesheet" href="tabella_css.css" type="text/css" />
        <link rel="stylesheet" href="css.css" type="text/css" />
        <meta charset="utf-8">
        <title>Area Utente</title>
        
        <!--Script che prende il nome dell'user salvato in sessiostorage e lo usa per metterlo nel titolo-->
        <script type="text/javascript">
            var nick = localStorage.getItem('nick');
            window.onload = function(){
                document.getElementById('nickname').innerHTML = "Benvenuto " + nick;
            };
        </script>
        
       <!--script per il controllo se la data inserita per il calcolo della media sia giusta e non sbagliata-->
        <script type="text/javascript">
            function save(){
                localStorage.setItem('nome', document.getElementById('citta').value);
                localStorage.setItem('inqui', document.getElementById('inquinante').value);
                localStorage.setItem('inizio', document.getElementById('dinizio').value);
                localStorage.setItem('fine', document.getElementById('dfine').value);
                    
                var inizio = document.getElementById('dinizio').value;
                var fine = document.getElementById('dfine').value;
                if (inizio > fine){
                    alert("ATTENZIONE!!\nLa data di inizio deve essere più piccola della data di fine");
                    return false;
                } else{
                    return true;
                }
            }
        </script>
       
    </head>
    <body>
        <div id="foto"></div>
        <jsp:useBean id="user" scope="request" class="beans.Add"></jsp:useBean>
        <!--Controllo che l'utente ancora non registrato o non loggato non possa entrare in questa pagina senza effettuare prima una registrazione
        oppure il login inserendo le proprie credenziali-->
        <%
            if (session != null){
                if(session.getAttribute("user")!=null){
                    //
                }else   
                    response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
            }
        %>
        
        <div id="h1">
            <center><h1 id="nickname"></h1></center>
        </div>
        
        <div id="table13">
            <form  action="logout.jsp" method="post">
                  <input type="submit" value="LOGOUT">
            </form>
        </div>
        
        <form action="MediaController" onsubmit="return save()" method="post">
            <div class="container" id="table2">
                <input type="text" name="nome" id="citta" placeholder="Città" required>
            </div>
            
            <div class="container" id="table3">
                <input type="text" name="inqui" id="inquinante" placeholder="Inquinante" required>
            </div>
            
            <div class="container" id="table3-1">
                <input type="date" name="inizio" id="dinizio" value="<jsp:getProperty name="user" property="inizio"/>" placeholder="Data inizio range" required>
                <input type="date" name="fine" id="dfine" value="<jsp:getProperty name="user" property="fine"/>" placeholder="Data fine range" required>
            </div>
            
            <div class="container" id="table3-2">
                <input type="submit" id="login-btn" value="Media">
            </div>
        </form>
        
        <!--link alla media su tutto il territorio dei diversi inquinanti-->
        <div class="container" id="table12">
            <button onclick="window.location.href='media_sul_territorio.jsp'">Media sul territorio</button>
        </div>
        
        <!----------------------------------------------------------------------
            questa sezione di codice serve per stampare una tabella con dentro
            tutti i dati presenti nella tabella mappa del db(latitudine, 
            longitudinee nome della citta.
        ----------------------------------------------------------------------->
        <div class="container" id="table14">
            <table>
                
                <thead>
                    <tr>
                        <th><b>NOME</b></th>
                        <th><b>INQUINANTE</b></th>
                    </tr>
                </thead>
                <tbody>
                    <!--Connessione al db della mappa-->
                    <%
                        try{
                            connection = DriverManager.getConnection(connectionUrl, userId, password);
                            statement=connection.createStatement();
                            String sql ="SELECT DISTINCT nome, inqui FROM map ORDER BY nome";
                            resultSet = statement.executeQuery(sql);
                            while(resultSet.next()){
                                %>
                                    <tr>
                                        <td><%=resultSet.getString("nome") %></td>
                                       
                                        <td><%=resultSet.getString("inqui") %></td>
                                        
                                    </tr>
                                <%		
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    %>
                </tbody>
            </table>
        </div>
        <!----------------------------------------------------------------------
            FINE
        ----------------------------------------------------------------------->
        
        <!--inizializzo la mappa-->
        <input id="pac-input" class="controls" type="text" placeholder="Search Box">
        <div class="container" id="map"></div>
        <script>
            var marker;
            //inzializza mappa 
            function initAutocomplete() {
                       
                var map = new google.maps.Map(document.getElementById('map'), {
                    center: {lat: 40.82323299999999, lng: 14.19018589999996},
                    zoom: 5,
                    mapTypeId: 'roadmap'
                });

                /*Carico i marker prendendo i dati di lat e long dal database*/
                <% int index=0;
                for(index = 0; index < posizione.size(); index+=2){%>
                    marker = new google.maps.Marker({
                        map: map,
                        clickable: true,
                     
                        animation: google.maps.Animation.DROP,
                        position: {lat: <%=posizione.get(index)%>, lng: <%=posizione.get(index+1)%>}
                    });                                                 
                <%}%>
                /**/
                
                // Crea la casella di ricerca.
                var input = document.getElementById('pac-input');
                var searchBox = new google.maps.places.SearchBox(input);
                map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);
                
                //  sposta la mappa nel punto della città che ho fatto la ricerca
                map.addListener('bounds_changed', function() {
                    searchBox.setBounds(map.getBounds());
                });
                
                var markers = [];
                // Listen for the event fired when the user selects a prediction and retrieve
                // more details for that place.
                searchBox.addListener('places_changed', function() {
                    var places = searchBox.getPlaces();
                    
                    if (places.length === 0) {
                        return;
                    }
                    
                    // Cancella i vecchi marker
                    markers.forEach(function(marker) {
                        marker.setMap(null);
                    });
                    markers = [];
                    
                    // Per ogni luogo, ottieni l'icona, il nome e la posizione.
                    var bounds = new google.maps.LatLngBounds();
                    places.forEach(function(place) {
                        if (!place.geometry) {
                            console.log("Returned place contains no geometry");
                            return;
                        }
                        
                        // Crea marker
                        markers.push(new google.maps.Marker({
                            map: map,
                            draggable: false,
                            animation: google.maps.Animation.DROP
                        }));
                        
                        if (place.geometry.viewport) {
                            // Only geocodes have viewport.
                            bounds.union(place.geometry.viewport);
                        } else {
                            bounds.extend(place.geometry.location);
                        }
                    });
                    map.fitBounds(bounds);
                });
            }
        </script>
        <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD5nPyNbMsxJgIMHp3QxUCfXm4P7sf0BR8&libraries=places&callback=initAutocomplete" async defer></script>
        
    </body>
</html>
