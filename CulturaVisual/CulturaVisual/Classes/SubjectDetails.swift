//
//  SubjectDetails.swift
//  CulturaVisual
//
//  Created by Angel Trevino on 21/11/19.
//  Copyright © 2019 Maggie Jimenez Herrera. All rights reserved.
//

import UIKit

class SubjectDetails: Codable {
    var _id: String;
    var strName: String;
    var arrQuizzes: [Quiz];
}
