//
//  getAllZipcodesInDB.swift
//  Volenteer
//
//  Created by Pranav Sai on 7/28/23.
//

import Foundation
import Firebase


func getAllZipcodes() async -> Array<String>{
    
    do{
        var list:Array<String> = []
        for i in (try await Firestore.firestore().collection("users").getDocuments().documents){
            if list.contains((i["zipcode"] as? String ?? "")){
                print(" ")
            }
            else{
                list.insert(i["zipcode"] as? String ?? "", at: list.endIndex)
            }
        }
        return list
    }
    catch{
        print("Error")
        return []
    }
}
