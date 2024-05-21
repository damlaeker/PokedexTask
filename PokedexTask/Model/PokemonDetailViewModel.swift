//
//  PokemonStatsViewModel.swift
//  PokedexTask
//
//  Created by Damla Eker on 20/05/2024.
//

import SwiftUI
class PokemonDetailViewModel: ObservableObject {
    @MainActor @Published var errorMessage = ""
    @MainActor @Published var pokemon: PokemonDetails?
    func getStatColor(stat: K.pokemonStat)->Color{
        switch stat{
            
        case .hp:
            return Color(hex: 0x1e5631)
        case .attack:
            return Color(hex: 0xc60000)
        case .defense:
             return Color(hex: 0xfd5901)
        case .specialAttack:
            return Color(hex: 0x023e8a)
        case .specialDefense:
            return .purple
        case .speed:
            return .cyan
        }
    }
    func getTypeColor(type: K.pokemonType)->Color{
       
        switch type{
            
        case .normal:
            return Color(hex: 0xa4acaf)
        case .fire:
            return Color(hex: 0xFD7D26)
        case .water:
            return Color(hex: 0x4592c4)
        case .grass:
            return Color(hex: 0x9bcc50)
        case .electric:
            return Color(hex: 0xeed535)
        case .ice:
            return Color(hex: 0x51c4e7)
        case .fighting:
            return Color(hex: 0x9eb7b8)
        case .poison:
            return Color(hex: 0xb97fc9)
        case .ground:
            return Color(hex: 0x0d98ba)
        case .flying:
            return Color(hex: 0x0d98ba)
        case .psychic:
            return Color(hex: 0xf366b9)
        case .bug:
            return Color(hex: 0x729f3f)
        case .rock:
            return Color(hex: 0xa38c21)
        case .ghost:
            return Color(hex: 0x7b62a3)
        case .dragon:
            return Color(hex: 0x0d98ba)
        case .dark:
            return Color(hex: 0x707070)
        case .steel:
            return Color(hex: 0x9eb7b8)
        case .fairy:
            return Color(hex: 0xfdb9e9)
        }
    }
    
    func fetchPokemon(id:Int) async{
        await MainActor.run {
            self.errorMessage = ""
        }
        if let res = await NetworkAPI.getPokemon(id: id ) {
            await MainActor.run {
                self.pokemon = res
            }
        } else {
            await MainActor.run {
                self.errorMessage = "Fetch data failed"
            }
        }
    }
    
   
}
extension Color {
    init(hex: Int, opacity: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: opacity
        )
    }
}
