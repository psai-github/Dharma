//
//  getAllInboxData.swift
//  Volenteer
//
//  Created by Pranav Sai on 7/12/23.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseStorage


struct InboxStruct: Identifiable , Hashable{
    let id: String
    let creator: String
    let date_accepted:String
    let helper : String
    let job_id: String
    let msg:String
    let name:String
    let phonenumber:String
    let job_name:String
    let verified:Bool
    let hours:String


}

class InboxModel: ObservableObject {
    
    @Published var msg = [InboxStruct]()
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
                    self.msg.removeAll { InboxStruct in
                        
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
        
        db.collection("inbox").whereField("creator", isEqualTo: username).getDocuments { snapshot, error in
            
            // Check for errors
            if error == nil {
                // No errors
                
                if let snapshot = snapshot {
                    
                    // Update the list property in the main thread
                    //                    DispatchQueue.main.async {
                    
                   
                        
                        // Get all the documents and create msg
                        self.msg = snapshot.documents.map { d in
//                            DispatchQueue.main.async {
//
//
//
//                                //                                    url1 = "https://firebasestorage.googleapis.com:443/"+url!.path
//
//                            }
                            print("URL:"+url1)
//                            var a = await getProfileUrl(username: d["creator"] as? String ?? "" )
                            //                            print("Stuff")
                            
                            //                            var name = (d["creator"] as? String ?? "")!
                            // Create a InboxStruct item for each document returned
           
                            return InboxStruct(id: d.documentID, creator: d["creator"] as? String ?? "", date_accepted: d["date_accepted"] as? String ?? "", helper: d["helper"] as? String ?? "", job_id: d["job_id"] as? String ?? "", msg: d["msg"] as? String ?? "", name: d["name"] as? String ?? "",phonenumber: d["phone_number"] as? String ?? "",job_name:d["job_name"] as? String ?? "",verified:d["verified"] as? Bool ?? false,hours:d["hours"] as? String ?? "" )
                                           
                                
                                
                                
                         
                            
                            
                        }
                        //print(self.list)
                        print(self.msg)
                        
                        ////
                    }
                    
                }
//                }
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
