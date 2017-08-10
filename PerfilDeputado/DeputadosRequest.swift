//
//  DeputadosRequest.swift
//  PerfilDeputado
//
//  Created by Matheus Azevedo on 04/08/17.
//  Copyright © 2017 Matheus Azevedo. All rights reserved.
//

import Foundation
import Alamofire

class DeputadosRequest{
    let serverURL = "http://localhost:3000/allDeputados"
    let serverURLdeputados = "http://localhost:3000/deputados"
    
    /**
     Executa requisição para lista completa dos deputados da legislatura atual
     */
    func getAllDeputados (completion: @escaping (NSArray) -> ()){
        Alamofire.request(serverURL).responseJSON{ (response) in
            guard response.result.isSuccess else {
                print("Erro")
                completion(NSArray())
                return
            }
            let dictionary = response.result.value as! NSDictionary
            let deputados_dictionary = dictionary["deputados"] as! NSDictionary
            let deputados_array = deputados_dictionary["deputado"] as! NSArray
            completion(deputados_array)
        }
    }
    
    /**
     Busca por um deputado específico, a partir de seu ID de cadastro
     - parameters:
     - deputados_array: Array que contem todos os deputados
     - deputadoID: ID de cadastro do deputado buscado
     - completion: Bloco de código a ser executado ao fim da busca
     */
    func getSelectedDeputado (deputados_array: NSArray, deputadoID: String, completion: @escaping (NSDictionary) -> ()) {
        for dictionary in deputados_array {
            if let deputado = dictionary as? NSDictionary {
                if deputado["ideCadastro"] as? String == deputadoID {
                    completion(deputado)
                }
            }
        }
    }
    
    func filterDeputados (partido: String, completion: @escaping(NSArray) -> ()) {
        Alamofire.request(URL(string:serverURLdeputados)!, parameters: ["partido": partido] ).responseJSON{ (response) in
            guard response.result.isSuccess else {
                print("Erro")
                completion(NSArray())
                return
            }
            if let deputados_array = response.result.value as? NSArray{
                completion(deputados_array)
            } else {
                print("Erro ao buscar deputados")
                completion(NSArray())
            }
        }
    }

}
