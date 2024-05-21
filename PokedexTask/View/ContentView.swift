//
//  ContentView.swift
//  PokedexTask
//
//  Created by Damla Eker on 17/05/2024.
//

import SwiftUI


struct ContentView: View {
    @StateObject var viewModel = ContentViewViewModel()
    private let adaptiveColoumns = [GridItem(.adaptive(minimum: 160))]
    @State var text = ""
    @State var count=0
    init() {
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
        
    }
    var body: some View {
        NavigationView{
            VStack{
                SearchBar(text: $text)
                ScrollView{
                    LazyVGrid(columns: adaptiveColoumns, spacing: 20){
                        //ForEach((self.viewModel.pokemons?.filter({"\($0)".contains(text.lowercased()) || text.isEmpty}) ?? [APIItem(name: "", url: "")]),id: \.name){
                        //   it in
                        ForEach(Array((self.viewModel.pokemons?.enumerated().filter({"\($0)".contains(text.lowercased()) || text.isEmpty}) ?? [])),id: \.element.name){
                            (index, it) in
                            
                            NavigationLink(destination:PokemonCardView(viewModel:PokemonDetailViewModel(), id: index+1)){
                                ZStack{
                                    
                                    Rectangle()
                                        .frame(width: 180,height: 180)
                                        .foregroundColor(Color.gray)
                                        .cornerRadius(10)
                                    //AsyncImage(url: URL(string:self.viewModel.pokemonSprites?[index] ?? "")) { image in
                                    AsyncImage(url: URL(string:"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(index+1).png")) { image in
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
                                            
                                            Text(it.name.capitalized)
                                                .font(.system(size: 20, weight:.medium,design: .default))
                                                .foregroundStyle(.white)
                                        }
                                    }
                                }
                                .overlay(alignment: .topTrailing){
                                    Text("#\(index+1)")
                                        .foregroundStyle(.white)
                                        .padding(6)
                                }
                                
                            }
                            
                        }
                        
                    }
                }
            }
            
            .navigationTitle("PokeDex")
            .navigationBarTitleDisplayMode(.inline)
            .padding()
            .onAppear{
                Task{
                    await self.viewModel.fetchAllPokemons()
                    await self.viewModel.fetchPokesSprites()
                }
            }
            .background {
                Color("AppBackgroundColor")
                    .ignoresSafeArea()
            }
        }
    }
    
}



#Preview {
    ContentView()
}

