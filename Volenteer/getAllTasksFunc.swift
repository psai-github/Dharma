//
//  getAllTasksFunc.swift
//  Final HelperX
//
//  Created by Pranav Sai on 7/2/23.
//


import Foundation
import SwiftUI
import Firebase
import FirebaseStorage



struct Todo: Identifiable , Hashable{
    let id: String
    let name: String
    let des:String
    let creator : String
    let date: String
    let posted:String
    let img:String
    let profile_pic:String
    let onlyverified:Bool
    let hours:String
    let status:String

}

public class ViewModel: ObservableObject {
    
    @Published var jobs = [Todo]()
//    @State var url = "hi"
    
    
//    init() {
//        getData(zipcode: mylocation)
//    }
    func deleteData(todoToDelete: Todo) {
        
        // Get a reference to the database
        let db = Firestore.firestore()
        
        // Specify the document to delete
        db.collection("jobs").document(todoToDelete.id).delete { error in
            
            // Check for errors
            if error == nil {
                // No errors
                
                // Update the UI from the main thread
                DispatchQueue.main.async {
                    
                    // Remove the todo that was just deleted
                    self.jobs.removeAll { todo in
                        
                        // Check for the todo to remove
                        return todo.id == todoToDelete.id
                    }
                }
                
                
            }
        }
//        self.getData(zipcode: mylocation)
   
        
    }
    
    
    func getData(zipcode:String){
        
        // Get a reference to the database
        let db = Firestore.firestore()
        var url1 = "hi"
//        let profile_pic = await getimageUrl(ref: Storage.storage().reference().child("profile").child(+".png"))
        // Read the documents at a specific path
        
        db.collection("jobs").whereField("zipcode", isEqualTo: zipcode).getDocuments { snapshot, error in
            
            // Check for errors
            if error == nil {
                // No errors
                
                if let snapshot = snapshot {
                    
                    // Update the list property in the main thread
                    //                    DispatchQueue.main.async {
                    
                   
                        
                        // Get all the documents and create jobs
                        self.jobs = snapshot.documents.map { d in
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
                            // Create a Todo item for each document returned
                           
                                return Todo(id: d.documentID,
                                            name: d["name"] as? String ?? "",
                                            des: d["des"] as? String ?? "",
                                            creator: d["creator"] as? String ?? "",
                                            date: d["date"] as? String ?? "",
                                            posted: d["posted"] as? String ?? "",
                                            img: d["img"] as? String ?? "" ,
                                            profile_pic: url1,
                                            onlyverified: d["onlyverified"] as? Bool ?? false,
                                            hours: d["hours"] as? String ?? "",
                                            status: d["status"] as? String ?? "")
                                           
                                
                                
                                
                         
                            
                            
                        }
                        //print(self.list)
                        print(self.jobs)
                        
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
    

    


