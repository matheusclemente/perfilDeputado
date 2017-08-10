//
//  BuscaViewController.swift
//  PerfilDeputado
//
//  Created by Matheus Azevedo on 08/08/17.
//  Copyright © 2017 Matheus Azevedo. All rights reserved.
//

import UIKit

class BuscaViewController: UIViewController {

    @IBOutlet weak var mesTextField: UITextField!
    @IBOutlet weak var numProposLabel: UILabel!
    
    let calendar = Calendar.current
    var dateComponents = DateComponents()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        dateComponents.year = 0

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func buscarAction(_ sender: Any) {
        if dateComponents.year != 0,
            let date = calendar.date(from: dateComponents) {
            print("Buscando")
            let prop_req = ProposicoesRequest()
            prop_req.searchWithDateRange(firstDate: date.startOfMonth(), lastDate: date.endOfMonth(), sigla: "pl", ufAutor: "DF",completion: { array in
                print(array)
                self.numProposLabel.text = "Proposições encontradas: \(array.count)"
            })
        }
        
    }
    
    @IBAction func mesEditing(_ sender: Any) {
        let monthYearPicker = MonthYearPickerView()
        self.mesTextField.inputView = monthYearPicker
        monthYearPicker.onDateSelected = { (month: Int, year: Int) in
            self.dateComponents.month = month
            self.dateComponents.year = year
            self.mesTextField.text = "\(month)/\(year)"
        }
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
