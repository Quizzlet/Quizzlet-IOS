//
//  ViewControllerTemas.swift
//  CulturaVisual
//
//  Created by Maggie Jimenez Herrera on 10/13/19.
//  Copyright © 2019 Maggie Jimenez Herrera. All rights reserved.
//

import UIKit

class ViewControllerTemas: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var listaTemas = ["Arquitectura", "Arte", "Diseño"]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Temas"
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaTemas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "celda", for: indexPath) as! TableViewCellCustom
        
        cell.lbTema.text = listaTemas[indexPath.row]
        cell.lbCont.text = "2/6"
        
        return cell
    }
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(100)
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vistaQuiz = segue.destination as! ViewControllerQuizzes
        let indexPath = tableView.indexPathForSelectedRow!
        
        vistaQuiz.quiz = listaTemas[indexPath.row]

        }

}
