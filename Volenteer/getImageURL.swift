//
//  getImageURL.swift
//  Volenteer
//
//  Created by Pranav Sai on 7/4/23.
//

import Foundation
import Firebase
import FirebaseStorage
func getimageUrl(ref: StorageReference) async -> String{
    //    var ref:  StorageReference
    //    var url1 = String()
    //    let islandRef = Storage.storage().reference().child("videos/test.MOV")
    //    let starsRef = Storage.storage().reference().child("videos/test.MOV")
    let starsRef = ref

    do{
        var b = try await starsRef.downloadURL()
        print(b)
        return b.absoluteString
    }
    catch{
        print(error)
        return "Hi"
    }
}

func getProfileUrl(username: String) async -> String{
    //    var ref:  StorageReference
    //    var url1 = String()
    //    let islandRef = Storage.storage().reference().child("videos/test.MOV")
    //    let starsRef = Storage.storage().reference().child("videos/test.MOV")
    let starsRef = Storage.storage().reference().child("profile").child((username)+".png")

    do{
        var b = try await starsRef.downloadURL()
        print(b)
        return b.absoluteString
    }
    catch{
        print(error)
        return "Hi"
    }
}

//
//
//func getProfileURL(creator:String) -> String{
//
//
//    Storage.storage().reference().child("profile").child((creator)+".png").downloadURL { (url, error) in
////        if let error = error {
////            print("\(error)")
////        }
//        //                            do{
//
//        var url1 = "https://firebasestorage.googleapis.com:443/"+url!.path
//
//        //                                }
//        //                                catch{
//        //                                    print(error)
//        //                                }
////        return url1
//    }
//}
