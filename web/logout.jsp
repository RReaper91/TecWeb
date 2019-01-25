<html>
    <head>
        <link rel="stylesheet" href="css.css" type="text/css" />
        <meta http-equiv=Refresh content="2; URL=index.html">
        <title>Logout Page</title>
    </head>
    <body>
        <div id="foto">
            <div id="login">
                <% session.invalidate(); %>
                <script>
                    localStorage.clear();
                </script>
             
                <center><h1>Arrivederci!</h1></center>
                <br>
            </div>
        </div>
    </body>
</html>
