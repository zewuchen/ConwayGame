//
//  GameScene.swift
//  ConwayGame
//
//  Created by Zewu Chen on 01/11/19.
//  Copyright © 2019 Zewu Chen. All rights reserved.
//

import Foundation
import SceneKit

class GameScene: SCNScene {
    
    var grid = [[CellNode]]()
    let tamanho = 15
    var gridModel = Grid(tamanho: 15)
    let half = Int(15 / 2)
    var centerCell = CellNode(estado: 0)
    
    override init() {
        super.init()
        
        nextGen()
        
        setCamera()
        centerCamera(basedOn: centerCell)
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
        self.grid = gridModel.nextGen()
        
        addNodes()
    }
    
    func addNodes() {
        for x in 0...grid.count-1 {
            for y in 0...grid[0].count-1 {
                self.rootNode.addChildNode(grid[x][y])
                
                if x == half && y == half {
                    centerCell = grid[x][y]
                }
            }
        }
    }
    
    func rmNodes() {
        for linha in self.grid{
            for node in linha {
                node.removeFromParentNode()
            }
        }
    }

}
