//
//  DoodleViewController.swift
//  hoon
//
//  Created by kido  on 2021/05/10.
//

import UIKit
import ARKit

class DoodleViewController: UIViewController {

    @IBOutlet weak var sceneView: ARSCNView!
    let defaultConfiguration: ARWorldTrackingConfiguration = {
            let configuration = ARWorldTrackingConfiguration()
            configuration.planeDetection = .horizontal
            configuration.environmentTexturing = .automatic
            return configuration
        }()
        //cdljcohiho
        var drawingNode: SCNNode?
        //れれれれれれれれれl。krjhくぉfひお；frジェ:おgへ
        override func viewDidLoad() {
            super.viewDidLoad()
            
            sceneView.delegate = self
            sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            
            sceneView.session.run(defaultConfiguration)
        }
        
        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            
            sceneView.session.pause()
        }
        
        override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
            guard let point = touches.first?.location(in: sceneView) else {
                return
            }
            let point3D = sceneView.unprojectPoint(SCNVector3(point.x, point.y, 0.997))
            
            let node: SCNNode
            
            if let drawingNode = drawingNode {
                node = drawingNode.clone()
            } else {
                node = createBallLine()
                drawingNode = node
            }
            node.position = point3D
            sceneView.scene.rootNode.addChildNode(node)
        }
        
        func createBallLine() -> SCNNode {
            let ball = SCNSphere(radius: 0.005)
            ball.firstMaterial?.diffuse.contents = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
            
            let node = SCNNode(geometry: ball)
            return node
        }
        
            }

    extension DoodleViewController: ARSCNViewDelegate {
        
        func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
            
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


