<%@ page contentType="text/html" %>
<%@ page import="java.sql.*" %>
<%@ page import="org.sqlite.*" %>
 
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Your Scenes</title>
    </head>
    <body>
		<div align="center">
		<!--<form action="../html/View_home_user.jsp" method="post"> -->
		<form action="result.jsp" method="post"> 
        <table border="1" cellpadding="5">
            <thead>
                <tr>
                    <th>Scene Name</th>
					<th>View</th>
                </tr>
            </thead>
            <tbody>
            <%
                Class.forName("org.sqlite.JDBC");
                Connection conn =
                     DriverManager.getConnection("jdbc:sqlite:C:\\Program Files\\Apache Software Foundation\\Tomcat 8.5\\webapps\\vs\\db\\vs.db3");
                Statement stat = conn.createStatement();
 
                ResultSet rs = stat.executeQuery("select * from scenes where user = 'admin';");
				
				while (rs.next()) {
					String scene_name = rs.getString("NAME");
                    out.println("<tr>");
                    out.println("<td>" + rs.getString("NAME") + "</td>");
					out.println("<td>");   
					out.println("<input type='checkbox' name='user_scene' value='"+scene_name+"' />");
					out.println("</td>");
                    out.println("</tr>");
					
                }
					
					out.println("<tr>");
					out.println("<td colspan='2'>");
					out.println("<center>");
					out.println("<input type='submit' value='View' onClick='createScene('scene_name')' />");
					//out.println("<a href='../html/View_home_user.html' class='button--style-red'>View</a>");
					out.println("</center>");
					out.println("</td>");
					out.println("</tr>");
					
                rs.close();
                conn.close();
            %>
            </tbody>
        </table>
		</div>
		<!--</form>-->
		
    </body>
</html>