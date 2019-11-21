//
//  Question.swift
//  CulturaVisual
//
//  Created by Angel Trevino on 21/11/19.
//  Copyright © 2019 Maggie Jimenez Herrera. All rights reserved.
//

import UIKit

class Question: Codable {
    var _id: String;
    var strIdCreator: String;
    var strQuestionDesc: String;
    var strCorrect: Int;
    var strOptions: [String] = []
}
