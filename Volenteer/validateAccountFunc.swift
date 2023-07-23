//
//  validateAccountFunc.swift
//  Final HelperX
//
//  Created by Pranav Sai on 6/30/23.
//

import Foundation
import Firebase
func validUsername(username:String) async -> Bool{
    do{
        let a = try await Firestore.firestore().collection("users").whereField("name", isEqualTo: username).getDocuments().documents
        if a.endIndex==0{
            return true
        }
        else{
            return false
        }
    }
    catch{
        return true
    }
    
}
