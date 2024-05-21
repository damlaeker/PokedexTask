//
//  PokemonCardView.swift
//  PokedexTask
//
//  Created by Damla Eker on 20/05/2024.
//

import SwiftUI

struct PokemonCardView: View {
    @StateObject var viewModel = PokemonDetailViewModel()
    let id:Int
    var body: some View {
        let pokemon=self.viewModel.pokemon
        ScrollView{
            VStack{
                ZStack{
                    Rectangle()
                        .fill(Color.gray)
                        .clipShape(.rect(cornerRadius: 25))
                    VStack{
                        Text(pokemon?.name.capitalized ?? "")
                            .font(.system(size: 20, weight:.medium,design: .default))
                            .foregroundStyle(.white)
                            .padding()
                        AsyncImage(url: URL(string: pokemon?.sprite.url ?? "")) { image in
                            image.resizable()
                        } placeholder: {
                            Color.clear
                        }
                        //.background(Color.white)
                        .frame(width: 180, height: 180)
                        .clipShape(.rect(cornerRadius: 25))
                        .overlay(alignment: .top){
                            
                        }
                        Text("Height: \(K.convertCm(value: pokemon?.height ?? 0) ), Weight: \(K.convertKg(value: pokemon?.weight ?? 0) )")
                            .foregroundStyle(.white)
                            .font(.system(size: 16, weight:.medium,design: .default))
                        HStack{
                            let types = pokemon?.types
                            ForEach(0..<((types?.count ?? 0)), id: \.self){
                                i in
                                let type = pokemon?.types[i]
                                Rectangle()
                                    
                                    .fill(self.viewModel.getTypeColor(type: K.pokemonType(rawValue: (type?.type.name) ?? "") ?? .fire))
                                    .frame(width: 100, height: 20)
                                    .clipShape(.rect(cornerRadius: 5))
                                    .overlay(){
                                        Text("\(type?.type.name ?? "")")
                                            .foregroundStyle(Color(.white))
                                    }
                            }
                        }
                        .padding()
                    }
                }
                .overlay(alignment: .bottom){
                   
                }
                VStack{
                    ZStack{
                        Rectangle()
                            .fill(Color.white)
                            .clipShape(.rect(cornerRadius: 25))
                            .padding()
                        PokemonStatsView(viewModel: self.viewModel,stats: pokemon?.stats)
                    }
                }
            }
            
            .onAppear{
                Task{
                    await self.viewModel.fetchPokemon(id:self.id)
                }
            }
           
            
        } 
        .padding()
        .background {
            Color("AppBackgroundColor")
                .ignoresSafeArea()
                
        }
    }
}

#Preview {
    PokemonCardView(id: 1)
        .previewLayout(.sizeThatFits)
}

