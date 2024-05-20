//
//  SearchBar.swift
//  PokedexTask
//
//  Created by Damla Eker on 20/05/2024.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text:String
    @State private var isEditing = false
  
    var body: some View {
        HStack{
            TextField("Search Pokemon...",  text:$text)
                .padding(15)
                .padding(.horizontal,25)
                .background(Color(.systemGray6))
                .foregroundColor(.black)
                .cornerRadius(10)
                .overlay(
                    HStack{
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/,maxWidth: .infinity,alignment: .leading)
                            .padding(.leading,15)
                        if isEditing{
                            Button(action: {
                                self.text = ""
                            }, label:{
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing,8)
                            })
                        }
                    }
                ).onTapGesture {
                    self.isEditing=true
                }
            if isEditing{
                Button(action: {
                    self.isEditing=false
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }){
                    Text("Cancel")
                }
                //.offset(x: isEditing ? -100: -10,y:0)
                .padding(.trailing,10)
                .transition(.move(edge: .trailing))
                //.animation(.easeInOut(duration: 5.0), value: isEditing)
                
            }
        }
    }
}



