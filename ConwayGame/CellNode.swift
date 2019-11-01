//
//  CellNode.swift
//  ConwayGame
//
//  Created by Zewu Chen on 01/11/19.
//  Copyright © 2019 Zewu Chen. All rights reserved.
//

import Foundation
import SceneKit

enum State {
    case vivo
    case morto
}

class CellNode: SCNNode {
    
    var estado: State?
    var x: Int?
    var y: Int?
    
    init(estado: State, x: Int, y: Int) {
        super.init()
        
        self.estado = estado
        self.x = x
        self.y = y
        let geometry = SCNBox(width: 0.5, height: 0.5, length: 0.08, chamferRadius: 0.005)
        self.geometry = geometry
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
