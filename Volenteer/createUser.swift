//
//  createUser.swift
//  Final HelperX
//
//  Created by Pranav Sai on 6/30/23.
//

import Foundation
import Firebase
import FirebaseFirestore
func createUser(name: String,password1:String,account:String,imgurl:String,phonenumber:String,zipcode:String){
    let db = Firestore.firestore()

    let docRef = db.collection("users").document()
    

        do{
            let password =  try encryptMessage(message: password1)
            docRef.setData(["id":UIDevice.current.identifierForVendor!.uuidString,"name": name,"password":password,"account":account,"profile_pic":imgurl,"phone_number":phonenumber,"zipcode":zipcode,"verified":false]) { error in
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
