//
//  NetworkAPI.swift
//  PokedexTask
//
//  Created by Damla Eker on 17/05/2024.
//

import Foundation

class NetworkAPI{
    
    static func getAllPokemons() async -> [APIItem]? {
        do {
            let data = try await NetworkManager.shared.get(
                path: "/pokemon/?limit=1025", parameters: nil
            )
            let result: APIResponse = try NetworkAPI.parseData(data: data)
            return result.results
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
    
    static func getPokemon(id:Int) async -> PokemonDetails?
    {
        do {
            let data = try await NetworkManager.shared.get(
                path: "/pokemon/\(id)", parameters: nil
            )
            let result: PokemonDetails = try NetworkAPI.parseData(data: data)
            return result
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
    
    static func getPokemonSprites() async -> [String]? {
           do {
               let data = try await NetworkManager.shared.get(
                   path: "/pokemon", parameters: nil
               )
               var sprites=[String]()
               
               let result=await NetworkAPI.getAllPokemons()
               for number in 1...(result?.count ?? 1){
                   let poke = await NetworkAPI.getPokemon(id: number)
                   sprites.append(poke?.sprite.url ?? "")
               }
               return sprites
           } catch let error {
               print(error.localizedDescription)
               return nil
           }
       }
    private static func parseData<T: Decodable>(data: Data) throws -> T{
        guard let decodedData = try? JSONDecoder().decode(T.self, from: data)
        else {
            throw NSError(
                domain: "NetworkAPIError",
                code: 3,
                userInfo: [NSLocalizedDescriptionKey: "JSON decode error"]
            )
        }
        return decodedData
    }
}


struct APIResponse: Decodable {
    let count: Int
    let next: String
    let previous: String?
    let results: [APIItem]
}

struct APIItem:Codable {
    let name: String
    let url: String
}
