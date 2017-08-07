//
//  RequestFunctions.swift
//  PerfilDeputado
//
//  Created by Matheus Azevedo on 01/08/17.
//  Copyright © 2017 Matheus Azevedo. All rights reserved.
//

import Foundation
import Alamofire

class RequestFunctions{
    let serverURL = "http://localhost:3000/allDeputados"
    let pl_url = "http://localhost:3000/proposicoes?sigla=pl&ano="
    
    /**
     Executa requisição para lista completa dos deputados da legislatura atual
    */
    func getAllDeputados (completion: @escaping (NSArray) -> ()){
        Alamofire.request(serverURL).responseJSON{ (response) in
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
    /**
     Requere todos os Projetos de Lei da legislatura atual, dos anos de 2015, 2016 e 2017
    */
    func getAllPL(completion: @escaping (NSArray) -> ()) {
        
        getAllPL(in: "2015", completion: { array1 in
            self.getAllPL(in: "2016", completion: { array2 in
                self.getAllPL(in: "2017", completion: { array3 in
                    let array1e2 = array1.addingObjects(from: array2 as! [Any]) as NSArray
                    let pl_array = array1e2.addingObjects(from: array3 as! [Any]) as NSArray
                    completion(pl_array)
                })
            })
        })
    }
    
    func getAllPL(in year:String, completion: @escaping (NSArray) -> ()) {
        let request_url = pl_url + year
        Alamofire.request(request_url).responseJSON{ (response) in
            let dictionary = response.result.value as! NSDictionary
            let proposicoes_dictionary = dictionary["proposicoes"] as! NSDictionary
            let proposicoes_array = proposicoes_dictionary["proposicao"] as! NSArray
            
            completion(proposicoes_array)
        }
    }
    
    func searchPLs(in proposicoes_array: NSArray, deputadoID: String) -> NSArray{
        var pl_array = NSArray()
        for dictionary in proposicoes_array {
            if let pl = dictionary as? NSDictionary,
                let autor = pl["autor1"] as? NSDictionary {
                if autor["idecadastro"] as? String == deputadoID {
                    pl_array = pl_array.adding(pl) as NSArray
                }
            }
        }
        return pl_array
    }
    
    func searchPLs(year: String, by deputado: NSDictionary, completion: @escaping (NSArray) -> ()) {
        let request_autor = deputado["nomeParlamentar"] as! String
        let request_url = pl_url + year + "&parteNomeAutor=" + request_autor
        
        Alamofire.request(request_url).responseJSON{ (response) in
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
