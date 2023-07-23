//
//  getUserWithDeviceId.swift
//  Final HelperX
//
//  Created by Pranav Sai on 6/30/23.
//

import Foundation
import Firebase
import SwiftUI


func getUserWithDeviceId() async -> String {
    
    let db = Firestore.firestore()
    
    do{
        var doc =  try await db.collection("users").whereField("id", isEqualTo: UIDevice.current.identifierForVendor!.uuidString).getDocuments()
        print(doc.documents)
        if (doc.documents.isEmpty) == true{
            return ""
        }
        else{
            var a = (doc.documents[0]["name"] as? String)!
            
            print(a)
            return a
            
        }
    }
    catch{
            print("Error")
            return ""
    }
    
}
