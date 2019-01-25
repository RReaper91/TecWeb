package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Connection;
import java.util.ArrayList;
import beans.Add;

public final class mappa_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html;charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("<!------------------------------------------------------------------------------\n");
      out.write("    Questa sezione serve per importare le librerie utili per il collegamento al\n");
      out.write("    db e per crearne quindi la connessione\n");
      out.write("------------------------------------------------------------------------------->\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<!--Creo una connessione al database con userid root e password nulla-->\n");

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

      out.write("\n");
      out.write("\n");
      out.write("<!--Passo la connessione al db ed eseguo una query per prendermi solamente il nome della citta , la latitudine e la longitudine-->\n");
      out.write("<script type=\"text/javascript\">\n");
      out.write("    ");

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
    
      out.write("\n");
      out.write("</script>\n");
      out.write("\n");
      out.write("<!------------------------------------------------------------------------------\n");
      out.write("    FINE\n");
      out.write("------------------------------------------------------------------------------->\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html>\n");
      out.write("    <head>\n");
      out.write("        <meta name=\"viewport\" content=\"initial-scale=1.0, user-scalable=no\">\n");
      out.write("        <meta http-equiv=\"X-UA-Compatible\" content=\"ie=edge\">\n");
      out.write("        <link rel=\"stylesheet\" href=\"mappa_css.css\" type=\"text/css\" />\n");
      out.write("        <meta http-equiv=Refresh content=\"3600; URL=mappa.jsp\">\n");
      out.write("        <link rel=\"stylesheet\" href=\"css.css\" type=\"text/css\" />\n");
      out.write("        <meta charset=\"utf-8\">\n");
      out.write("        <title>Area Utente</title>\n");
      out.write("        <!--Script che prende il nome dell'user salvato in sessiostorage e lo usa per metterlo nel titolo-->\n");
      out.write("        <script type=\"text/javascript\">\n");
      out.write("            var nick = localStorage.getItem('nick');\n");
      out.write("            window.onload = function(){\n");
      out.write("                document.getElementById('nickname').innerHTML = \"Benvenuto \" + nick;\n");
      out.write("            };\n");
      out.write("        </script>\n");
      out.write("        <script type=\"text/javascript\">\n");
      out.write("            function save(){\n");
      out.write("                localStorage.setItem('nome', document.getElementById('citta').value);\n");
      out.write("                localStorage.setItem('inqui', document.getElementById('inquinante').value);\n");
      out.write("                localStorage.setItem('inizio', document.getElementById('dinizio').value);\n");
      out.write("                localStorage.setItem('fine', document.getElementById('dfine').value);\n");
      out.write("                    \n");
      out.write("                var inizio = document.getElementById('dinizio').value;\n");
      out.write("                var fine = document.getElementById('dfine').value;\n");
      out.write("                if (inizio > fine){\n");
      out.write("                    alert(\"ATTENZIONE!!\\nLa data di inizio deve essere più piccola della data di fine\");\n");
      out.write("                    return false;\n");
      out.write("                } else{\n");
      out.write("                    return true;\n");
      out.write("                }\n");
      out.write("            }\n");
      out.write("        </script>\n");
      out.write("       \n");
      out.write("    </head>\n");
      out.write("    <body>\n");
      out.write("        <div id=\"foto\"></div>\n");
      out.write("        ");
      beans.Add user = null;
      synchronized (request) {
        user = (beans.Add) _jspx_page_context.getAttribute("user", PageContext.REQUEST_SCOPE);
        if (user == null){
          user = new beans.Add();
          _jspx_page_context.setAttribute("user", user, PageContext.REQUEST_SCOPE);
        }
      }
      out.write("\n");
      out.write("        <!--Controllo che l'utente ancora non registrato o non loggato non possa entrare in questa pagina senza effettuare prima una registrazione\n");
      out.write("        oppure il login inserendo le proprie credenziali-->\n");
      out.write("        ");

            if (session != null){
                if(session.getAttribute("user")!=null){
                    //
                }else   
                    response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
            }
        
      out.write("\n");
      out.write("        \n");
      out.write("        <div id=\"h1\">\n");
      out.write("            <center><h1 id=\"nickname\"></h1></center>\n");
      out.write("        </div>\n");
      out.write("        \n");
      out.write("        <div id=\"table13\">\n");
      out.write("            <form  action=\"logout.jsp\" method=\"post\">\n");
      out.write("                  <input type=\"submit\" value=\"LOGOUT\">\n");
      out.write("            </form>\n");
      out.write("        </div>\n");
      out.write("        \n");
      out.write("        <form action=\"MediaController\" onsubmit=\"return save()\" method=\"post\">\n");
      out.write("            <div class=\"container\" id=\"table2\">\n");
      out.write("                <input type=\"text\" name=\"nome\" id=\"citta\" placeholder=\"Città\" required>\n");
      out.write("            </div>\n");
      out.write("            \n");
      out.write("            <div class=\"container\" id=\"table3\">\n");
      out.write("                <input type=\"text\" name=\"inqui\" id=\"inquinante\" placeholder=\"Inquinante\" required>\n");
      out.write("            </div>\n");
      out.write("            \n");
      out.write("            <div class=\"container\" id=\"table3-1\">\n");
      out.write("                <input type=\"date\" name=\"inizio\" id=\"dinizio\" value=\"");
      out.write(org.apache.jasper.runtime.JspRuntimeLibrary.toString((((beans.Add)_jspx_page_context.findAttribute("user")).getInizio())));
      out.write("\" placeholder=\"Data inizio range\" required>\n");
      out.write("                <input type=\"date\" name=\"fine\" id=\"dfine\" value=\"");
      out.write(org.apache.jasper.runtime.JspRuntimeLibrary.toString((((beans.Add)_jspx_page_context.findAttribute("user")).getFine())));
      out.write("\" placeholder=\"Data fine range\" required>\n");
      out.write("            </div>\n");
      out.write("            \n");
      out.write("            <div class=\"container\" id=\"table3-2\">\n");
      out.write("                <input type=\"submit\" id=\"login-btn\" value=\"Media\">\n");
      out.write("            </div>\n");
      out.write("        </form>\n");
      out.write("        \n");
      out.write("        <!--link alla media su tutto il territorio dei diversi inquinanti-->\n");
      out.write("        <div class=\"container\" id=\"table12\">\n");
      out.write("            <button onclick=\"window.location.href='media_sul_territorio.jsp'\">Media sul territorio</button>\n");
      out.write("        </div>\n");
      out.write("        \n");
      out.write("        <!--inizializzo la mappa-->\n");
      out.write("        <input id=\"pac-input\" class=\"controls\" type=\"text\" placeholder=\"Search Box\">\n");
      out.write("        <div class=\"container\" id=\"map\"></div>\n");
      out.write("        <script>\n");
      out.write("            var marker;\n");
      out.write("            //inzializza mappa ad un punto preciso(fuorigrotta)\n");
      out.write("            function initAutocomplete() {\n");
      out.write("                       \n");
      out.write("                var map = new google.maps.Map(document.getElementById('map'), {\n");
      out.write("                    center: {lat: 40.82323299999999, lng: 14.19018589999996},\n");
      out.write("                    zoom: 5,\n");
      out.write("                    mapTypeId: 'roadmap'\n");
      out.write("                });\n");
      out.write("\n");
      out.write("                /*Carico i marker prendendo i dati di lat e long dal database*/\n");
      out.write("                ");
 int index=0;
                for(index = 0; index < posizione.size(); index+=2){
      out.write("\n");
      out.write("                    marker = new google.maps.Marker({\n");
      out.write("                        map: map,\n");
      out.write("                        clickable: true,\n");
      out.write("                     \n");
      out.write("                        animation: google.maps.Animation.DROP,\n");
      out.write("                        position: {lat: ");
      out.print(posizione.get(index));
      out.write(", lng: ");
      out.print(posizione.get(index+1));
      out.write("}\n");
      out.write("                    });                                                 \n");
      out.write("                ");
}
      out.write("\n");
      out.write("                /**/\n");
      out.write("                \n");
      out.write("                // Crea la casella di ricerca.\n");
      out.write("                var input = document.getElementById('pac-input');\n");
      out.write("                var searchBox = new google.maps.places.SearchBox(input);\n");
      out.write("                map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);\n");
      out.write("                \n");
      out.write("                // Bias the SearchBox results towards current map's viewport.\n");
      out.write("                map.addListener('bounds_changed', function() {\n");
      out.write("                    searchBox.setBounds(map.getBounds());\n");
      out.write("                });\n");
      out.write("                \n");
      out.write("                var markers = [];\n");
      out.write("                // Listen for the event fired when the user selects a prediction and retrieve\n");
      out.write("                // more details for that place.\n");
      out.write("                searchBox.addListener('places_changed', function() {\n");
      out.write("                    var places = searchBox.getPlaces();\n");
      out.write("                    \n");
      out.write("                    if (places.length === 0) {\n");
      out.write("                        return;\n");
      out.write("                    }\n");
      out.write("                    \n");
      out.write("                    // Clear out the old markers.\n");
      out.write("                    markers.forEach(function(marker) {\n");
      out.write("                        marker.setMap(null);\n");
      out.write("                    });\n");
      out.write("                    markers = [];\n");
      out.write("                    \n");
      out.write("                    // For each place, get the icon, name and location.\n");
      out.write("                    var bounds = new google.maps.LatLngBounds();\n");
      out.write("                    places.forEach(function(place) {\n");
      out.write("                        if (!place.geometry) {\n");
      out.write("                            console.log(\"Returned place contains no geometry\");\n");
      out.write("                            return;\n");
      out.write("                        }\n");
      out.write("                        \n");
      out.write("                        // Create a marker for each place.\n");
      out.write("                        markers.push(new google.maps.Marker({\n");
      out.write("                            map: map,\n");
      out.write("                            draggable: false,\n");
      out.write("                            animation: google.maps.Animation.DROP\n");
      out.write("                        }));\n");
      out.write("                        \n");
      out.write("                        if (place.geometry.viewport) {\n");
      out.write("                            // Only geocodes have viewport.\n");
      out.write("                            bounds.union(place.geometry.viewport);\n");
      out.write("                        } else {\n");
      out.write("                            bounds.extend(place.geometry.location);\n");
      out.write("                        }\n");
      out.write("                    });\n");
      out.write("                    map.fitBounds(bounds);\n");
      out.write("                });\n");
      out.write("            }\n");
      out.write("        </script>\n");
      out.write("        <script src=\"https://maps.googleapis.com/maps/api/js?key=AIzaSyD5nPyNbMsxJgIMHp3QxUCfXm4P7sf0BR8&libraries=places&callback=initAutocomplete\" async defer></script>\n");
      out.write("        \n");
      out.write("    </body>\n");
      out.write("</html>\n");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
