//
//  ContentView.swift
//  Final HelperX
//
//  Created by Pranav Sai on 6/30/23.
//

import SwiftUI
import PhotosUI
import FirebaseStorage
import iPhoneNumberField
import Firebase
public var username = ""
public var typeOfUser = ""
public var profile_img = ""
public var myphonenumber = ""
public var mylocation = ""
public var allzipcodes:Array<String> = []
public var verified = false
struct ContentView: View {
//    @State public var typeOfUser:String = ""
//    @ObservedObject var model = InboxModel()

    @State var signup = false
    @State var selection = "Volunteer"
    @State var phonenumber=""
    @State var user=""
    @State var password=""
    @State var zipcode=""
    @State var choices = ["Volunteer","Senior Citizen","Disability","Veteran"]
    @State var userErrorText = ""
    @State public var alerttext = ""
    @State public var isOn = false
    @State var data: Data?
    @State private var showView = false
    @State var selectedItem: [PhotosPickerItem] = []
//    init(){
//
//        self.username = getUserWithDeviceId()
//        print("Username:"+username)
//        
//    }
//    init(){
//        self.model.getData()
//
//    }
    @ViewBuilder
    var body: some View {
        ZStack{
            if showView{
                HelperView()
            }

//            if typeOfUser=="None"{
////                SignUpView()
//
//
//            }
            
//            if typeOfUser  == "PTSD"{
//                PTSDView()
////                    .onAppearß){
////                        Task{
////                            username = await getUserWithDeviceId()
////                            typeOfUser = await getTypeOfUser(username: username)
////                        }
////                    }
//            }
//            if typeOfUser == "Helper"{
//
////                    .onAppear(){
////                        Task{
////                            username = await getUserWithDeviceId()
////                            typeOfUser = await getTypeOfUser(username: username)
////                        }
////                    }
//
//            }
            
        }.onAppear(){
            
            Task{
//                var weatherService =  Location()
//                weatherService.locationManager
       
               
                let userdata = await getUserData()
                
                username = userdata.0
                typeOfUser = userdata.1
                profile_img = userdata.2
                myphonenumber = userdata.3
                verified = userdata.4
                mylocation = userdata.5
                allzipcodes = await getAllZipcodes()
                print("All Zipcodes:")
                print(allzipcodes)
                //If user dosn't exist pull up sign up form
                if userdata.0 == ""{
                    typeOfUser="None"
                    signup.toggle()
                }
                else{
                    showView.toggle()
                }
//                //If it does exist pull up the app for that user
//                else{
//
//
//
//
//                    print(typeOfUser)
////                    getAdress()
//
//                }
                    
            }
        }
        .sheet(isPresented: $signup, onDismiss: nil){
            
            
            Form {
            
                HStack{
                    Spacer()
                    Text("Welcome!")
                    Spacer()
                    
                }
                
                Section() {
                    //                          TextField("", text: $name)
                    TextField("Username", text: $user)
                    SecureField("Password", text: $password)
                    
                    
                }
                Section(){
                    iPhoneNumberField("Please enter your phone number",text: $phonenumber)
                        .flagHidden(false)
                        .flagSelectable(true)
                        .clearButtonMode(.whileEditing)
                        .maximumDigits(10)
                        .font(UIFont(size: 15, weight: .bold, design: .rounded))
                        .padding()
                }
                Section(){
                    HStack{
                        TextField("Zipcode", text: $zipcode)
                        Button("Autofill") {
                            print("Button pressed!")
                            
                            zipcode = mylocation
                        }
                        .buttonStyle(GrowingButton())
                    }
                }.onAppear(){
                    getAdress()
                }

                Section(){
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
                
                Section(){
                    Picker("Why are you using this app?", selection: $selection) {
                        ForEach(choices, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.menu)
                    
                }
                
                Toggle(isOn: $isOn) {
                    Text("I agree to terms (EULA) agreeing that there is no tolerance for objectionable content or abusive users")
                }
                .toggleStyle(iOSCheckboxToggleStyle())
                
                Text(userErrorText).fontWeight(.black).foregroundColor(.red)
                
                Button("Sign Up"){
                    
                    
                    if (password.count<4){
                        print("Longer Password")
                        userErrorText="Password is less than 4 characters"
                        //                            showingAlert.toggle()
                    }
                    else if selectedItem == [] {
                        userErrorText = "Please select a profile picture"
                    }
                    else if zipcode.count != 5{
                        userErrorText = "Invalid zipcode"
                    }
                    else if phonenumber.count != 14{
                        userErrorText = "Invalid phone-number"
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
                                            createUser(name: user, password1: password,account: selection,imgurl: imageurl,phonenumber: phonenumber,zipcode: zipcode)
                                            //                                        username = user
                                            signup.toggle()
                                            alerttext="Successful, you have successfully created an Volunteer account! "
                                            username = user
                                           
                                            typeOfUser = selection
                                            profile_img = imageurl
                                            myphonenumber = phonenumber
                                            showView.toggle()
                                            allzipcodes = await getAllZipcodes()
                                            print("TypeofUser:"+typeOfUser)
                                            print("ProfileImg:"+profile_img)
                                            
                                            //                                        showingAlert.toggle()
                                        }
                                        else{
                                            userErrorText="Please accept the Terms & Conditions"
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
            
        }.interactiveDismissDisabled()
        }
    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

