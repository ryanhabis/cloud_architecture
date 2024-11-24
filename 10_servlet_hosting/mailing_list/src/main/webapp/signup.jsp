<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body style="background-color: palegreen;">
        <h1>Thank you!</h1>
        <%
            String email = request.getParameter("email");
            /*
            Database logic goes here
            */
            %>
            <p>E-mail address <%= email %> has been signed up.</p>
        <p><a href=".">Back to main page</a></p>
    </body>
</html>
