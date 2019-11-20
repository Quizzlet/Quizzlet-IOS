//
//  ViewControllerPop.swift
//  CulturaVisual
//
//  Created by Angel Trevino on 20/11/19.
//  Copyright © 2019 Maggie Jimenez Herrera. All rights reserved.
//

import UIKit

class ViewControllerPop: UIViewController {

    //------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        preferredContentSize = CGSize(
            width: 250,
            height: 200
        )
    }
    
    // MARK: - Navigation
    //------------------------------------------------------
    override func prepare(
        for segue: UIStoryboardSegue,
        sender: Any?
    ) {
        
    }
    //------------------------------------------------------
    @IBAction func popoverPresentationControllerDidDismissPopover(
        popoverPresentationController: UIPopoverPresentationController
    ) {
        dismiss(animated: true, completion: nil)
    }

}
