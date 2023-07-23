//
//  createAcceptFunc.swift
//  Volenteer
//
//  Created by Pranav Sai on 7/10/23.
//

import Foundation
import Firebase



func createInboxRow(helper:String,creator:String,name:String,job_id:String,date_accepted:Date,msg:String,job_name:String,hours:String){
    let db = Firestore.firestore()

    let docRef = db.collection("inbox").document()
    

        do{
      
            docRef.setData(["helper":helper,"creator":creator,"name":name,"job_id":job_id,"date_accepted":date_accepted,"msg":msg,"phone_number":myphonenumber,"job_name":job_name,"verified":verified,"hours":hours]) { error in
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
