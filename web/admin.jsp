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
        try{
            connection = DriverManager.getConnection(connectionUrl, userId, password);
            statement=connection.createStatement();
            String sql ="SELECT DISTINCT nome, latd, longit FROM map";
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

<%@page import="beans.Add"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="initial-scale=1.0, user-scalable=no">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <link rel="stylesheet" href="mappa_css.css" type="text/css" />
        <meta http-equiv=Refresh content="7200; URL=admin.jsp">
        <link rel="stylesheet" href="tabella_css.css" type="text/css" />
        <link rel="stylesheet" href="css.css" type="text/css" />
        <meta charset="utf-8">
        <title>Area Admin</title>
    </head>
    <body>
        <div id="foto"></div>
        <!--Controllo che l'utente ancora non registrato o non loggato non possa 
        entrare in questa pagina senza effettuare prima una registrazione
        oppure il login inserendo le proprie credenziali-->
        <%
            if (session != null){
                if(session.getAttribute("user")!=null){
                    //
                }else
                    response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
            }
        %>
        <jsp:useBean id="user" scope="request" class="beans.Add"></jsp:useBean>
        
        <div id="h1">
            <center> <h1>Area Admin</h1></center>
        </div>
        
        <!--  pagina degli utenti registrati ma ancora di conferma della registrazione-->
        <div id="sospesi">
            <form   method="post">
                <input type="submit" formaction="utenti_sospesi.jsp" id="login-btn" value="Utenti in sospeso">
            </form>
        </div>
        <!--eseguire il logout dalla pagina user-->
       <div id="logout">
            <form  method="post">
                <input type="submit" formaction="logout.jsp" id="login-btn" value="LOGOUT">
            </form>
       </div>
        
        <div class="container" id="titolo"> Aggiungi/Elimina Sonda</div>
        
        <!--Inserimento di una nuova sonda, sceglieno la citta in cui si vuole insierire , e la latitudine e la longitudine della sonda-->
        <form method="post">
            <div class="container" id="table1">
                <input type="text" name="nome" value="<jsp:getProperty name="user" property="nome"/>" placeholder="Citta'">
            </div>
            
            <div class="container" id="table2">
                <input type="double" name="latd" value="<jsp:getProperty name="user" property="latd"/>" placeholder="Latitudine">
            </div>
            
            <div class="container" id="table3">
                <input type="double" name="longit" value="<jsp:getProperty name="user" property="longit"/>" placeholder="Longitudine">
            </div>
            
            <!--Inserimento di un nuovo inquinante, in questo caso bisogna inserire il nome della citta dove e stata inserita la sonda, e il nome dell'inquinante-->
            <div class="container" id="table3-1">
                <input type="text" name="inqui" value="<jsp:getProperty name="user" property="inqui"/>" placeholder="Inquinante">
            </div>

            <!--Premendo inserisci inseriamo un nuovo marker nella mappa, con un valore random per quanto riguarda l'uquinante-->
            <div class="container" id="table4">
                <input type="submit" formaction="AddMarker" id="login-btn"  value="Inserisci">
            </div>
            
             <!--Premendo elimina eliminiamo una sonda con i relativi valori dalla tabella-->
            <div class="container" id="table5">
                <input type="submit" formaction="DeleteMarker" id="login-btn"  value="Elimina">
            </div>
     
        </form>
                <!--link alla media su tutto il territorio dei diversi inquinanti-->
        <div class="container" id="table12">
            <button onclick="window.location.href='media_inqui_ad.jsp'">Media inquinanti</button>
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
                        <th><b>LATITUDINE</b></th>
                        <th><b>LONGITUDINE</b></th>
                        <th><b>INQUINANTE</b></th>
                    </tr>
                </thead>
                <tbody>
                    <!--Connessione al db della mappa-->
                    <%
                        try{
                            connection = DriverManager.getConnection(connectionUrl, userId, password);
                            statement=connection.createStatement();
                            String sql ="SELECT DISTINCT nome, latd, longit, inqui FROM map ORDER BY nome";
                            resultSet = statement.executeQuery(sql);
                            while(resultSet.next()){
                                %>
                                    <tr>
                                        <td><%=resultSet.getString("nome") %></td>
                                        <td><%=resultSet.getFloat("latd") %></td>
                                        <td><%=resultSet.getFloat("longit") %></td>
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
        
            <!--Inizializzo la mappa -->
        <input id="pac-input" class="controls" type="text" placeholder="Search Box">
        <div class="container" id="map"></div>
        <script>
            var marker;
            //inzializza mappa a delle coordinate precise(fuorigrotta)
            function initAutocomplete() {
                var map = new google.maps.Map(document.getElementById('map'), {
                    center: {lat: 40.82323299999999, lng: 14.19018589999996},
                    zoom: 5,
                    mapTypeId: 'roadmap'
                });
                
                /*Inizializzo i marker prendendoli una alla volta dal database*/
                <%int index=0;
                for(index = 0; index < posizione.size(); index+=2){%>
                    marker = new google.maps.Marker({
                        map: map,
                        draggable: false,
                        animation: google.maps.Animation.DROP,
                        position: {lat: <%=posizione.get(index)%>, lng: <%=posizione.get(index+1)%>}
                    });
                <%}%>
                /**/
                
                //marker della pagina iniziale (fuorigrotta)
                marker = new google.maps.Marker({
                    map: map,
                    draggable: false,
                    animation: google.maps.Animation.DROP,
                    position: {lat: 40.82323299999999, lng: 14.19018589999996}
                });
                
                // Create the search box and link it to the UI element.
                var input = document.getElementById('pac-input');
                var searchBox = new google.maps.places.SearchBox(input);
                map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);
                
                // Bias the SearchBox results towards current map's viewport.
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
                    
                    // Clear out the old markers.
                    markers.forEach(function(marker) {
                        marker.setMap(null);
                    });
                    markers = [];
                    
                    // For each place, get the icon, name and location.
                    var bounds = new google.maps.LatLngBounds();
                    places.forEach(function(place) {
                        if (!place.geometry) {
                            console.log("Returned place contains no geometry");
                            return;
                        }
                        
                        // Create a marker for each place.
                        markers.push(new google.maps.Marker({
                            map: map,
                            draggable: true,
                            animation: google.maps.Animation.DROP,
                            position: place.geometry.location
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