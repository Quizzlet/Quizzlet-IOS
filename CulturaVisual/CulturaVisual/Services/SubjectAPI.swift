//
//  SubjectAPI.swift
//  CulturaVisual
//
//  Created by Angel Trevino on 21/11/19.
//  Copyright © 2019 Maggie Jimenez Herrera. All rights reserved.
//

import UIKit

//==========================================================
class SubjectAPI: NSObject {
    
    static let shared = SubjectAPI()
    
    public static var BaseURL =
        "https://quizzlet.herokuapp.com/api/subjects";
    
    //  MARK: - Get Details of a subject
    //------------------------------------------------------
    func GetSubjectDetails(
        //Data to send
        strId: String,
        user: User,
        //If the request has been completed
        completion: @escaping (Result<SubjectDetails, Error>) -> ()
    ) {
        //Get the token
        let token: String = user.token
        
        //Make the url
        guard let url = URL(
            string: SubjectAPI.BaseURL + "/" + strId
            ) else { return }
        
        //Settings for the GET
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue(
            "application/json",
            forHTTPHeaderField: "content-type"
        )
        
        //Add Token
        urlRequest.addValue(
            "Bearer " + token,
            forHTTPHeaderField: "Authorization"
        )
        
        URLSession.shared.dataTask(with: urlRequest) {
            (data, resp, error) in
            
            DispatchQueue.main.async {
                //check if there is an error connecting
                if error != nil {
                    completion(.failure(error!))
                    return
                }
                
                //check if there is a data in there
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
                                ) as? [String : Any]
                            
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
                    let subjectDetails = try JSONDecoder().decode(
                        SubjectDetails.self,
                        from: data
                    )
                    completion(.success(subjectDetails))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
        
    }
}
//==========================================================
