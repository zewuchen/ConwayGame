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
    let margem: Int = 8
    
    init(tamanho: Int) {
        super.init()
        
        for x in 0...tamanho-1 {
            
            var linha = [CellNode]()
            
            for y in 0...tamanho-1 {
                let cell = CellNode(estado: .morto, x: x, y: y)
                cell.position.x = Float(x-margem)
                cell.position.y = Float(y-margem)
                linha.append(cell)
                self.rootNode.addChildNode(cell)
            }
            
            grid.append(linha)
            
        }
    }
        
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
