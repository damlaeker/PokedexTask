//
//  PokemonStatsViewModel.swift
//  PokedexTask
//
//  Created by Damla Eker on 20/05/2024.
//

import SwiftUI
class PokemonStatsViewModel: ObservableObject {
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
