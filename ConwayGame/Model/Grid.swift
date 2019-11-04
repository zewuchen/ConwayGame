//
//  Grid.swift
//  ConwayGame
//
//  Created by Zewu Chen on 04/11/19.
//  Copyright © 2019 Zewu Chen. All rights reserved.
//

import Foundation
import SceneKit

class Grid {
    var grid = [[CellNode]]()
    var gridNova = [[CellNode]]()
    let margem: Int = 5
    
    init(tamanho: Int) {
        
        for x in 0...tamanho-1 {
            
            var linha = [CellNode]()
            
            for y in 0...tamanho-1 {
                let cell = CellNode(estado: 0)
                cell.position.x = Float(x-margem)
                cell.position.y = Float(y-margem)
                linha.append(cell)
            }
            
            grid.append(linha)
            gridNova.append(linha)
        }
        
    }
    
    func nextGen() -> [[CellNode]]{
        for i in 0...grid.count - 1 {
            for j in 0...grid[0].count - 1 {
                applyRules(x: i, y: j)
            }
        }
        
        grid = gridNova
        
        return grid
    }
    
    func applyRules(x:Int, y:Int){
        let central = grid[x][y].estado
        var topLeft = 0
        var topCentral = 0
        var topRight = 0
        var left = 0
        var right = 0
        var botLeft = 0
        var botCentral = 0
        var botRight = 0
        
        if x-1 < 0{
            if y-1 < 0 {
                right = grid[x][y+1].estado
                botCentral = grid[x+1][y].estado
                botRight = grid[x+1][y+1].estado
            }else if y+1 > grid[0].count-1 {
                left = grid[x][y-1].estado
                botLeft = grid[x+1][y-1].estado
                botCentral = grid[x+1][y].estado
            }else{
                left = grid[x][y-1].estado
                right = grid[x][y+1].estado
                botLeft = grid[x+1][y-1].estado
                botCentral = grid[x+1][y].estado
                botRight = grid[x+1][y+1].estado
            }
        }else if x+1 > grid.count-1{
            if y-1 < 0 {
                topCentral = grid[x-1][y].estado
                topRight = grid[x-1][y+1].estado
                right = grid[x][y+1].estado
            }else if y+1 > grid[0].count-1 {
                topLeft = grid[x-1][y-1].estado
                topCentral = grid[x-1][y].estado
                left = grid[x][y-1].estado
            }else{
                topLeft = grid[x-1][y-1].estado
                topCentral = grid[x-1][y].estado
                topRight = grid[x-1][y+1].estado
                left = grid[x][y-1].estado
                right = grid[x][y+1].estado
            }
        }else{
            if y-1 < 0 {
                topCentral = grid[x-1][y].estado
                topRight = grid[x-1][y+1].estado
                right = grid[x][y+1].estado
                botCentral = grid[x+1][y].estado
                botRight = grid[x+1][y+1].estado
            }else if y+1 > grid[0].count-1 {
                topLeft = grid[x-1][y-1].estado
                topCentral = grid[x-1][y].estado
                left = grid[x][y-1].estado
                botLeft = grid[x+1][y-1].estado
                botCentral = grid[x+1][y].estado
            }else{
                topLeft = grid[x-1][y-1].estado
                topCentral = grid[x-1][y].estado
                topRight = grid[x-1][y+1].estado
                left = grid[x][y-1].estado
                right = grid[x][y+1].estado
                botLeft = grid[x+1][y-1].estado
                botCentral = grid[x+1][y].estado
                botRight = grid[x+1][y+1].estado
            }
        }
        
        let resultado = topLeft + topCentral + topRight + left + right + botLeft + botCentral + botRight
        
        if central == 1 {
            if resultado <= 1 || resultado >= 4{
                let cell = CellNode(estado: 0)
                cell.position.x = grid[x][y].position.x
                cell.position.y = grid[x][y].position.y
                gridNova[x][y] = cell
            }else{
                let cell = CellNode(estado: 1)
                cell.position.x = grid[x][y].position.x
                cell.position.y = grid[x][y].position.y
                gridNova[x][y] = cell
            }
        } else {
            if resultado == 3 {
                let cell = CellNode(estado: 1)
                cell.position.x = grid[x][y].position.x
                cell.position.y = grid[x][y].position.y
                gridNova[x][y] = cell
            }else{
                let cell = CellNode(estado: 0)
                cell.position.x = grid[x][y].position.x
                cell.position.y = grid[x][y].position.y
                gridNova[x][y] = cell
            }
        }
        
    }
}
