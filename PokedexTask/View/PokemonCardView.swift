//
//  PokemonCardView.swift
//  PokedexTask
//
//  Created by Damla Eker on 20/05/2024.
//

import SwiftUI

struct PokemonCardView: View {
    @StateObject var viewModel = PokemonStatsViewModel()
    let id:Int
    var body: some View {
        var pokemon=self.viewModel.pokemon
        VStack{
            ZStack{
                
                Rectangle()
                    .fill(Color.gray)
                    .frame(width: 200,height: 300,alignment: .top)
                    .clipShape(.rect(cornerRadius: 25))
                
                AsyncImage(url: URL(string: pokemon?.sprite.url ?? "")) { image in
                    image.resizable()
                } placeholder: {
                    Color.white
                }
                .frame(width: 180, height: 180)
                .clipShape(.rect(cornerRadius: 25))
                .overlay(alignment: .top){
                    Text(pokemon?.name ?? "")
                }
                .padding()
            }
            .overlay(alignment: .bottom){
                Text("Height: \(pokemon?.height ?? 0), Weight: \(pokemon?.weight ?? 0)")
                    .padding()
            }
            
            VStack{
                ZStack{
                    Rectangle()
                        .fill(Color.gray)
                        .clipShape(.rect(cornerRadius: 25))
                    PokemonStatsView(viewModel: self.viewModel,stats: pokemon?.stats)
                    
                }
            }
        }
        
        .onAppear{
            Task{
                await self.viewModel.fetchPokemon(id:self.id)
                print(self.viewModel.pokemon?.stats)
            }
        }
        
        
    }
}

#Preview {
    PokemonCardView(id: 1)
        .previewLayout(.sizeThatFits)
}

