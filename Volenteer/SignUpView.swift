//
//  SignUpView.swift
//  Final HelperX
//
//  Created by Pranav Sai on 6/30/23.
//

import Foundation
import SwiftUI
import PhotosUI
import FirebaseStorage

struct SignUpView:View{
    @State var signup = true
    @State var user=""
    @State var password=""
    @State var userErrorText = ""
    @State public var alerttext = ""
    @State public var isOn = false
    @State var data: Data?
    @State var selectedItem: [PhotosPickerItem] = []

    
    var body:some View{
        if signup==true{
            Form {
                Section() {
                    //                          TextField("", text: $name)
                    TextField("Username", text: $user)
                    SecureField("Password", text: $password)
                    HStack{
                        Spacer()
                        PhotosPicker(selection: $selectedItem, maxSelectionCount: 1, selectionBehavior: .default, matching: .images, preferredItemEncoding: .automatic) {
                            if let data = data, let image = UIImage(data: data) {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 200, height: 60)
                                                .background(Color.black.opacity(0.2))
                                    .clipShape(Circle())
                            } else {
                                Label("Select a profile picture", systemImage: "photo.on.rectangle.angled")
                            }
                        }.onChange(of: selectedItem) { newValue in
                            guard let item = selectedItem.first else {
                                return
                            }
                            item.loadTransferable(type: Data.self) { result in
                                switch result {
                                case .success(let data):
                                    if let data = data {
                                        self.data = data
                                    }
                                case .failure(let failure):
                                    print("Error: \(failure.localizedDescription)")
                                }
                            }
                        }
                        Spacer()
                    }
                }
                Toggle(isOn: $isOn) {
                    Text("I agree to terms (EULA) agreeing that there is no tolerance for objectionable content or abusive users")
                }
                .toggleStyle(iOSCheckboxToggleStyle())
                Button("Sign Up"){
                    
                    
                    if (password.count<4){
                        print("Longer Password")
                        userErrorText="Password is less than 4 characters"
                        //                            showingAlert.toggle()
                    }
                    else{
                        
                        Storage.storage().reference().child("profile").child(user+".png").putData(data!, metadata: nil){ metadata, error in
                            
                            if let error = error {
                                
                                print("There was an error in firebase \(error.localizedDescription)")
                                
                            } else {
                                print("Start")
                                
                                print("Success.")
                                
                                Task{
                                    let imageurl = await getimageUrl(ref: Storage.storage().reference().child("profile").child(user+".png"))
                                    
                                    let a = await validUsername(username: user)
                                    
                                    if a == true{
                                        
                                        if isOn==true{
//                                            createUser(name: user, password1: password,account: "Helper",imgurl: imageurl,phonenumber: )
                                            //                                        username = user
                                            signup.toggle()
                                            alerttext="Successful, you have successfully created an Volenteer account! "
                                            //                                        showingAlert.toggle()
                                        }
                                        else{
                                            alerttext="Please accept the Terms & Conditions"
                                        }
                                    }
                                    else{
                                        userErrorText="Sorry, this username already exists"
                                        
                                    }
                                }
                                
                                
                                
                                
                                
                            }
                            
                        }
                    }
                    
                }
            }
        }
        
        Text(userErrorText).fontWeight(.black).foregroundColor(.red)
        
        
        
    }
    
    
    
    
    //
    //            }.navigationBarTitle("Sign Up")
    //                .navigationViewStyle(StackNavigationViewStyle())
    
    
}
        
    

    struct iOSCheckboxToggleStyle: ToggleStyle {
        func makeBody(configuration: Configuration) -> some View {
            // 1
            Button(action: {
                
                // 2
                configuration.isOn.toggle()
                
            }, label: {
                HStack {
                    // 3
                    Image(systemName: configuration.isOn ? "checkmark.square" : "square")
                    
                    configuration.label
                }
            })
        }
    }
