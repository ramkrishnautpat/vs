<html>
   <head>
      <title>Scene Uploading Form</title>
   </head>
   
   <body>
  
  <form action="result.jsp" method="post" enctype="multipart/form-data">
      <h3>Scene Upload:</h3>
      Select a scene file to upload: <br /><br />
      
         Project Name: 	<input type="text" name="projectname" id="projectname" ><br><br>
		 Select files:    <input type = "file" name = "user_scene" value = "scene_name"size = "1000" multiple=""/>
         <br /><br />
         <input type = "submit" value = "View"  value="View"  />
		 <!--<input type = "submit" value = "View" />-->
      </form>
   </body>
   
</html>