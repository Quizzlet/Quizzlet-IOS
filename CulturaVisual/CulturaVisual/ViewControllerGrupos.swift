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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: - Table Methods
    //------------------------------------------------------
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    //------------------------------------------------------
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celda", for: indexPath)
        cell.textLabel?.text = "hello"
        return cell
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
        }
    }
}
