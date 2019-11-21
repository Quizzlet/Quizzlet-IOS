//
//  ViewControllerCreditos.swift
//  CulturaVisual
//
//  Created by Maggie Jimenez Herrera on 11/21/19.
//  Copyright © 2019 Maggie Jimenez Herrera. All rights reserved.
//

import UIKit

class ViewControllerCreditos: UIViewController {

    
    @IBOutlet weak var lbCreditos: UILabel!
    @IBOutlet weak var lbMensaje1: UILabel!
    @IBOutlet weak var lbMensaje3: UILabel!
    @IBOutlet weak var lbMensaje2: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLayout()
        

    }
    
    func setUpLayout(){
        
        //Habilita los constrains
        lbCreditos.translatesAutoresizingMaskIntoConstraints = false
        lbMensaje1.translatesAutoresizingMaskIntoConstraints = false
        lbMensaje2.translatesAutoresizingMaskIntoConstraints = false
        lbMensaje3.translatesAutoresizingMaskIntoConstraints = false
        
        
        //Constrains del label Creditos
        lbCreditos.topAnchor.constraint(equalTo: view.topAnchor, constant: 170).isActive = true
        lbCreditos.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        //Constrains del label mensaje 1
        lbMensaje1.topAnchor.constraint(equalTo: lbCreditos.bottomAnchor, constant: 70).isActive = true
        lbMensaje1.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        lbMensaje1.widthAnchor.constraint(equalToConstant: 343).isActive = true
        lbMensaje1.heightAnchor.constraint(equalToConstant: 155).isActive = true
        
        //Constrains del label mensaje 2
        lbMensaje2.topAnchor.constraint(equalTo: lbMensaje1.bottomAnchor, constant: 10).isActive = true
        lbMensaje2.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        lbMensaje2.widthAnchor.constraint(equalToConstant: 343).isActive = true
        lbMensaje2.heightAnchor.constraint(equalToConstant: 114).isActive = true
        
        //Constrains del label mensaje 3
        lbMensaje3.topAnchor.constraint(equalTo: lbMensaje2.bottomAnchor, constant: 10).isActive = true
        lbMensaje3.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        lbMensaje3.widthAnchor.constraint(equalToConstant: 343).isActive = true
        lbMensaje3.heightAnchor.constraint(equalToConstant: 76).isActive = true
        
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
