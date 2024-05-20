//
//  ContentView.swift
//  PokedexTask
//
//  Created by Damla Eker on 17/05/2024.
//

import SwiftUI

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewViewModel()
    private let adaptiveColoumns = [GridItem(.adaptive(minimum: 160))]
    @State var text = ""
    var body: some View {
        VStack{
            SearchBar(text: $text)
        }
        NavigationView{
            ScrollView{
                LazyVGrid(columns: adaptiveColoumns, spacing: 20){
                    ForEach(0..<20){
                        i in
                        NavigationLink(destination:PokemonCardView(viewModel:PokemonStatsViewModel(), id: i+1)){
                            ZStack{
                                Rectangle()
                                    .frame(width: 180,height: 180)
                                    .foregroundColor(Color.gray)
                                .cornerRadius(10)
                                AsyncImage(url: URL(string:self.viewModel.pokemonSprites?[i] ?? "")) { image in
                                    image.resizable()
                                } placeholder: {
                                    Color.clear
                                }
                                .foregroundColor(Color.gray)
                                .frame(width: 100, height: 100)
                                .clipShape(.rect(cornerRadius: 25))
                                .padding(30)
                                .font(.headline)
                                .overlay(alignment: .bottom){
                                    VStack{
                                        
                                        Text(self.viewModel.pokemons?[i].name.capitalized ?? "")
                                            .font(.system(size: 20, weight:.medium,design: .default))
                                    }
                                }
                            }
                            .overlay(alignment: .topTrailing){
                                Text("#\(i+1)")
                                    .padding(6)
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("PokeDex")
        .padding()
        .onAppear{
            Task{
                await self.viewModel.fetchAllPokemons()
                await self.viewModel.fetchPokesSprites()
                
                
            }
        }
        
    }
}

#Preview {
    ContentView()
}

