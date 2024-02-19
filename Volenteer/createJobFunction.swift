//
//  createJobFunction.swift
//  Final HelperX
//
//  Created by Pranav Sai on 7/2/23.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseStorage

func createJobFunction(username:String,name:String,des:String,date:Date,img:String,onlyverified:Bool,hours:String) async{
        @StateObject var locationManager = LocationManager()
        print(img)
       
       
        let db = Firestore.firestore()

        let docRef = db.collection("jobs").document()
        

            do{
               
                docRef.setData(["creator": username,"name":name,"des":des+" - \(username)","date":date,"posted":Date.now,"img": img,"zipcode":mylocation,"onlyverified":onlyverified,"status":"open","hours":hours]) { error in
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

