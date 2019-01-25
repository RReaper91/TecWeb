<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>

<%
    String utente;
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
<link rel="stylesheet" href="css.css" type="text/css" />
<div id="foto"></div>
<form action="#"  onsubmit="save()">
    <input type="text" id="citta" placeholder="Città">
    
    <input type="text" id="inquinante" placeholder="Inquinante">
    
    <input type="date" id="dinizio" placeholder="Data inizio range">
    
    <input type="date" id="dfine" placeholder="Data fine range">
    
    <input type="submit" value="Media">
    
    <script type="text/javascript">
        /**
         * salvataggio nel web storage dei dati immessi nella form
         */
        function save(){
            localStorage.setItem('nome', document.getElementById('citta').value);
            localStorage.setItem('inqui', document.getElementById('inquinante').value);
            localStorage.setItem('inizio', document.getElementById('dinizio').value);
            localStorage.setItem('fine', document.getElementById('dfine').value);
        }
    </script>
</form>
 


<table align="center" cellpadding="5" cellspacing="5" border="1">
    <tr></tr>
    <tr bgcolor="#A52A2A">
        <td><b>CITTA'</b></td>
        <td><b>INQUINANTE</b></td>
        <td><b>MEDIA</b></td>
    </tr>
    <%
        try{
            connection = DriverManager.getConnection(connectionUrl, userId, password);
            statement=connection.createStatement();
            String sql = "<script>query.value; </script>";
            
            resultSet = statement.executeQuery(sql);
            while(resultSet.next()){
    %>
    <div id="foto"></div>
    <tr bgcolor="#DEB887">
        
        <td><%=resultSet.getString("nome") %></td>
        <td><%=resultSet.getString("inqui") %></td>
        <td><%=resultSet.getString("media") %></td>
        
    </tr>
    <%
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    %>
</table>
