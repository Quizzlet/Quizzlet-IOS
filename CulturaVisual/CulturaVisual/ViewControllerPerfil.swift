//
//  ViewControllerPerfil.swift
//  CulturaVisual
//
//  Created by Maggie Jimenez Herrera on 10/13/19.
//  Copyright © 2019 Maggie Jimenez Herrera. All rights reserved.
//

import UIKit

class ViewControllerPerfil: UIViewController {
    
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbMatricula: UILabel!
    
    var UserData: User!
    
    //------------------------------------------------------
    func dataFileUrl() -> URL {
        let url = FileManager().urls(
            for: .documentDirectory,
            in: .userDomainMask
        ).first!
        let pathArchivo = url.appendingPathComponent(
            "Quizzlet.plist"
        )
        return pathArchivo
    }

    //------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        lbName.text = UserData.strName
        lbMatricula.text = UserData.strMatricula
        // Do any additional setup after loading the view.
    }
    
    //------------------------------------------------------
    @IBAction func LogOut(_ sender: UIButton) {
        do {
            if FileManager.default.fileExists(atPath: dataFileUrl().path) {
                try FileManager.default.removeItem(atPath: dataFileUrl().path)
            }
        } catch {
            print(error)
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
