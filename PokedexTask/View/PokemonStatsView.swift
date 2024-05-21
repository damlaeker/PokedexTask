//
//  PokemonStatsView.swift
//  PokedexTask
//
//  Created by Damla Eker on 20/05/2024.
//

import SwiftUI

struct PokemonStatsView: View {
    @State private var downloadAmount = 0.0
    @StateObject var viewModel = PokemonDetailViewModel()
    var stats : [Stat]?
    var body: some View {
        
        VStack{
            ForEach(0..<((stats?.count ?? 0)), id: \.self){
                i in
                let stat = stats?[i]
                let statValue = Float(stats?[i].baseStat ?? 0)
                
                HStack{
                    //Text("\(stats?[i].stat.name ?? "")")
                    
                    ProgressView("", value: statValue, total: 100)
                        .accentColor(self.viewModel.getStatColor(stat: K.pokemonStat(rawValue: (stat?.stat.name) ?? "") ?? .hp))
                        .scaleEffect(x: 1, y: 8, anchor: .bottom)
                        .padding(10)
                        .overlay(alignment: .center){
                            HStack{
                                Text("\(stat?.stat.name.capitalized ?? ""):")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 16, weight: .semibold,design: .default))
                                Text("\(Int(statValue))/100")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 14, weight:.medium,design: .default))
                            }
                        }
                }
            }
        }
        .background {
            Color("AppBackgroundColor")
                .ignoresSafeArea()
        }
    }
    
}



#Preview {
    PokemonStatsView(stats:nil)
}
