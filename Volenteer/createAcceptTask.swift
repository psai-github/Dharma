//
//  createAcceptTask.swift
//  Volenteer
//
//  Created by Pranav Sai on 7/20/23.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseStorage

func createAcceptFunction(name:String,hours:String,helper:String) async{
        @StateObject var locationManager = LocationManager()
       
       
        let db = Firestore.firestore()

        let docRef = db.collection("accepts").document()
        

            do{
               
                docRef.setData(["name": name,"helper":helper,"hours":hours,"helped":username,hours:"hours","date":Date.now,"done":false,"helped_contact":myphonenumber]) { error in
                    if let error = error {
                        print("Error writing document: \(error)")
                    } else {
                        print("Document successfully written!")
                    }
                }
            }
            catch{
                print("Error")
                
            }


}

