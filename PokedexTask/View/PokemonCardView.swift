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
        let pokemon=self.viewModel.pokemon
        ScrollView{
            VStack{
                ZStack{
                    
                    Rectangle()
                        .fill(Color.gray)
                    
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
                    Text("test")
                    ZStack{
                        Rectangle()
                            .fill(Color.white)
                            .clipShape(.rect(cornerRadius: 25))
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
    }
}

#Preview {
    PokemonCardView(id: 1)
        .previewLayout(.sizeThatFits)
}

