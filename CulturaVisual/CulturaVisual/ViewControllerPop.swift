//
//  ViewControllerPop.swift
//  CulturaVisual
//
//  Created by Angel Trevino on 20/11/19.
//  Copyright © 2019 Maggie Jimenez Herrera. All rights reserved.
//

import UIKit

class ViewControllerPop: UIViewController {
    
    @IBOutlet weak var tfGroup: UITextField!
    
    var UserData: User!

    //------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        preferredContentSize = CGSize(
            width: 250,
            height: 200
        )
    }
    
    //------------------------------------------------------
    @IBAction func AddGroup(_ sender: UIButton) {
        if let strGroup = tfGroup.text {
            if strGroup == "" {
                showAlert(
                    strType: "Error",
                    strCode: "",
                    strMessage: "Ingresa algun grupo"
                )
            } else {
                GroupsAPI.shared.JoinGroup(
                    strGrpKey: strGroup,
                    user: UserData
                ) { (res) in
                    switch res {
                    case .failure(let err as NSError):
                        var ErrorCode: String = "";
                        var ErrorMessage: String = "";
                        if(
                            //Client error
                            err.code >= 400 &&
                            err.code < 600
                            ) {
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
            title: "Ok",
            style: .cancel,
            handler: nil
        )
        
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    //------------------------------------------------------
    @IBAction func popoverPresentationControllerDidDismissPopover(
        popoverPresentationController: UIPopoverPresentationController
    ) {
        dismiss(animated: true, completion: nil)
    }

}
