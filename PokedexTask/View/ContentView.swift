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
    var body: some View {
        NavigationView{
            ScrollView{
                LazyVGrid(columns: adaptiveColoumns, spacing: 20){
                    ForEach(0..<20){
                        i in
                        NavigationLink(destination:PokemonCardView(viewModel: self.viewModel, id: i+1)){
                            ZStack{
                                Rectangle()
                                    .frame(width: 180,height: 180)
                                    .foregroundColor(Color.gray)
                                .cornerRadius(10)
                                AsyncImage(url: URL(string:self.viewModel.pokemonSprites?[i] ?? "")) { image in
                                    image.resizable()
                                } placeholder: {
                                    Color.white
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
                                        /*HStack{
                                            ZStack{
                                                Rectangle()
                                                    .frame(width:80,height: 22)
                                                    .foregroundColor(Color.blue)
                                                    .cornerRadius(60)
                                                Text("type")
                                            }
                                            ZStack{
                                                Rectangle()
                                                    .frame(width:80,height: 22)
                                                    .foregroundColor(Color.blue)
                                                    .cornerRadius(60)
                                                Text("type")
                                            }
                                            
                                        }*/
                                    }
                                    
                                }
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

