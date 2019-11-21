//
//  GradesAPI.swift
//  CulturaVisual
//
//  Created by Angel Trevino on 21/11/19.
//  Copyright © 2019 Maggie Jimenez Herrera. All rights reserved.
//

import UIKit

//==========================================================
class GradesAPI: NSObject {
    
    static let shared = GradesAPI()
    
    public static var BaseURL =
        "https://quizzlet.herokuapp.com/api/grades";
    
    // MARK: - Post a grade
    //------------------------------------------------------
    func postGrade(
        //Data to send
        strIdGroup: String,
        strIdSubject: String,
        strIdQuiz: String,
        intGrade: String,
        user: User,
        //If the request has been completed
        completion: @escaping (Result<[Grade], Error>) -> ()
    ) {
        //Get the token
        let token: String = user.token
        
        //Make the url
        guard let url = URL(
            string: GradesAPI.BaseURL + "/addGrades"
         ) else { return }
        
        //Settings for the post
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue(
            "application/json",
            forHTTPHeaderField: "content-type"
        )
        
        //Add Token
        urlRequest.addValue(
            "Bearer " + token,
            forHTTPHeaderField: "Authorization"
        )
        
        //Directiory for our information to send
        let gradeInfo = [
            "strIdGroup": strIdGroup,
            "strIdSubject": strIdSubject,
            "strIdQuiz": strIdQuiz,
            "intGrade": intGrade
        ]
        
        do {
            //Transform data to send into a json object
            let data = try JSONSerialization.data(
                withJSONObject: gradeInfo,
                options: .init()
            )
            urlRequest.httpBody = data
            
            //make the request
            URLSession.shared.dataTask(with: urlRequest) {
                (data, resp, error) in
                
                DispatchQueue.main.async {
                    //check if there is an error connecting
                    if error != nil {
                        completion(.failure(error!))
                        return
                    }
                    
                    //check if there is data in there
                    guard let data = data else { return }
                    
                    //Decode Error Message
                    if let httpResponse = resp as?
                        HTTPURLResponse {
                        
                        if(httpResponse.statusCode != 200) {
                            do {
                                let json = try
                                    JSONSerialization.jsonObject(
                                        with: data,
                                        options: []
                                    ) as? [String: Any]
                                
                                let err = NSError(
                                    domain: "",
                                    code: httpResponse.statusCode,
                                    userInfo: json
                                )
                                completion(.failure(err))
                                return
                            } catch {
                                completion(.failure(error))
                            }
                        }
                    }
                    
                    do {
                        //Decode the data recieved
                        let grades = try JSONDecoder().decode(
                            [Grade].self,
                            from: data
                        )
                        completion(.success(grades))
                    } catch {
                        //Error if we cannot convert to grades [] from json
                        completion(.failure(error))
                    }
                }
            }.resume()
            
        } catch {
            completion(.failure(error))
        }
    }
}
//==========================================================
