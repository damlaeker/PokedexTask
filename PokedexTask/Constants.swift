//
//  K.swift
//  PokedexTask
//
//  Created by Damla Eker on 20/05/2024.
//

import Foundation

struct K{
    enum pokemonStat:String {
        case hp = "hp"
        case attack = "attack"
        case defence = "defense"
        case specialAttack = "special-attack"
        case specialDefence = "special-defense"
        case speed = "speed"
        
    }
    
    enum pokemonType:String {
        case normal = "normal"
        case fire = "fire"
        case water = "water"
        case grass = "grass"
        case electric = "electric"
        case ice = "ice"
        case fighting = "fighting"
        case poison = "poison"
        case ground = "ground"
        case flying = "flying"
        case psychic = "psychic"
        case bug = "bug"
        case rock = "rock"
        case ghost = "ghost"
        case dragon = "dragon"
        case dark = "dark"
        case steel = "steel"
        case fairy = "fairy"
        
    }
    
    static func convertKg(value:Int) ->String{
        return String(format:"%.1f kg", Double(value)/10.0)
        
    }
    
    static func convertCm(value:Int)-> String{
        return String(format:"%.1f cm", Double(value)/10.0)
    }
    
}

 

