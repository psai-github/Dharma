//
//  getTypeOfUser.swift
//  Final HelperX
//
//  Created by Pranav Sai on 6/30/23.
//

import Foundation
import SwiftUI
import Firebase

func getUserData() async -> (String,String,String,String,Bool,String){
    do{
        
        let a = try await Firestore.firestore().collection("users").whereField("id", isEqualTo: UIDevice.current.identifierForVendor!.uuidString).getDocuments().documents
        if a.isEmpty{
            return ("","","","",false,"")
        }
        else{
            return ((a[0]["name"] as? String)!,(a[0]["account"] as? String)!,(a[0]["profile_pic"] as? String)!,(a[0]["phone_number"] as? String)!,(a[0]["verified"] as? Bool)!,(a[0]["zipcode"] as? String)!)
        }

    }
    catch{
        return ("","","","",false,"")
    }
}
