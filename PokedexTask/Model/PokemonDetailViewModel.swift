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
            return .green
        case .attack:
            return .red
        case .defence:
            return .orange
        case .specialAttack:
            return .blue
        case .specialDefence:
            return .purple
        case .speed:
            return .cyan
        }
    }
    func getTypeColor(type: K.pokemonType)->Color{
       
        switch type{
            
        case .normal:
            return .green
        case .fire:
            return .blue
        case .water:
            return .secondary
        case .grass:
            return .primary
        case .electric:
            return .accentColor
        case .ice:
            return .teal
        case .fighting:
            return .yellow
        case .poison:
            return .purple
        case .ground:
            return .mint
        case .flying:
            return .indigo
        case .psychic:
            return .cyan
        case .bug:
            return .red
        case .rock:
            return .brown
        case .ghost:
            return .white
        case .dragon:
            return .orange
        case .dark:
            return .black
        case .steel:
            return .gray
        case .fairy:
            return .pink
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
