//
//  ViewController.swift
//  CulturaVisual
//
//  Created by Maggie Jimenez Herrera on 10/13/19.
//  Copyright © 2019 Maggie Jimenez Herrera. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var lbQuizzlet: UILabel!
    @IBOutlet weak var btTemas: UIButton!
    @IBOutlet weak var btPerfil: UIButton!
    @IBOutlet weak var btCreditos: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLayout()
        // Do any additional setup after loading the view.
    }

    func setUpLayout(){
        
        // Activa los constrains
        btTemas.translatesAutoresizingMaskIntoConstraints = false
        btPerfil.translatesAutoresizingMaskIntoConstraints = false
        btCreditos.translatesAutoresizingMaskIntoConstraints = false
        lbQuizzlet.translatesAutoresizingMaskIntoConstraints = false
        
        //Constrains del label
        lbQuizzlet.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        lbQuizzlet.topAnchor.constraint(equalTo: view.topAnchor, constant: 170).isActive = true
//        lbQuizzlet.widthAnchor.constraint(equalToConstant: 170).isActive = true
//        lbQuizzlet.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        
        //Constrains del boton Temas
        btTemas.topAnchor.constraint(equalTo: lbQuizzlet.bottomAnchor, constant: 80).isActive = true
        btTemas.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
       btTemas.widthAnchor.constraint(equalToConstant: 190).isActive = true
        btTemas.heightAnchor.constraint(equalToConstant: 75).isActive = true
        
        //Constarins del boton Perfil
        btPerfil.topAnchor.constraint(equalTo: btTemas.bottomAnchor, constant: 40).isActive = true
        btPerfil.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        btPerfil.widthAnchor.constraint(equalToConstant: 190).isActive = true
        btPerfil.heightAnchor.constraint(equalToConstant: 75).isActive = true
        
       // Constrains del boton Creditos
       btCreditos.topAnchor.constraint(equalTo: btPerfil.bottomAnchor, constant: 40).isActive = true
        btCreditos.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    btCreditos.widthAnchor.constraint(equalToConstant: 190).isActive = true
    btCreditos.heightAnchor.constraint(equalToConstant: 75).isActive = true
        
        
    }

}

