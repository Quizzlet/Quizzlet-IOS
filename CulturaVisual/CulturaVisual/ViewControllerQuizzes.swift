//
//  ViewControllerQuizzes.swift
//  CulturaVisual
//
//  Created by Maggie Jimenez Herrera on 10/13/19.
//  Copyright © 2019 Maggie Jimenez Herrera. All rights reserved.
//

import UIKit

class ViewControllerQuizzes: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var lbQuiz: UILabel!
    var quiz : String!
    
    var listaQuiz
    = ["Quiz 1", "Quiz 2", "Quiz 3", "Quiz 4"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
