<html>
   <head>
      <title>Scene Uploading Form</title>
   </head>
   
   <body>
   <form action="Edit.jsp" method="post" >
      <h3>Scene Upload:</h3>
      Select a scene file to upload: <br /><br />
      
		 <input type = "file" name = "user_scene" value = "scene_name"size = "1000" multiple=""/>
         <br /><br />
         <input type = "submit" value = "Edit"  value="Edit" onClick="delayCreateScene()" />
      </form>
   </body>
   
</html>