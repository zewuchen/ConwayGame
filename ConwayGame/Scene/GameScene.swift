//
//  GameScene.swift
//  ConwayGame
//
//  Created by Zewu Chen on 01/11/19.
//  Copyright © 2019 Zewu Chen. All rights reserved.
//

import Foundation
import SceneKit
import QuartzCore

class GameScene: SCNScene {
    
    var grid = [[CellNode]]()
    let tamanho = 15
    var gridModel = Grid(tamanho: 15)
    let half = Int(15 / 2)
    var centerCell = CellNode(estado: 0)
    var playButton: SCNNode?
    var controlPlayGeometry: Bool = true
    var first = 0
    var alternate: Bool = true
    
    override init() {
        super.init()
        
        nextGen()
        
        setCamera()
        centerCamera(basedOn: centerCell)
        
        setPlayButton()
    }
        
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setCamera() {
        let camera = SCNCamera()
        let cameraNode = SCNNode()
        cameraNode.name = "camera"
        cameraNode.camera = camera
        cameraNode.position = SCNVector3(x: 5, y: 4, z: 25.0)
        rootNode.addChildNode(cameraNode)
    }
    
    func centerCamera(basedOn node: SCNNode) {
        let constraint = SCNLookAtConstraint(target: node)
        constraint.isGimbalLockEnabled = true
        guard let cameraNode = rootNode.childNode(withName: "camera", recursively: true) else { return }
        cameraNode.constraints = [constraint]
    }
    
    func nextGen() {
//        rmNodes()
        self.grid = gridModel.nextGen()
        addNodes()
    }
    
    func addNodes() {
        for x in 0...grid.count-1 {
            for y in 0...grid[0].count-1 {
                if grid[x][y].estado == 1, first != 0{
                    if alternate {
                        grid[x][y].geometry?.firstMaterial?.diffuse.contents = UIColor.cyan
                    } else {
                        grid[x][y].geometry?.firstMaterial?.diffuse.contents = UIColor.systemPink
                    }
                    self.rootNode.addChildNode(grid[x][y])
                } else if first == 0{
                    self.rootNode.addChildNode(grid[x][y])
                }
                
                if x == half && y == half {
                    centerCell = grid[x][y]
                }
            }
        }
        
        first = 1
        alternate = !alternate
    }
    
    func rmNodes() {
        for linha in self.grid{
            for node in linha {
                node.removeFromParentNode()
            }
        }
    }
    
    func setPlayButton() {
        let geometry = SCNPyramid(width: 3, height: 3, length: 0.08)
        playButton = SCNNode(geometry: geometry)
        playButton?.name = "play"
        playButton?.position.x = 1
        playButton?.position.y = -8
        playButton?.rotation = SCNVector4Make(0, 0, -1, Float(Double.pi/2));
        playButton?.geometry?.firstMaterial?.diffuse.contents = UIColor.systemBlue
        self.rootNode.addChildNode(playButton ?? SCNNode())
    }
    
    func setGeometryPlayButton() {
        if controlPlayGeometry {
            self.playButton?.geometry = SCNBox(width: 3, height: 3, length: 0.08, chamferRadius: 0.005)
            playButton?.geometry?.firstMaterial?.diffuse.contents = UIColor.red
            playButton?.position.x = 2
            playButton?.position.y = -8
            controlPlayGeometry = false
        } else {
            self.playButton?.geometry = SCNPyramid(width: 3, height: 3, length: 0.08)
            playButton?.position.x = 1
            playButton?.position.y = -8
            playButton?.geometry?.firstMaterial?.diffuse.contents = UIColor.systemBlue
            controlPlayGeometry = true
        }
        
    }
    
//    func setClearButton() {
//        let geometry = SCNCylinder(radius: 1, height: 1)
//        let clearButton = SCNNode(geometry: geometry)
//        clearButton.name = "clear"
//        clearButton.position.x = 6
//        clearButton.position.y = -8
//        clearButton.rotation = SCNVector4Make(0, 0, -1, Float(Double.pi/2));
//        clearButton.geometry?.firstMaterial?.diffuse.contents = UIColor.yellow
//        self.rootNode.addChildNode(clearButton)
//    }

}
