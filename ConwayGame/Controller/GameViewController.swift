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

protocol clearScene {
    func clear()
}

class GameViewController: UIViewController {

    let scene = GameScene()
    var play = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScene()

        scene.clearSceneProtocol = self
    }
    
    func setupScene() {
        let scnView = self.view as! SCNView
        
        scnView.scene = scene
        scnView.pointOfView?.position = SCNVector3Make(2, -20, 25)
        
        scnView.showsStatistics = true
        
        scnView.backgroundColor = UIColor.black

        setLight()

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        scnView.addGestureRecognizer(tapGesture)
    }

    func setLight() {
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = .omni
        lightNode.position = SCNVector3(x: 100, y: -20, z: 100)
        scene.rootNode.addChildNode(lightNode)

        let ambientNode = SCNNode()
        ambientNode.light = SCNLight()
        ambientNode.light!.type = .ambient
        ambientNode.light!.color = UIColor.darkGray
        scene.rootNode.addChildNode(ambientNode)
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
                if play {
                    self.play = false
                    scene.setGeometryPlayButton()
                } else {
                    play = true
                    start()
                    scene.setGeometryPlayButton()
                }
            } else if result.node.name == "clear" {
                scene.reset()
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
    
    func start() {
        if play {
            scene.nextGen()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.start()
            }
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

extension GameViewController: clearScene {
    func clear() {

        if play == true {
            scene.setGeometryPlayButton()
        }

        self.play = false

        scene.rootNode.enumerateChildNodes { (node, stop) in
            if !(node.name == "play" || node.name == "clear") {
                node.removeFromParentNode()
            }
        }

        setLight()
    }
}
