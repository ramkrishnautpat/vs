<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page import = "java.io.*,java.util.*, javax.servlet.*" %>
<%@ page import = "javax.servlet.http.*" %>
<%@ page import = "org.apache.commons.fileupload.*" %>
<%@ page import = "org.apache.commons.fileupload.disk.*" %>
<%@ page import = "org.apache.commons.fileupload.servlet.*" %>
<%@ page import = "org.apache.commons.io.output.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<title>View</title>
<!-- Babylon.js -->
		
        <script src="https://code.jquery.com/pep/0.4.2/pep.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/dat-gui/0.6.2/dat.gui.min.js"></script>
        <script src="https://preview.babylonjs.com/cannon.js"></script>
        <script src="https://preview.babylonjs.com/Oimo.js"></script>
        <script src="https://preview.babylonjs.com/gltf_validator.js"></script>
        <script src="https://preview.babylonjs.com/earcut.min.js"></script>
        <script src="https://preview.babylonjs.com/babylon.js"></script>
        <script src="https://preview.babylonjs.com/inspector/babylon.inspector.bundle.js"></script>
        <script src="https://preview.babylonjs.com/materialsLibrary/babylonjs.materials.min.js"></script>
        <script src="https://preview.babylonjs.com/proceduralTexturesLibrary/babylonjs.proceduralTextures.min.js"></script>
        <script src="https://preview.babylonjs.com/postProcessesLibrary/babylonjs.postProcess.min.js"></script>
        <script src="https://preview.babylonjs.com/loaders/babylonjs.loaders.js"></script>
        <script src="https://preview.babylonjs.com/serializers/babylonjs.serializers.min.js"></script>
        <script src="https://preview.babylonjs.com/gui/babylon.gui.min.js"></script>
		
		
		<!--Offline mode-->
		<!--
        <script src="pep.min.js"></script>
        <script src="dat.gui.min.js"></script>
        <script src="cannon.js"></script>
        <script src="Oimo.js"></script>
        <script src="gltf_validator.js"></script>
        <script src="earcut.min.js"></script>
        <script src="babylon.js"></script>
        <script src="babylon.inspector.bundle.js"></script>
        <script src="babylonjs.materials.min.js"></script>
        <script src="babylonjs.proceduralTextures.min.js"></script>
        <script src="babylonjs.postProcess.min.js"></script>
        <script src="babylonjs.loaders.js"></script>
        <script src="babylonjs.serializers.min.js"></script>
        <script src="babylon.gui.min.js"></script>
		-->
		<style>
            html, body {
                overflow: hidden;
                width: 100%;
                height: 100%;
                margin: 0;
                padding: 0;
            }

            #renderCanvas {
                width: 100%;
                height: 100%;
                touch-action: none;
            }
        </style>
