//
//  GameViewController.swift
//  ConwayGame
//
//  Created by Zewu Chen on 31/10/19.
//  Copyright © 2019 Zewu Chen. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit

class GameViewController: UIViewController {
    
    let scene = GameScene()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setPlayButton()
        setupScene()
    }
    
    func setPlayButton() {
        let geometry = SCNPyramid(width: 3, height: 3, length: 0.08)
        let playButton = SCNNode(geometry: geometry)
        playButton.name = "play"
        playButton.position.x = 1
        playButton.position.y = -8
        playButton.rotation = SCNVector4Make(0, 0, -1, Float(Double.pi/2));
        playButton.geometry?.firstMaterial?.diffuse.contents = UIColor.systemBlue
        scene.rootNode.addChildNode(playButton)
    }
    
//    func setClearButton() {
//        let geometry = SCNCylinder(radius: 1, height: 1)
//        let clearButton = SCNNode(geometry: geometry)
//        clearButton.name = "clear"
//        clearButton.position.x = 6
//        clearButton.position.y = -8
//        clearButton.rotation = SCNVector4Make(0, 0, -1, Float(Double.pi/2));
//        clearButton.geometry?.firstMaterial?.diffuse.contents = UIColor.yellow
//        scene.rootNode.addChildNode(clearButton)
//    }
    
    func setupScene() {
        let scnView = self.view as! SCNView
        
        scnView.scene = scene
        scnView.pointOfView?.position = SCNVector3Make(2, 2, 30)
        
        scnView.showsStatistics = true
        
        scnView.backgroundColor = UIColor.black
        
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = .omni
        lightNode.position = SCNVector3(x: 0, y: 10, z: 10)
        scene.rootNode.addChildNode(lightNode)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        scnView.addGestureRecognizer(tapGesture)
    }
    
    @objc
    func handleTap(_ gestureRecognize: UIGestureRecognizer) {
        let scnView = self.view as! SCNView

        let p = gestureRecognize.location(in: scnView)
        let hitResults = scnView.hitTest(p, options: [:])

        if hitResults.count > 0 {
            let result = hitResults[0]
            
            //Animação do clique no node
            let material = result.node.geometry!.firstMaterial!
            
            SCNTransaction.begin()
            SCNTransaction.animationDuration = 0.5
            
            SCNTransaction.completionBlock = {
                SCNTransaction.begin()
                SCNTransaction.animationDuration = 0.5
                
                material.emission.contents = UIColor.black
                
                SCNTransaction.commit()
            }
            
            if result.node.name == "play" {
                scene.rmNodes()
                scene.nextGen()
            } else {
                // Verifica o clique do estado e seta vivo ou morto
                let node = result.node as! CellNode
                
                if node.estado == 0 {
                    node.estado = 1
                } else {
                    node.estado = 0
                }
            }
            
            SCNTransaction.commit()
        }
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

}
