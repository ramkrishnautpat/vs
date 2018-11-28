var canvas = document.getElementById("renderCanvas");

        //var createScene = function () {
		function createScene() {	
                	
                	//var scene = new BABYLON.Scene(engine);
                	//var cam = new BABYLON.ArcRotateCamera("ArcRotateCamera", 0, 0, 5, new BABYLON.Vector3(0,3,0), scene);
                
                	
               //BABYLON.SceneLoader.Load("https://cdn.rawgit.com/ramkrishnautpat/models/master/", "fileName.glb", engine, function (newScene) { 
                 BABYLON.SceneLoader.Load("./scene/mini-house/", "fileName.glb", engine, function (newScene) {
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