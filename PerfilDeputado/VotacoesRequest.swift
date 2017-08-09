//
//  VotacoesRequest.swift
//  PerfilDeputado
//
//  Created by Matheus Azevedo on 09/08/17.
//  Copyright © 2017 Matheus Azevedo. All rights reserved.
//

import Foundation
import Alamofire

class VotacoesRequest {
    let serverURLvotos = "http://localhost:3000/votosProposicao"
    
    func buscarVotacoes(tipo: String, numero: String, ano: String, completion: @escaping (NSArray) -> ()) {
        Alamofire.request(URL(string: serverURLvotos)!, parameters: ["tipo":tipo, "numero":numero, "ano":ano]).responseJSON { response in
            
            guard response.result.isSuccess else {
                print("Erro: \(String(describing: response.error))")
                completion(NSArray())
                return
            }
            
            let dictionary = response.result.value as? NSDictionary
            if let votacoes = dictionary?["proposicao"] as? NSDictionary {
                let votacoes_dictionary = votacoes["Votacoes"] as? NSDictionary
                if let votacoes_array = votacoes_dictionary?["Votacao"] as? NSArray {
                    completion(votacoes_array)
                } else { //Caso a requisição retorne uma única votacao, insere-a em um array
                    let votacoes_array: NSArray = [votacoes_dictionary!["Votacao"] as! NSDictionary]
                    completion(votacoes_array)
                }
            } else {
                print("A Proposicao procurada nao existe")
                completion(NSArray())
            }
        }
    }
}
