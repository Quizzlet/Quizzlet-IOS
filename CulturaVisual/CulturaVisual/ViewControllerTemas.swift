//
//  ViewControllerTemas.swift
//  CulturaVisual
//
//  Created by Maggie Jimenez Herrera on 10/13/19.
//  Copyright © 2019 Maggie Jimenez Herrera. All rights reserved.
//

import UIKit

class ViewControllerTemas: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var GroupDetails: GroupDetails!
    var Group: Group!
    var UserData: User!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lbTemas: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        lbTemas.text = Group.strName
        GetGroupDetails()
    }
    
    // MARK: - Petitions
    //------------------------------------------------------
    func GetGroupDetails() {
        GroupsAPI.shared.GetGroupDetails(
            strId: Group._id,
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
                self.GroupDetails = res
                self.tableView.reloadData()
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
    
    // MARK: - Table Methods
    //------------------------------------------------------
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(GroupDetails == nil) {
            return 0;
        } else {
            return GroupDetails.strSubjects.count
        }
    }
    //------------------------------------------------------
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "celda", for: indexPath) as! TableViewCellCustom
        
        cell.lbTema.text = GroupDetails.strSubjects[indexPath.row].strName
        cell.lbCont.text = "\( GroupDetails.strSubjects[indexPath.row].intCompleted / 100)"
        
        return cell
    }
    //------------------------------------------------------
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(100)
    }
    
    // MARK: - Navigation
    //------------------------------------------------------
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vistaQuiz = segue.destination as! ViewControllerQuizzes
        let indexPath = tableView.indexPathForSelectedRow!
        
        vistaQuiz.Subject = GroupDetails.strSubjects[indexPath.row]
        vistaQuiz.UserData = UserData
        vistaQuiz.strIdGroup = GroupDetails._id
    }

    //MARK: - Layout
    //------------------------------------------------------
    func setupLayout() {
        
        lbTemas.translatesAutoresizingMaskIntoConstraints = false
    tableView.translatesAutoresizingMaskIntoConstraints = false
        
        //Constrains del label Temas
        lbTemas.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        lbTemas.topAnchor.constraint(equalTo: view.topAnchor, constant: 170).isActive = true
        
        //Constraions del table view
        tableView.topAnchor.constraint(equalTo: lbTemas.bottomAnchor, constant: 80).isActive = true
        tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tableView.widthAnchor.constraint(equalToConstant: 343).isActive = true
    tableView.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }
}
