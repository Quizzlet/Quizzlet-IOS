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
        user: User,
        //If the request has been completed
        completion: @escaping (Result<String, Error>) -> ()
    ) {
        //Get the token
        let token: String = user.token
        //Make the url
        guard let url = URL(
            string: GroupsAPI.BaseURL + "/join"
        ) else { return }
        
        //Setings for the PUT
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "PUT"
        urlRequest.setValue(
            "application/json",
            forHTTPHeaderField: "content-type"
        )
        //Add Token
        urlRequest.addValue(
            "Bearer " + token,
            forHTTPHeaderField: "Authorization"
        )
        
        //Making directory with the data to send
        let dataToSend = [
            "strGrpKey": strGrpKey
        ]
        
        do {
            //Transform data to send into a json object
            let data = try JSONSerialization.data(
                withJSONObject: dataToSend,
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
    
    //MARK: - Get My Groups
    //------------------------------------------------------
    func GetMyGroups(
        //Data to send
        user: User,
        //If the request has been completed
        completion: @escaping (Result<[Group], Error>) -> ()
    ) {
        //Get the token
        let token: String = user.token
        
        //Make the url
        guard let url = URL(
            string: GroupsAPI.BaseURL + "/Mine"
            ) else { return }
        
        //Settings for the GET
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue(
            "application/json",
            forHTTPHeaderField: "content-typ"
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
                    let groups = try JSONDecoder().decode(
                        [Group].self,
                        from: data
                    )
                    completion(.success(groups))
                }catch {
                    //Error if we cannot convert from json of Group
                    completion(.failure(error))
                }
            }
            
        }.resume()
    }
    
    //MARK: - Get a Group Details
    //------------------------------------------------------
    func GetGroupDetails(
        //Data to send
        strId: String,
        user: User,
        //If the request has been completed
        completion: @escaping (Result<GroupDetails, Error>) -> ()
    ) {
        //Get the token
        let token: String = user.token
        
        //Make the url
        guard let url = URL(
            string: GroupsAPI.BaseURL + "/" + strId
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
                    let groupDetails = try JSONDecoder().decode(
                        GroupDetails.self,
                        from: data
                    )
                    completion(.success(groupDetails))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
}
//==========================================================
