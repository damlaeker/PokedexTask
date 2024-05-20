//
//  ContentView.swift
//  PokedexTask
//
//  Created by Damla Eker on 17/05/2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewViewModel()
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text(self.viewModel.pokemon?.name ?? "")
        }
        .padding()
        .onAppear{
            Task{
                await self.viewModel.fetchPokemon(id:1)
                print("Pokemons  \(self.viewModel.pokemon)")
            }
        }
    }
}

#Preview {
    ContentView()
}
