<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Edit</title>
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
   <button id="button" style="position: absolute; right: 10px; top: 100px; background:none" onclick="doDownload(filename, scene)">Save</button>
   <script>
   var canvas = document.getElementById("renderCanvas");

        //var createScene = function () {
		function delayCreateScene() {	
                	
					<% String scene[]= request.getParameterValues("user_scene");
					if(scene != null)
					{
					%>
					
					
					<%
					for(int i=0; i<scene.length; i++)
					{
					%>
					
					var scene_names = "<%= scene[i] %>";
					<%
					}
					%>
					
					<%
					}
					%>
					
				// Create a scene.
                var scene = new BABYLON.Scene(engine);
				scene.createDefaultCameraOrLight(true, true, true);
            
                //BABYLON.SceneLoader.Append("https://cdn.rawgit.com/ramkrishnautpat/models/master/", "fileName.glb", scene, 
				BABYLON.SceneLoader.Append("http://localhost:8080/vs/html/scene/mini-house/", scene_names, scene,
				function (scene) {
					scene.clearColor = new BABYLON.Color3.White();
                    scene.createDefaultCameraOrLight(true, true, true);
                    scene.activeCamera.alpha += Math.PI;
                    scene.activeCamera.alpha += 1.5;
                    scene.activeCamera.radius += -14;
        
                        var ground  = scene.getMeshByName("Plane");
                        scene.activeCamera.attachControl(canvas);
                        
                        // Events
                        var canvas = engine.getRenderingCanvas();
                        var startingPoint;
                        var currentMesh;
                    
                        var getGroundPosition = function () {
                            // Use a predicate to get position on the ground
                            var pickinfo = scene.pick(scene.pointerX, scene.pointerY, function (mesh) { return mesh == ground; });
                            if (pickinfo.hit) {
                                return pickinfo.pickedPoint;
                            }
        
                            return null;
                        }
                    
                        var onPointerDown = function (evt) {
                            if (evt.button !== 0) {
                                return;
                            }
                    
                            // check if we are under a mesh
                            var pickInfo = scene.pick(scene.pointerX, scene.pointerY);
                            if (pickInfo.hit) {
                                currentMesh = pickInfo.pickedMesh;
                                startingPoint = getGroundPosition(evt);
        
                                if (startingPoint) { // we need to disconnect camera from canvas
                                    setTimeout(function () {
                                        scene.activeCamera.detachControl(canvas);
                                    }, 0);
                                }
                            }
                        }
                    
                        var onPointerUp = function () {
                            if (startingPoint) {
                                scene.activeCamera.attachControl(canvas, true);
                                startingPoint = null;
                                return;
                            }
                        }
                    
                        var onPointerMove = function (evt) {
                            if (!startingPoint) {
                                return;
                            }
                    
                            var current = getGroundPosition(evt);
                    
                            if (!current) {
                                return;
                            }
                    
                            var diff = current.subtract(startingPoint);
                            currentMesh.position.addInPlace(diff);
                    
                            startingPoint = current;
                    
                        }
        
                        //Duplicate meshes
        
                         window.addEventListener("dblclick", function (e) {	    
        		             var pickInfo = scene.pick(scene.pointerX, scene.pointerY);
                             currentMesh = pickInfo.pickedMesh;
                             var NewMesh = currentMesh.clone();
                                                          
        	            });
        
                        //Delete meshes
                        
                        window.addEventListener("cut", function (e) {	    
        		             var pickInfo = scene.pick(scene.pointerX, scene.pointerY);
                             currentMesh = pickInfo.pickedMesh;
                             currentMesh.dispose();
                             
        	            });
                    
                        canvas.addEventListener("pointerdown", onPointerDown, false);
                        canvas.addEventListener("pointerup", onPointerUp, false);
                        canvas.addEventListener("pointermove", onPointerMove, false);
            
                            scene.onDispose = function () {
                            canvas.removeEventListener("pointerdown", onPointerDown);
                            canvas.removeEventListener("pointerup", onPointerUp);
                            canvas.removeEventListener("pointermove", onPointerMove);
                        }
                });
            
                return scene;
                };
				
		//Download Scene
			var objectUrl;
			var engine = new BABYLON.Engine(canvas, true, { preserveDrawingBuffer: true, stencil: true });
			var scene = delayCreateScene();
			var filename="Newscene";
			
			function doDownload(filename, scene) {
			BABYLON.GLTF2Export.GLBAsync(scene, "Newscene").then(function(glb) {
			glb.downloadFiles();
			});

			/*BABYLON.GLTF2Export.GLTFAsync(scene, "fileName").then((gltf) => {
			gltf.downloadFiles();
			});*/
			}		
        
        //var engine = new BABYLON.Engine(canvas, true, { preserveDrawingBuffer: true, stencil: true });
        //var scene = createScene();

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