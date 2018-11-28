var canvas = document.getElementById("renderCanvas");
		
		var delayCreateScene = function () {
                // Create a scene.
                var scene = new BABYLON.Scene(engine);
				scene.createDefaultCameraOrLight(true, true, true);
            
                //BABYLON.SceneLoader.Append("https://cdn.rawgit.com/ramkrishnautpat/models/master/mini-house-babylon/", "mini-house.babylon", scene, 
				BABYLON.SceneLoader.Append("./scene/mini-house/", "Newscene.glb", scene,
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
						
						//Load objects
		
						/*class BotLoader {
								constructor(folder, file) {
									this.meshes = []
									console.log(`loading" ${folder}${file}...`);
									BABYLON.SceneLoader.ImportMesh("", folder, file, scene, meshes => {
										meshes.forEach(mesh => {
											//console.log(`mesh: ${mesh.name}`, mesh)
											this.meshes.push(mesh);
										})
									});
								}
							}
						
						 let loader = new BotLoader("./objects/Tabel/", "table.obj");*/
                    
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
			});﻿
			
			/*BABYLON.GLTF2Export.GLTFAsync(scene, "fileName").then((gltf) => {
			gltf.downloadFiles();
			});*/
			}
			
		/*function doDownload(filename, scene) {
		
			if(objectUrl) {
				window.URL.revokeObjectURL(objectUrl);
			}

			var serializedScene = BABYLON.SceneSerializer.Serialize(scene);

			var strScene = JSON.stringify(serializedScene);

			if (filename.toLowerCase().lastIndexOf(".babylon") !== filename.length - 8 || filename.length < 9){
				filename += ".babylon";
			}

			var blob = new Blob ( [ strScene ], { type : "octet/stream" } );

			// turn blob into an object URL; saved as a member, so can be cleaned out later
			objectUrl = (window.webkitURL || window.URL).createObjectURL(blob);

			var link = window.document.createElement('a');
			link.href = objectUrl;
			link.download = filename;
			var click = document.createEvent("MouseEvents");
			click.initEvent("click", true, false);
			link.dispatchEvent(click);          
		}*/
        
		engine.runRenderLoop(function () {
            if (scene) {
                scene.render();
            }
        });
		
	
        // Resize
        window.addEventListener("resize", function () {
            engine.resize();
        });