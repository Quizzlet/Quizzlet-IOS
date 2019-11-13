//
//  QuizzletAPI.swift
//  CulturaVisual
//
//  Created by Angel Trevino on 14/10/19.
//  Copyright © 2019 Maggie Jimenez Herrera. All rights reserved.
//

import UIKit

//==========================================================
class UserAPI: NSObject {
    
    static let shared = UserAPI()
    
    public static var BaseURL =
        "https://quizzlet.herokuapp.com/api/users";
    
    //MARK: - Login
    //------------------------------------------------------
    func Login(
        //Data to send
        strEmail: String,
        strPassword: String,
        //If the request has been completed
        completion: @escaping (Result<User, Error>) -> ()
    ) {
        //Make the url
        guard let url = URL(
            string: UserAPI.BaseURL + "/LogIn"
        ) else { return }
        
        //Settings for the post
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue(
            "application/json",
            forHTTPHeaderField: "content-type"
        )
        
        //Directory for our information to send
        let loginCredentials = [
            "strEmail": strEmail,
            "strPassword": strPassword
        ]
        
        do {
            //Transform data to send into a json object
            let data = try JSONSerialization.data(
                withJSONObject: loginCredentials,
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
                    
                    //Decode Error Messege
                    if let httpResponse = resp as?
                        HTTPURLResponse {
                        
                        if(httpResponse.statusCode != 200) {
                            do {
                                let json = try
                                    JSONSerialization.jsonObject(
                                        with: data,
                                        options: []
                                    ) as? [String : Any]
                                
                                let err =  NSError(
                                    domain:"",
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
                        let user = try JSONDecoder().decode(
                            User.self,
                            from: data
                        )
                        completion(.success(user))

                    }catch {
                        //Error if we cannot conver from json of user
                        completion(.failure(error))
                    }
                }
            }.resume()
            
        } catch {
            //Error if we cannot conver the data to send
            completion(.failure(error))
        }
    }
    
    //MARK: - Singup
    //------------------------------------------------------
    func Singup(
        //Data to send
        strMatricula: String,
        strName: String,
        strEmail: String,
        strPassword: String,
        //If the request has been completed
        completion: @escaping (Result<String, Error>) -> ()
    ){
        //Make the url
        guard let url = URL(
            string: UserAPI.BaseURL + "/SingUp"
        ) else { return }
        
        //Settings for the post
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue(
            "application/json",
            forHTTPHeaderField: "content-type"
        )
        
        //Directory for our information to send
        let loginCredentials = [
            "strMatricula": strMatricula,
            "strName": strName,
            "strEmail": strEmail,
            "strPassword": strPassword
        ]
        
        do {
            //Transform data to send into a json object
            let data = try JSONSerialization.data(
                withJSONObject: loginCredentials,
                options: .init()
            )
            urlRequest.httpBody = data
            
            //make the request
            URLSession.shared.dataTask(with: urlRequest) {
                (data, resp, error) in
                
                DispatchQueue.main.async {
                    //check if there is an error
                    if let error = error {
                        completion(.failure(error))
                        return
                    }
                    
                    //check if there is data in there
                    guard let data = data else { return }
                    
                    //Decode Error Messege
                    if let httpResponse = resp as?
                        HTTPURLResponse {
                        
                        if(httpResponse.statusCode != 200) {
                            do {
                                let json = try
                                    JSONSerialization.jsonObject(
                                        with: data,
                                        options: []
                                    ) as? [String : Any]
                                
                                let err =  NSError(
                                    domain:"",
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
                    
                    //Decode Success Message
                    do{
                        let message = try
                        JSONSerialization.jsonObject(
                            with: data,
                            options: []
                        ) as? [String: Any]
                        let strMessage =
                            message!["message"] as! String
                        completion(.success(strMessage))
                    }catch{
                        completion(.failure(error))
                    }
                }
            }.resume()
            
        } catch {
            completion(.failure(error));
        }
        
    }

}
//==========================================================
