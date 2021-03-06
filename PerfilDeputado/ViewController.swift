//
//  ViewController.swift
//  PerfilDeputado
//
//  Created by Matheus Azevedo on 31/07/17.
//  Copyright © 2017 Matheus Azevedo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var selectedDeputado:NSDictionary?
    var plDeputado:NSArray?
    
    @IBOutlet weak var nomeLabel: UILabel!
    @IBOutlet weak var partidoLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var telefoneLabel: UILabel!
    @IBOutlet weak var imagemDep: UIImageView!
    
    @IBOutlet weak var totalProposicoes: UILabel!
    @IBOutlet weak var totalPL: UILabel!
    @IBOutlet weak var totalPLC: UILabel!
    @IBOutlet weak var totalPEC: UILabel!
    @IBOutlet weak var totalMPV: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let dep_req = DeputadosRequest()
        var dep_array = NSArray()

        
        //teste deputados por partido
            dep_req.filterDeputados(partido: "PSD") { (array) in
                print("Deputados:\(array.count)")
        }
        
        //
        //teste votacoesrequest
        let votacoes_req = VotacoesRequest()
        votacoes_req.searchVotacoes(tipo: "pl", numero: "6787", ano: "2017") { (array) in
            print("Votacoes: \(array.count)")
            print(array)
        }
        //-------
        
        dep_req.getAllDeputados(completion: { array in
            dep_array = array
            dep_req.getSelectedDeputado(deputados_array: dep_array, deputadoID: "160510", completion: { deputado in
                print(deputado)
                self.selectedDeputado = deputado
          
                
                self.setLabels()
            })
        })
        
    }
    
    /**
     Configura as labels com os dados do deputado selecionado
     */
    func setLabels() {
        self.nomeLabel.text = selectedDeputado?["nomeParlamentar"] as? String
        self.partidoLabel.text = selectedDeputado?["partido"] as? String
        self.emailLabel.text = selectedDeputado?["email"] as? String
        self.telefoneLabel.text = selectedDeputado?["fone"] as? String
        
        let urlFoto = selectedDeputado?["urlFoto"] as! String
        
        if let url  = NSURL(string: urlFoto),
            let data = NSData(contentsOf: url as URL)
        {
            self.imagemDep.image = UIImage(data: data as Data)
        }

        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

