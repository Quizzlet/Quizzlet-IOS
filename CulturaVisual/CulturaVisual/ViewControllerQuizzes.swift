//
//  ViewControllerQuizzes.swift
//  CulturaVisual
//
//  Created by Maggie Jimenez Herrera on 10/13/19.
//  Copyright © 2019 Maggie Jimenez Herrera. All rights reserved.
//

import UIKit

class ViewControllerQuizzes: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lbQuiz: UILabel!
    var quiz : String!
    
    var listaQuiz
    = ["Quiz 1", "Quiz 2", "Quiz 3", "Quiz 4"]
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLayout()
        
        lbQuiz.text = quiz
        title = "Quizzes"

        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaQuiz.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celda", for: indexPath)
        
        cell.textLabel?.text = listaQuiz[indexPath.row]
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(70)
    }
    
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
