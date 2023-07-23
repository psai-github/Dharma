//
//  editTaskData.swift
//  Volenteer
//
//  Created by Pranav Sai on 7/17/23.
//

import Foundation
import SwiftUI
import Firebase


func editTask(documentID:String,title:String,des:String) async{
    let db = Firestore.firestore()
    
    
    do{
//        if cat=="All Sports"{

            
        try await db.collection("jobs").document(documentID).updateData(["name":title,"des":des])
//        }
//        else{
//            var doc = try await db.collection(cat).whereField("url", isEqualTo: url).getDocuments().documents[0]
//
//
//            //        let x = db.collection("videos").document(doc.id).documentID
//            let a = doc["views"] as? Int
//
//            try await db.collection("videos").document(doc.documentID).updateData(["views":a!+1])
//        }
        
    }
    
    catch{
        print("Error")
        
    }
    
}
