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
    let userDefaults = UserDefaults.standard

    
    //------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
    }
    
    //------------------------------------------------------
    override func viewWillAppear(_ animated: Bool) {
         self.navigationController?.isNavigationBarHidden = true
    }
    
    //------------------------------------------------------
    @IBAction func onLogin(_ sender: UIButton) {
        if let strEmail = lbEmail.text,
            let strPassword = lbPassword.text {
            
            UserAPI.shared.Login(
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
                case .success(let user):
                    print(user)
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
