//
//  ViewControllerLogin.swift
//  CulturaVisual
//
//  Created by Maggie Jimenez Herrera on 10/13/19.
//  Copyright © 2019 Maggie Jimenez Herrera. All rights reserved.
//

import UIKit

class ViewControllerLogin: UIViewController {
        
    @IBOutlet weak var lbEmail: UITextField!
    @IBOutlet weak var lbPassword: UITextField!
    @IBOutlet weak var lbLoging: UILabel!
    @IBOutlet weak var lbContra: UILabel!
    @IBOutlet weak var lbCorreo: UILabel!
    @IBOutlet weak var btLogIn: UIButton!
    @IBOutlet weak var btSignUp: UIButton!
    
    var UserData: User!
    
    //------------------------------------------------------
    func dataFileUrl() -> URL {
        let url = FileManager().urls(
            for: .documentDirectory,
            in: .userDomainMask
        ).first!
        let pathArchivo = url.appendingPathComponent(
            "Quizzlet.plist"
        )
        return pathArchivo
    }

    
    //------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLayout()
        getUser()
        if(UserData != nil) {
            performSegue(withIdentifier: "Success", sender: nil)
        }
    }
    
    //------------------------------------------------------
    override func viewWillAppear(_ animated: Bool) {
         self.navigationController?.isNavigationBarHidden = true
    }
    
    //------------------------------------------------------
    @IBAction func onLogin(_ sender: UIButton) {
        if let strEmail = lbEmail.text,
            let strPassword = lbPassword.text {
            if(strEmail != "" && strPassword != "") {
                UserAPI.shared.Login(
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
                            ErrorMessage = err.localizedDescription;
                        }
                        
                        self.showAlert(
                            strType: "Error",
                            strCode: ErrorCode,
                            strMessage: ErrorMessage
                        )
                        
                    case .success(let user):
                        self.UserData = user
                        self.saveUserData()
                        self.performSegue(
                            withIdentifier: "Success",
                            sender: nil
                        )
                    }
                }

            } else {
                showAlert(
                    strType: "Error",
                    strCode: "",
                    strMessage: "Ingresa todos los datos solicitados"
                )
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
            title: strType + " " + strCode,
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
    
    //MARK: - Persistance
    //------------------------------------------------------
    func saveUserData() {
        do {
            let data = try PropertyListEncoder().encode(UserData)
           try data.write(to: dataFileUrl())
        }
        catch {
           print("Save Failed")
        }
    }
    //------------------------------------------------------
    func getUser() {
        do {
            let data = try Data.init(contentsOf: dataFileUrl())
            UserData = try PropertyListDecoder().decode(User.self, from: data)
        }
        catch {
            print("Error reading or decoding file")
        }
    }
    
    //MARK: - Navigation
    //------------------------------------------------------
    override func shouldPerformSegue(
        withIdentifier identifier: String,
        sender: Any?
    ) -> Bool {
        if(identifier == "Success") {
            if(UserData == nil) {
                return false;
            } else {
                return true;
            }
        }
        return true;
    }
    
    //MARK: - Constrains
    //------------------------------------------------------
    func setUpLayout() {
        //This enables autolayout
        lbLoging.translatesAutoresizingMaskIntoConstraints = false
        lbEmail.translatesAutoresizingMaskIntoConstraints = false
        lbPassword.translatesAutoresizingMaskIntoConstraints = false
        lbContra.translatesAutoresizingMaskIntoConstraints = false
        lbContra.translatesAutoresizingMaskIntoConstraints = false
        btSignUp.translatesAutoresizingMaskIntoConstraints = false
        btLogIn.translatesAutoresizingMaskIntoConstraints = false
        
        // Contrains del label Login
        lbLoging.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        lbLoging.centerYAnchor.constraint(equalTo: view.topAnchor, constant: 170).isActive = true
//        lbLoging.widthAnchor.constraint(equalToConstant: 100).isActive = true
//      lbLoging.heightAnchor.constraint(equalToConstant: 50).isActive = true
       
        // Contrains del texf field Email
        lbEmail.widthAnchor.constraint(equalToConstant: 140).isActive = true
        lbEmail.topAnchor.constraint(equalTo: lbLoging.bottomAnchor, constant: 125).isActive = true
        lbEmail.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 160).isActive = true
        
        // Contrains del text field Password
        lbPassword.widthAnchor.constraint(equalToConstant: 140).isActive = true
        lbPassword.topAnchor.constraint(equalTo: lbEmail.bottomAnchor, constant: 25).isActive = true
        lbPassword.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 160).isActive = true
        
        // Constrains del label Correo
        lbCorreo.topAnchor.constraint(equalTo: lbLoging.bottomAnchor, constant: 128).isActive = true
        lbCorreo.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 100).isActive = true
        
        // Constrains del label Contraseña
        lbContra.topAnchor.constraint(equalTo: lbCorreo.bottomAnchor, constant: 40).isActive = true
        lbContra.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50).isActive = true
        
        //Contrains del boton LogIn
        btLogIn.topAnchor.constraint(equalTo: lbPassword.bottomAnchor, constant: 90).isActive = true
        btLogIn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        btLogIn.widthAnchor.constraint(equalToConstant: 100).isActive = true
        btLogIn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        //Constrains del boton SignUp
        btSignUp.topAnchor.constraint(equalTo: btLogIn.bottomAnchor, constant: 30).isActive = true
        btSignUp.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        btSignUp.widthAnchor.constraint(equalToConstant: 100).isActive = true
        btSignUp.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
    @IBAction func quitarTeclado(_ sender: Any) {
        view.endEditing(true)
    }

}
