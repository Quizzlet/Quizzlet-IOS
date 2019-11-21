//
//  ViewControllerGrupos.swift
//  CulturaVisual
//
//  Created by Angel Trevino on 20/11/19.
//  Copyright © 2019 Maggie Jimenez Herrera. All rights reserved.
//

import UIKit

class ViewControllerGrupos:
    UIViewController,
    UITableViewDelegate,
    UITableViewDataSource,
    UIPopoverPresentationControllerDelegate {
    
    var UserData: User!
    var Groups: [Group] = []

    @IBOutlet weak var btAgregar: UIButton!
    @IBOutlet weak var lbGrupos: UILabel!
    @IBOutlet weak var TVGroups: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GetGroups()
        setLayout()
    }
    
    //MARK: - Petitions
    //------------------------------------------------------
    func GetGroups() {
        GroupsAPI.shared.GetMyGroups(
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
                } else {
                    ErrorMessage = err.localizedDescription
                }
                
                self.showAlert(
                    strType: "Error",
                    strCode: ErrorCode,
                    strMessage: ErrorMessage
                )
            case .success(let res):
                self.Groups = res
                self.TVGroups.reloadData()
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
    
    //MARK: - Table Methods
    //------------------------------------------------------
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Groups.count
    }
    //------------------------------------------------------
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celda", for: indexPath)
        cell.textLabel?.text = Groups[indexPath.row].strName
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(70)
    }
    
    // MARK: - PopOver
    //------------------------------------------------------
    func adaptivePresentationStyle(
           for controller: UIPresentationController
       ) -> UIModalPresentationStyle {
           return .none
    }
    
    // MARK: - Navigation
    //------------------------------------------------------
    override func prepare(
        for segue: UIStoryboardSegue,
        sender: Any?
    ) {
        if(segue.identifier == "PopUp") {
            let vistaPopOver = segue.destination as! ViewControllerPop
            vistaPopOver.popoverPresentationController?.delegate = self
            vistaPopOver.UserData = UserData
        } else if(segue.identifier == "Temas") {
            let indexPath = TVGroups.indexPathForSelectedRow!
            let ViewTemas = segue.destination as! ViewControllerTemas
            ViewTemas.Group = Groups[indexPath.row]
            ViewTemas.UserData = UserData
        }
    }
    //MARK:- Constrains
    //====================================
    
    func setLayout(){
        //Habilitar los constrains
        lbGrupos.translatesAutoresizingMaskIntoConstraints = false
        TVGroups.translatesAutoresizingMaskIntoConstraints = false
        btAgregar.translatesAutoresizingMaskIntoConstraints = false
        
        
        //Constrains del label Grupos
        lbGrupos.centerYAnchor.constraint(equalTo: view.topAnchor, constant: 170).isActive = true
        lbGrupos.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        //Constrains del table view
        
        TVGroups.topAnchor.constraint(equalTo: lbGrupos.bottomAnchor, constant: 80).isActive = true
        TVGroups.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        TVGroups.widthAnchor.constraint(equalToConstant: 343).isActive = true
        TVGroups.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        //Constrains del boton Agregar
        
        btAgregar.topAnchor.constraint(equalTo: TVGroups.bottomAnchor, constant: 50).isActive = true
        btAgregar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        btAgregar.widthAnchor.constraint(equalToConstant: 150).isActive = true
        btAgregar.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
    }
}
