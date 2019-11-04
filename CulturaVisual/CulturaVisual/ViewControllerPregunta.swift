//
//  ViewControllerPregunta.swift
//  CulturaVisual
//
//  Created by Maggie Jimenez Herrera on 11/1/19.
//  Copyright © 2019 Maggie Jimenez Herrera. All rights reserved.
//

import UIKit

class ViewControllerPregunta: UIViewController {

    @IBOutlet weak var bt1: UIButton!
    @IBOutlet weak var bt2: UIButton!
    @IBOutlet weak var bt3: UIButton!
    @IBOutlet weak var bt4: UIButton!
    @IBOutlet weak var lbNum: UILabel!
    @IBOutlet weak var lbPregunta: UILabel!
    var cont : Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cont = 1
        lbPregunta.text = "Cuanto es 2 + 2?"
        lbNum.text = "\(cont!)"
        
        bt1.setTitle("8", for: .normal)
        bt2.setTitle("10", for: .normal)
        bt3.setTitle("4", for: .normal)
        bt4.setTitle("-1", for: .normal)
        

        bt1.layer.cornerRadius = 5
        bt1.layer.borderWidth = 3
        bt1.layer.borderColor = UIColor.black.cgColor
        bt2.layer.cornerRadius = 5
               bt2.layer.borderWidth = 3
               bt2.layer.borderColor = UIColor.black.cgColor
        bt3.layer.cornerRadius = 5
               bt3.layer.borderWidth = 3
               bt3.layer.borderColor = UIColor.black.cgColor
        bt4.layer.cornerRadius = 5
               bt4.layer.borderWidth = 3
               bt4.layer.borderColor = UIColor.black.cgColor
        // Do any additional setup after loading the view.
    }
    

    @IBAction func incorrecta(_ sender: Any) {
        bt4.layer.backgroundColor = UIColor.red.withAlphaComponent(0.5).cgColor
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)
        
    }
    
    @IBAction func incorrecta2(_ sender: Any) {
        bt3.layer.backgroundColor = UIColor.red.withAlphaComponent(0.5).cgColor
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)
    }
    
    @IBAction func incorrecta3(_ sender: Any) {
        bt1.layer.backgroundColor = UIColor.red.withAlphaComponent(0.5).cgColor
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)
    }
    
    @IBAction func correcta(_ sender: Any) {
        bt3.layer.backgroundColor = UIColor.green.withAlphaComponent(0.5).cgColor
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
