//
//  GroupsAPI.swift
//  CulturaVisual
//
//  Created by Angel Trevino on 20/11/19.
//  Copyright © 2019 Maggie Jimenez Herrera. All rights reserved.
//

import UIKit

//==========================================================
class GroupsAPI: NSObject {
    
    static let shared = GroupsAPI()
    
    public static var BaseURL =
        "https://quizzlet.herokuapp.com/api/groups";
    
    //MARK: - Join Group
    //------------------------------------------------------
    func JoinGroup(
        //Data to send
        strGrpKey: String,
        //If the request has been completed
        completion: @escaping (Result<String, Error>) -> ()
    ) {
        
    }
}
//==========================================================
