//
//  getAllAcceptTaskData.swift
//  Volenteer
//
//  Created by Pranav Sai on 7/21/23.
//

import Foundation
import SwiftUI

import Foundation
import SwiftUI
import Firebase
import FirebaseStorage


struct AcceptStruct: Identifiable , Hashable{
    let id: String
    let name: String
    let helper:String
    let des : String
    let helped: String
    let hours:String
    let date:String
    let done:Bool
    let phonenumber:String



}

class AcceptModel: ObservableObject {
    
    @Published var accepts = [AcceptStruct]()
    //    @State var url = "hi"
    
    
    
    func deleteData(InboxStructToDelete: InboxStruct) {
        
        // Get a reference to the database
        let db = Firestore.firestore()
        
        // Specify the document to delete
        db.collection("accepts").document(InboxStructToDelete.id).delete { error in
            
            // Check for errors
            if error == nil {
                // No errors
                
                // Update the UI from the main thread
                DispatchQueue.main.async {
                    
                    // Remove the InboxStruct that was just deleted
                    self.accepts.removeAll { InboxStruct in
                        
                        // Check for the InboxStruct to remove
                        return InboxStruct.id == InboxStructToDelete.id
                    }
                }
                
                
            }
        }
        self.getData()
        
        
    }
    
    
    func getData(){
        
        // Get a reference to the database
        let db = Firestore.firestore()
        var url1 = "hi"
        //        let profile_pic = await getimageUrl(ref: Storage.storage().reference().child("profile").child(+".png"))
        // Read the documents at a specific path
        if typeOfUser == "Volunteer"{
            db.collection("accepts").whereField("helper", isEqualTo: username).getDocuments { snapshot, error in
                
                // Check for errors
                if error == nil {
                    // No errors
                    
                    if let snapshot = snapshot {
                        
                        // Update the list property in the main thread
                        //                    DispatchQueue.main.async {
                        
                        
                        
                        // Get all the documents and create msg
                        self.accepts = snapshot.documents.map { d in
                            //                            DispatchQueue.main.async {
                            //
                            //
                            //
                            //                                //                                    url1 = "https://firebasestorage.googleapis.com:443/"+url!.path
                            //
                            //                            }
                            
                            //                            var a = await getProfileUrl(username: d["creator"] as? String ?? "" )
                            //                            print("Stuff")
                            
                            //                            var name = (d["creator"] as? String ?? "")!
                            // Create a InboxStruct item for each document returned
                            
                            return AcceptStruct(id: d.documentID, name: d["name"] as? String ?? "", helper: d["helper"] as? String ?? "", des: d["des"] as? String ?? "", helped: d["helped"] as? String ?? "", hours: d["hours"] as? String ?? "", date: d["date"] as? String ?? "", done: d["done"] as? Bool ?? false,phonenumber:d["helped_contact"] as? String ?? "" )
                            
                            
                            
                            
                            
                            
                            
                        }
                        //print(self.list)
                        
                        
                        ////
                    }
                    
                }
                //                }
            }
            
        }
        else{
            db.collection("accepts").whereField("helped", isEqualTo: username).getDocuments { snapshot, error in
                
                // Check for errors
                if error == nil {
                    // No errors
                    
                    if let snapshot = snapshot {
                        
                        // Update the list property in the main thread
                        //                    DispatchQueue.main.async {
                        
                        
                        
                        // Get all the documents and create msg
                        self.accepts = snapshot.documents.map { d in
                            //                            DispatchQueue.main.async {
                            //
                            //
                            //
                            //                                //                                    url1 = "https://firebasestorage.googleapis.com:443/"+url!.path
                            //
                            //                            }
                            
                            //                            var a = await getProfileUrl(username: d["creator"] as? String ?? "" )
                            //                            print("Stuff")
                            
                            //                            var name = (d["creator"] as? String ?? "")!
                            // Create a InboxStruct item for each document returned
                            
                            return AcceptStruct(id: d.documentID, name: d["name"] as? String ?? "", helper: d["helper"] as? String ?? "", des: d["des"] as? String ?? "", helped: d["helped"] as? String ?? "", hours: d["hours"] as? String ?? "", date: d["date"] as? String ?? "", done: d["done"] as? Bool ?? false,phonenumber:  myphonenumber)
                            
                            
                            
                            
                            
                            
                            
                        }
                        //print(self.list)
                        
                        
                        ////
                    }
                    
                }
            }
            //            else {
            //                // Handle the error
            //            }
        }
        
    }
    
    
    
    
    
    // Create the document in Firestore
    
    //
    //func createUser(name:String,des: String,creator:String,date:String,posted:String) {
    //
    //
    //        let docData: [String: Any] = [
    //            "name":name,
    //            "des": des,
    //            "creator":creator,
    //            "date":date,
    //            "posted":posted
    //        ]
    //        let db = Firestore.firestore()
    //
    //        let docRef = db.collection("msg").document()
    //
    //        docRef.setData(docData) { error in
    //            if let error = error {
    //                print("Error writing document: \(error)")
    //            } else {
    //                print("Document successfully written!")
    //            }
    //        }
    //        let model = ViewModel()
    //        model.getData()
    //
    //}
    //
    //
    //
}
