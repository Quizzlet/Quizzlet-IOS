//
//  ViewControllerSingUp.swift
//  CulturaVisual
//
//  Created by Angel Trevino on 14/10/19.
//  Copyright © 2019 Maggie Jimenez Herrera. All rights reserved.
//

import UIKit

class ViewControllerSingUp: UIViewController {

    @IBOutlet weak var lbNombre: UITextField!
    @IBOutlet weak var lbMatricula: UITextField!
    @IBOutlet weak var lbEmail: UITextField!
    @IBOutlet weak var lbPassword: UITextField!
    @IBOutlet weak var lbConfirmPassword: UITextField!
    
    //------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad();
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
            
            UserAPI.shared.Singup(
                strMatricula: strMatricula,
                strName: strName,
                strEmail: strEmail,
                strPassword: strPassword
            ) { (res) in
                switch res {
                case .failure(let err as NSError):
                    if(
                        //Client error
                        err.code >= 400 &&
                        err.code < 600
                        ){
                     print(err.code, err.userInfo["message"]! )
                    } else {
                        print(err.localizedDescription)
                    }
                case .success(let res):
                    print(res)
                }
            }
            
        }
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
