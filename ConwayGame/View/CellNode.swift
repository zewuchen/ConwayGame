//
//  CellNode.swift
//  ConwayGame
//
//  Created by Zewu Chen on 01/11/19.
//  Copyright © 2019 Zewu Chen. All rights reserved.
//

import Foundation
import SceneKit

class CellNode: SCNNode {
    
    var estado: Int {
        willSet {
            if newValue == 1 {
                self.geometry?.firstMaterial?.diffuse.contents = UIColor.red
            }
            else{
                self.geometry?.firstMaterial?.diffuse.contents = UIColor.white
            }
        }
    }
    
    init(estado: Int) {
        self.estado = estado
        super.init()
        
        let geometry = SCNBox(width: 0.8, height: 0.8, length: 0.08, chamferRadius: 0.005)
        
        if estado == 1 {
            geometry.firstMaterial?.diffuse.contents = UIColor.red
        } else {
            geometry.firstMaterial?.diffuse.contents = UIColor.white
        }
        self.geometry = geometry
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.estado = 0
        super.init(coder: aDecoder)
    }
}
