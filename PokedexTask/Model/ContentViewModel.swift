//
//  ContentViewModel.swift
//  PokedexTask
//
//  Created by Damla Eker on 17/05/2024.
//

import Foundation

class ContentViewViewModel: ObservableObject {
    @MainActor @Published var errorMessage = ""
    @MainActor @Published var pokemons: [APIItem]?
    
    @MainActor @Published var pokemonSprites: [String]?

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
    
    func fetchPokesSprites() async {
        await MainActor.run {
            self.errorMessage = ""
        }
        if let res = await NetworkAPI.getPokemonSprites() {
            await MainActor.run {
                self.pokemonSprites=res
            }
        } else {
            await MainActor.run {
                self.errorMessage = "Fetch data failed"
            }
        }
    }
}
