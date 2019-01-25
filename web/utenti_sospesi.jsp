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
     * se non si è autenticati non è possibile accedere alla pagina
     */
    if (session != null){
        if(session.getAttribute("user")!=null){
            //
        }else
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
    }
%>

<link rel="stylesheet" href="tabella_css.css" type="text/css" />
 <link rel="stylesheet" href="css.css" type="text/css" />
 <div id="foto"></div>
<div align="center">
<table align="center">
    <tr></tr>
    <tr >
        <th><b>NOME</b></th>
	<th><b>COGNOME</b></th>
        <th><b>USERNAME</b></th>
    </tr>
    <%
        try{
            /**
             * connessione al ed esecuzione di una query per prelevare dal db
             * tutti gli utenti presenti nella tabella 'sospeso'
             */
            connection = DriverManager.getConnection(connectionUrl, userId, password);
            statement=connection.createStatement();
            String sql ="SELECT first_name, last_name, username FROM sospeso";
            
            resultSet = statement.executeQuery(sql);
            while(resultSet.next()){
    %>
                <tr>
                    
                    <td><%=resultSet.getString("first_name") %></td>
                    <td><%=resultSet.getString("last_name") %></td>
                    <td>
                        <form action="AcceptController">
                            <%
                                utente=resultSet.getString("username");
                                session.setAttribute("username", utente);
                            %>
                                <input style="width: 75px;" type="text" name="username" value="<%=resultSet.getString("username") %>" readonly="text">
                                <input type="submit" value="Accetta">
                        </form>
                    </td>
                </tr>
	<%
            }
        } catch (Exception e) {
            e.printStackTrace();
	}
    %>
    
</table>
    <button onclick="window.location.href='admin.jsp'">Admin</button>
</div>