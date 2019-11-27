//
//  ViewControllerSingUp.swift
//  CulturaVisual
//
//  Created by Angel Trevino on 14/10/19.
//  Copyright © 2019 Maggie Jimenez Herrera. All rights reserved.
//

import UIKit

class ViewControllerSingUp: UIViewController {

    @IBOutlet weak var tfCorreo: UILabel!
    @IBOutlet weak var tfPass: UILabel!
    @IBOutlet weak var tfMatricula: UILabel!
    @IBOutlet weak var tfNombre: UILabel!
    @IBOutlet weak var tfPass2: UILabel!
    
    @IBOutlet weak var lbNombre: UITextField!
    @IBOutlet weak var lbMatricula: UITextField!
    @IBOutlet weak var lbEmail: UITextField!
    @IBOutlet weak var lbPassword: UITextField!
    @IBOutlet weak var lbConfirmPassword: UITextField!
    
    
    @IBOutlet weak var btSignUp: UIButton!
    
    //------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad();
        setUpLayout()
        
        self.navigationController?.isNavigationBarHidden = false;
        // Do any additional setup after loading the view.
    }
    
    //------------------------------------------------------
    @IBAction func onSingUp(_ sender: UIButton) {
        if let strName = lbNombre.text,
           let strMatricula = lbMatricula.text,
            let strEmail = lbEmail.text,
            let strPassword = lbPassword.text,
            let strConfirmPassword = lbConfirmPassword.text {
            
            if strName == "" ||
                strMatricula == "" ||
                strEmail == "" ||
                strPassword == "" ||
                strConfirmPassword == ""
            {
                showAlert(
                    strType:
                    "Error",
                    strCode: "",
                    strMessage: "Ingresa todos los datos solicitados"
                )
            } else if strPassword != strConfirmPassword {
                showAlert(
                    strType: "Error",
                    strCode: "",
                    strMessage: "Las contraseñas no coinciden"
                )
            }
            else{
                UserAPI.shared.Singup(
                    strMatricula: strMatricula,
                    strName: strName,
                    strEmail: strEmail,
                    strPassword: strPassword
                ) { (res) in
                    switch res {
                    case .failure(let err as NSError):
                        var ErrorCode: String = "";
                        var ErrorMessage: String = "";
                        if(
                            //Client error
                            err.code >= 400 &&
                            err.code < 600
                            ){
                            ErrorCode = "\(err.code)"
                            ErrorMessage = err.userInfo["message"]! as! String
                        } else {
                            ErrorMessage = err.localizedDescription
                        }
                        self.showAlert(
                            strType: "Error",
                            strCode: ErrorCode,
                            strMessage: ErrorMessage
                        )
                    case .success(let res):
                        self.showAlert(
                            strType: "Success",
                            strCode: "",
                            strMessage: res
                        )
                    }
                }
            }
        }
    }
    
    //------------------------------------------------------
    func showAlert(
        strType: String,
        strCode: String,
        strMessage: String
    ) {
        let alert = UIAlertController(
            title: strType,
            message: strMessage,
            preferredStyle: .alert
        )
        
        let action = UIAlertAction(
            title: "OK",
            style: .cancel,
            handler: nil
        )
        
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Autolayout
    //------------------------------------------------------
    func setUpLayout(){
        lbNombre.translatesAutoresizingMaskIntoConstraints = false
        tfNombre.translatesAutoresizingMaskIntoConstraints = false
        lbMatricula.translatesAutoresizingMaskIntoConstraints = false
        lbConfirmPassword.translatesAutoresizingMaskIntoConstraints = false
        lbPassword.translatesAutoresizingMaskIntoConstraints = false
        lbEmail.translatesAutoresizingMaskIntoConstraints = false
        tfMatricula.translatesAutoresizingMaskIntoConstraints = false
        
        btSignUp.translatesAutoresizingMaskIntoConstraints = false
        tfCorreo.translatesAutoresizingMaskIntoConstraints = false
        tfPass.translatesAutoresizingMaskIntoConstraints = false
        tfPass2.translatesAutoresizingMaskIntoConstraints = false
        
        
        //COnstrains del text field Nombre
        lbNombre.leftAnchor.constraint(equalTo: view.centerXAnchor, constant: -10).isActive = true
        lbNombre.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
        lbNombre.widthAnchor.constraint(equalToConstant: 172).isActive = true
        
        //Constrains del label Nombre
        tfNombre.leftAnchor.constraint(equalTo: lbNombre.leftAnchor, constant: -130).isActive = true
        tfNombre.topAnchor.constraint(equalTo: view.topAnchor, constant: 205).isActive = true
        
        //Constrain del text field Matricula
        lbMatricula.topAnchor.constraint(equalTo: lbNombre.bottomAnchor, constant: 20).isActive = true
        lbMatricula.leftAnchor.constraint(equalTo: view.centerXAnchor, constant: -10).isActive = true
        lbMatricula.widthAnchor.constraint(equalToConstant: 172).isActive = true
        
        //Constrain del text field Correo
        lbEmail.topAnchor.constraint(equalTo: lbMatricula.bottomAnchor, constant: 20).isActive = true
        lbEmail.leftAnchor.constraint(equalTo: view.centerXAnchor, constant: -10).isActive = true
        lbEmail.widthAnchor.constraint(equalToConstant: 172).isActive = true
        
        //Constrain del text field Password
        lbPassword.topAnchor.constraint(equalTo: lbEmail.bottomAnchor, constant: 20).isActive = true
        lbPassword.leftAnchor.constraint(equalTo: view.centerXAnchor, constant: -10).isActive = true
        lbPassword.widthAnchor.constraint(equalToConstant: 172).isActive = true
        
        //Constrain del text field Confirm password
        lbConfirmPassword.topAnchor.constraint(equalTo: lbPassword.bottomAnchor, constant: 20).isActive = true
        lbConfirmPassword.leftAnchor.constraint(equalTo: view.centerXAnchor, constant: -10).isActive = true
        lbConfirmPassword.widthAnchor.constraint(equalToConstant: 172).isActive = true
        
        //Constrains del laberl MAtricula
        tfMatricula.topAnchor.constraint(equalTo: tfNombre.bottomAnchor, constant: 35).isActive = true
        tfMatricula.leftAnchor.constraint(equalTo: lbMatricula.leftAnchor, constant: -130).isActive = true
        
        //Constrains del laberl Correo
        tfCorreo.topAnchor.constraint(equalTo: tfMatricula.bottomAnchor, constant: 35).isActive = true
        tfCorreo.leftAnchor.constraint(equalTo: lbEmail.leftAnchor, constant: -130).isActive = true
        
        //Constrains del laberl Password
        tfPass.topAnchor.constraint(equalTo: tfCorreo.bottomAnchor, constant: 35).isActive = true
        tfPass.leftAnchor.constraint(equalTo: lbPassword.leftAnchor, constant: -130).isActive = true
        
        //Constrains del laberl Password Conf
        tfPass2.topAnchor.constraint(equalTo: tfPass.bottomAnchor, constant: 18).isActive = true
        tfPass2.leftAnchor.constraint(equalTo: lbConfirmPassword.leftAnchor, constant: -130).isActive = true
        tfPass2.widthAnchor.constraint(equalToConstant: 154).isActive = true
        
        //Constrains del boton
        btSignUp.topAnchor.constraint(equalTo: view.centerYAnchor, constant: 150).isActive = true
        
        btSignUp.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        btSignUp.widthAnchor.constraint(equalToConstant: 150).isActive = true
        btSignUp.heightAnchor.constraint(equalToConstant: 70).isActive = true
//        btSignUp.layer.backgroundColor = UIColor.clear.cgColor
    }
    
    //------------------------------------------------------
    @IBAction func quitarTeclado(_ sender: Any) {
        view.endEditing(true)
    }

}
