<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

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
            String sql ="SELECT latd, longit FROM map";
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

<link rel="stylesheet" href="tabella_css.css" type="text/css" />
<link rel="stylesheet" href="css.css" type="text/css" />

<div id="foto"></div>
<div align="center">
    <table>
        <tr>
        </tr>
        <thead>
            <tr>
                <th><b>INQUINANTE</b></th>
                <th><b>MEDIA</b></th>
            </tr>
        </thead>
        <tbody>
            <%
                try{
                    connection = DriverManager.getConnection(connectionUrl, userId, password);
                    statement=connection.createStatement();
                    String sql ="SELECT inqui, AVG(valore) AS media FROM map GROUP BY inqui";
                    resultSet = statement.executeQuery(sql);
                    while(resultSet.next()){
                        String color = "";
                        String inqui = resultSet.getString("inqui");
                        Float media = resultSet.getFloat("media");
                        if (media > 50) 
                            color = "red";
                    %>
                        <tr>
                            <td><%=inqui %></td>
                            <td style="background-color: <%=color %>"><%=media %></td>
                        </tr>
                        <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            %>
        </tbody>
    </table>
    <br>
    <button onclick="window.location.href='mappa.jsp'">Mappa</button>
</div>