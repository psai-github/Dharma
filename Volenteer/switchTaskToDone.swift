//
//  switchTaskToDone.swift
//  Volenteer
//
//  Created by Pranav Sai on 7/21/23.
//

import Foundation
import Foundation
import SwiftUI
import Firebase


func makeAcceptDone(documentID:String,comment:String,rate:String) async{
    let db = Firestore.firestore()
    
    
    do{
//        if cat=="All Sports"{

            
        try await db.collection("accepts").document(documentID).updateData(["done":true,"comment":comment,"rate":rate])
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
func makeATaskPending(documentID:String) async{
    let db = Firestore.firestore()
    
    
    do{
//        if cat=="All Sports"{

            
        try await db.collection("jobs").document(documentID).updateData(["status":"pending"])
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
func makeTaskDone(documentID:String) async{
    let db = Firestore.firestore()
    
    
    do{
//        if cat=="All Sports"{

            
        try await db.collection("jobs").document(documentID).updateData(["status":"done"])
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
