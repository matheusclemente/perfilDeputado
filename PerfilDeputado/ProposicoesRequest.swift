//
//  ProposicoesRequest.swift
//  PerfilDeputado
//
//  Created by Matheus Azevedo on 04/08/17.
//  Copyright © 2017 Matheus Azevedo. All rights reserved.
//

import Foundation
import Alamofire

class ProposicoesRequest{
    let serverURL = "http://localhost:3000/proposicoes"
    

    
    func searchPLs(year: String, by deputado: NSDictionary, completion: @escaping (NSArray) -> ()) {
        let request_autor = deputado["nomeParlamentar"] as! String
        
        Alamofire.request(URL(string: serverURL)!, parameters: ["sigla":"pl","ano":year, "parteNomeAutor":request_autor]).responseJSON{ (response) in
            if let dictionary = response.result.value as? NSDictionary {
                
                if let proposicoes_dictionary = dictionary["proposicoes"] as? NSDictionary {
                    let proposicoes_array = proposicoes_dictionary["proposicao"] as! NSArray
                    completion(proposicoes_array)
                } else {
                    print("A Proposicao procurada nao existe")
                }
            } else {
                print("Erro na requisicao")
                print(response.result.value)
            }
        }
    }
    
    func searchPLs(year: String, completion: @escaping (NSArray) -> ()) {
        Alamofire.request(URL(string: serverURL)!, parameters: ["sigla":"pl","ano":year]).responseJSON{ (response) in
            if let dictionary = response.result.value as? NSDictionary {
                
                if let proposicoes_dictionary = dictionary["proposicoes"] as? NSDictionary {
                    let proposicoes_array = proposicoes_dictionary["proposicao"] as! NSArray
                    completion(proposicoes_array)
                } else {
                    print("A Proposicao procurada nao existe")
                }
            } else {
                print("Erro na requisicao")
                print(response.result.value)
            }
        }
        
    }
}
