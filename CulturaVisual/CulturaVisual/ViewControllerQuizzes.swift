//
//  ViewControllerQuizzes.swift
//  CulturaVisual
//
//  Created by Maggie Jimenez Herrera on 10/13/19.
//  Copyright © 2019 Maggie Jimenez Herrera. All rights reserved.
//

import UIKit

class ViewControllerQuizzes: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var UserData: User!
    var Subject: Subject!
    var SubjectDetails: SubjectDetails!
    var strIdGroup: String!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lbQuiz: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLayout()
        lbQuiz.text = Subject.strName
        GetSubjectDetails()
        print("subject", Subject._id)
        print("group", strIdGroup)

    }
    
    // MARK: - Petitions
    //------------------------------------------------------
    func GetSubjectDetails() {
        SubjectAPI.shared.GetSubjectDetails(
            strId: Subject._id,
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
                self.SubjectDetails = res
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
    
    // MARK: - Table Functions
    //------------------------------------------------------
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(SubjectDetails == nil) {
            return 0
        } else {
            return SubjectDetails.arrQuizzes.count
        }
    }
    //------------------------------------------------------
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celda", for: indexPath)
        cell.textLabel?.text = SubjectDetails.arrQuizzes[indexPath.row].strName
        return cell
    }
    //------------------------------------------------------
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(70)
    }
    
    //MARK:- Constrains
    //------------------------------------------------------
    func setUpLayout(){
        lbQuiz.translatesAutoresizingMaskIntoConstraints = false
    tableView.translatesAutoresizingMaskIntoConstraints = false
        
        //Constrains del label Quiz
        lbQuiz.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        lbQuiz.topAnchor.constraint(equalTo: view.topAnchor, constant: 170).isActive = true
        
        //Constrains del tableView
        tableView.topAnchor.constraint(equalTo: lbQuiz.bottomAnchor, constant: 80).isActive = true
        tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tableView.widthAnchor.constraint(equalToConstant: 343).isActive = true
        tableView.heightAnchor.constraint(equalToConstant: 280).isActive = true
        
    }

}
