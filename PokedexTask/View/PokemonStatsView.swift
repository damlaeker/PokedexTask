//
//  PokemonStatsView.swift
//  PokedexTask
//
//  Created by Damla Eker on 20/05/2024.
//

import SwiftUI

struct PokemonStatsView: View {
    @State private var downloadAmount = 0.0
    @StateObject var viewModel = PokemonStatsViewModel()
    var stats : [Stat]?
     
     let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
     
     //let lightPurple = Color(red: 156/255, green: 16/255, blue: 179/255)
     //let darkPurple = Color(red: 11/255, green: 13/255, blue: 50/255)
     //let lightTeal = Color(red: 6/256, green: 243/256, blue: 232/256)
     
     var body: some View {
         ZStack {
             //LinearGradient(gradient: Gradient(colors: [darkPurple, lightPurple]), startPoint: .bottom, endPoint: .top).edgesIgnoringSafeArea(.all)
            
             VStack{
                
                 ForEach(0..<((stats?.count ?? 0)), id: \.self){
                     i in
                     let stat = stats?[i]
                     let statValue = Float(stats?[i].baseStat ?? 0)
                     
                     HStack{
                         //Text("\(stats?[i].stat.name ?? "")")
                         ProgressView("", value: statValue, total: 100)
                             .accentColor(self.viewModel.getStatColor(stat: K.pokemonStat(rawValue: (stat?.stat.name) ?? "") ?? .hp))
                             .scaleEffect(x: 1, y: 4, anchor: .center)
                             .padding(6)
                     }
                 }
             }
         }
        
     }
 }


#Preview {
    PokemonStatsView(stats:nil)
}