</head>
<body>

   <!--<script src = "../js/View_home_user.js"></script> -->
   <!-- <b>Your Selected scene is :-</b>-->
   
   <!-- Get file name and path -->
   
   <canvas id="renderCanvas"></canvas>
   <script>
   var canvas = document.getElementById("renderCanvas");

        //var createScene = function () {
		function createScene() {	
                	
					<% String scene[]= request.getParameterValues("user_scene");
					//String project[]= request.getParameterValues("projectname");
					//Get scene name		
					if(scene != null)
					{
					
					
					for(int i=0; i<scene.length; i++)
					{
					
					var scene_names = "<%= scene[i] %>";
					
					}
					
					
					
					}
					
					
					//Upload file
					
					
   File file ;
   int maxFileSize = 5000 * 1024;
   int maxMemSize = 5000 * 1024;
   ServletContext context = pageContext.getServletContext();
   String filePath = context.getInitParameter("file-upload");
   //String project= request.getParameter("projectname");
   DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
    LocalDate localDate = LocalDate.now();
	String project = dtf.format(localDate);
    
	if(project != null)
	{
	String scene_location = filePath + project;
	File f = new File(scene_location);
	if(!f.exists())
	{
	f.mkdirs();
	}
	}	
	filePath = filePath + project + "\\";					
   // Verify the content type
   String contentType = request.getContentType();
     
      
  if ((contentType.indexOf("multipart/form-data") >= 0)) {
	   
      DiskFileItemFactory factory = new DiskFileItemFactory();
      // maximum size that will be stored in memory
      factory.setSizeThreshold(maxMemSize);
      
      // Location to save data that is larger than maxMemSize.
      factory.setRepository(new File("c:\\temp"));

      // Create a new file upload handler
      ServletFileUpload upload = new ServletFileUpload(factory);
	  
      // maximum file size to be uploaded.
      upload.setSizeMax( maxFileSize );
      
      try { 
         // Parse the request to get file items.
         List fileItems = upload.parseRequest(request);
		 	 
		 
         
		 // Process the uploaded file items
         Iterator<FileItem> i = fileItems.iterator();
		 
         while (i.hasNext() ) {
            FileItem fi = (FileItem)i.next();
			
            if (!fi.isFormField()) {
               // Get the uploaded file parameters
               String fieldName = fi.getFieldName();
               String fileName = fi.getName();
               boolean isInMemory = fi.isInMemory();
               long sizeInBytes = fi.getSize();
			    			
			  
               // Write the file
               if( fileName.lastIndexOf("\\") >= 0 ) {
                  file = new File( filePath  + 
                  fileName.substring( fileName.lastIndexOf("\\"))) ;
               } else {
                  file = new File( filePath  + 
                  fileName.substring(fileName.lastIndexOf("\\")+1)) ;
               }
			   
               fi.write( file ) ;
			   //out.println("Uploaded Filename: " + filePath +  fileName + "<br>"); 
			    		
            }
			
			
         }
		 
         
      } catch(Exception ex) {
         System.out.println(ex);
      }
   } else {
      
      out.println("<p>No file uploaded</p>"); 
      
   }
%>
		var project_names = "<%= project %>";								
					var scene_location = "http://localhost:8080/vs/html/scene/" + project_names + "/" ;
					alert(scene_names);	
					alert(scene_location);					
				//var scene = new BABYLON.Scene(engine);
                	//var cam = new BABYLON.ArcRotateCamera("ArcRotateCamera", 0, 0, 5, new BABYLON.Vector3(0,3,0), scene);
                
                	
               //BABYLON.SceneLoader.Load("https://cdn.rawgit.com/ramkrishnautpat/models/master/", "fileName.glb", engine, function (newScene) { 
               //BABYLON.SceneLoader.Load("../html/scene/mini-house/", "fileName.glb", engine, function (newScene) {
				//BABYLON.SceneLoader.Load("http://localhost:8080/vs/html/scene/mini-house/", scene_names, engine, function (newScene) {	 
				BABYLON.SceneLoader.Load(scene_location, scene_names, engine, function (newScene) {	 
                		newScene.clearColor = new BABYLON.Color3.White();
                		
                		// Create a default arc rotate camera and light.
                		
                		newScene.createDefaultCameraOrLight(true, true, true);
                		
                		// The default camera looks at the back of the asset.
                        // Rotate the camera by 180 degrees to the front of the asset.
                		
                        newScene.activeCamera.alpha += Math.PI;
                        newScene.activeCamera.alpha += 1.5;
                        newScene.activeCamera.radius += -14;
                       
                		engine.runRenderLoop(function () {
                            newScene.render();
                        });
                    });
                  return scene;
                };
        
        var engine = new BABYLON.Engine(canvas, true, { preserveDrawingBuffer: true, stencil: true });
        var scene = createScene();

        engine.runRenderLoop(function () {
            if (scene) {
                scene.render();
            }
        });

        // Resize
        window.addEventListener("resize", function () {
            engine.resize();
        });
   </script>
 
				

</body>
</html>