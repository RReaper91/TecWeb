<!------------------------------------------------------------------------------
    Questa sezione serve per importare le librerie utili per il collegamento al
    db e per crearne quindi la connessione
------------------------------------------------------------------------------->
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.ArrayList"%>

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
<!------------------------------------------------------------------------------
    FINE
------------------------------------------------------------------------------->

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="initial-scale=1.0, user-scalable=no">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <link rel="stylesheet" href="mappa_css.css" type="text/css" />
        <link rel="stylesheet" href="css.css" type="text/css" />
        <meta charset="utf-8">
        <title>Area Utente</title>
    </head>
    <body>
        <div id="foto"></div>

        <div class="container" id="table6">
            In questa mappa è possibile visualizzare le sonde,
            registrati ed avrai la possibilità di calcolare la media degli inquinanti presenti sul territorio.
        </div>
        
        <div id="h1">
            <center> <h1>Benvenuto</h1></center>
        </div>
        
        <div id="table13">
            <form  action="logout.jsp" method="post">
                  <input type="submit" value="LOGOUT">
            </form>
        </div>
        
        <input id="pac-input" class="controls" type="text" placeholder="Search Box">
        
        <div class="container" id="map"></div>
        
        <!--
        -- creazione della mappa, con i marker 
        -->
        <script>
            var marker;
            //inzializza mappa 
            function initAutocomplete() {
                var map = new google.maps.Map(document.getElementById('map'), {
                    center: {lat: 40.82323299999999, lng: 14.19018589999996},
                    zoom: 5,
                    mapTypeId: 'roadmap'
                });
                
                /*Carico i marker dal database leggendo dal db long e lat */
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
                
                // Crea la casella di ricerca.
                var input = document.getElementById('pac-input');
                var searchBox = new google.maps.places.SearchBox(input);
                map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);
                
                // sposta la mappa nel punto della città che ho fatto la ricerca
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
                    
                    // cancella i vecchi marker
                    markers.forEach(function(marker) {
                        marker.setMap(null);
                    });
                    markers = [];
                    
                    // Per ogni luogo, ottieni l'icona, il nome e la posizione.
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
