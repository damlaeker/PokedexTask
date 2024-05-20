//
//  ContentViewModel.swift
//  PokedexTask
//
//  Created by Damla Eker on 17/05/2024.
//

import Foundation

class ContentViewViewModel: ObservableObject {
    @MainActor @Published var errorMessage = ""
    @MainActor @Published var pokemons: [APIItem] = []
    @MainActor @Published var pokemon: PokemonDetails?

    func fetchAllPokemons() async {
        await MainActor.run {
            self.errorMessage = ""
        }
        if let res = await NetworkAPI.getAllPokemons() {
            await MainActor.run {
                self.pokemons = res
            }
        } else {
            await MainActor.run {
                self.errorMessage = "Fetch data failed"
            }
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
