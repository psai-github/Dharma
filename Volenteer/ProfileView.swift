//
//  ProfileView.swift
//  Volenteer
//
//  Created by Pranav Sai on 7/11/23.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI
import PhotosUI
import FirebaseStorage
struct ProfileView: View {
    @State var image: String
    @State var name:String
    @State var job:String
    @Environment(\.colorScheme) var colorScheme
    @State var showFinishedAlert = false
    @State var showAlert = false
    @State var data: Data?
    @State var selectedItem: [PhotosPickerItem] = []
    @StateObject var model = AcceptModel()
    var body: some View {
        ScrollView{
            VStack(spacing: 20) {
                ZStack {
                    Circle()
                    //                    .fill(Color("ProfileBackground"))
                        .frame(width: 180, height: 180)
                    
                    WebImage(url: URL(string:profile_img))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 160, height: 160)
                        .clipShape(Circle())
                }
                .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 5)
                HStack{
                    Text(username)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    if verified == true{
                        Image(systemName: "checkmark.seal")
                            .foregroundColor(.blue)
                    }
                }
                Text(typeOfUser)
                    .font(.title)
                    .foregroundColor(.secondary)
                
                Divider()
                    .background(Color.secondary)
                    .foregroundColor(.primary)
                if verified == false{
                    Button("Get Verified") {
                        
                        showAlert.toggle()
                        
                    }
                    .buttonStyle(GrowingButton())
                }
                Divider()
                    .background(Color.secondary)
                    .foregroundColor(.primary)
                //            InfoRowView(title: "Email", value: "johndoe@example.com")
                InfoRowView(title: "    Phone", value: "\(myphonenumber)     ")
                InfoRowView(title: "    Zipcode", value: "\(mylocation)      ")
                Divider()
                    .background(Color.secondary)
                    .foregroundColor(.primary)
   
                
                ForEach(model.accepts) { job in
                    if job.helper == username{
                        if job.done == true{
                            HStack{
                                Spacer()
                                VStack(alignment: .leading,spacing:6){
                                    
                                    Text(job.name)
                                        .multilineTextAlignment(.leading)
//                                        .fixedSize(horizontal: false, vertical: true)
                                        .lineLimit(3)
                                        .font(Font.title2.bold())
                                        .foregroundColor(.primary)
                                    
                                    Spacer()
                                    Text("Helped : \(job.helped)")
                                        .multilineTextAlignment(.leading)
//                                        .fixedSize(horizontal: false, vertical: true)
                                        .lineLimit(3)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                        .foregroundColor(.secondary)
                                    Text("Volunteered for \(job.hours)")
                                        .multilineTextAlignment(.leading)
//                                        .fixedSize(horizontal: false, vertical: true)
                                        .lineLimit(3)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                        .foregroundColor(.secondary)
                                    
                                    
                                }
                                Spacer()
                                
                            }   .padding(15)
                                .background(colorScheme == .dark ? Color("#121212") : Color.white)
                                .frame(width: UIScreen.main.bounds.width - 50,height:120,alignment: .leading)
                                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                                .shadow(color: colorScheme == .dark ? .white.opacity(0.01) : .black.opacity(0.1), radius: 15, x: 0, y: 5)
                            
                            
                        }
                    }
                }
            }
        }
        .onAppear{
            model.getData()
        }
        .padding()
        .background(Color("ProfileBackground"))
        .edgesIgnoringSafeArea(.all)
        .sheet(isPresented: $showAlert, onDismiss: nil){
            Form{
                Section(){
                    Text("Upload your driver's license").font(.title2).bold()
                }

                Section(){
                    HStack{
                        Spacer()
                        PhotosPicker(selection: $selectedItem, maxSelectionCount: 1, selectionBehavior: .default, matching: .images, preferredItemEncoding: .automatic) {
                            if let data = data, let image = UIImage(data: data) {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame( maxHeight: 150)
                            } else {
                                Label("Select a picture", systemImage: "photo.on.rectangle.angled")
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
                Section{
                    Button("Send") {
                        showFinishedAlert.toggle()
                        Storage.storage().reference().child("verifications").child(username+".png").putData(data!, metadata: nil)
                            
                            { metadata, error in
                                
                                if let error = error {
                                    
                                    print("There was an error in firebase \(error.localizedDescription)")
                                    
                                } else {
                                    print("Start")
                                    
                                    print("Success.")
                                    
                                    Task{
                                      
                                        let a = await getimageUrl(ref: Storage.storage().reference().child("verifications").child(username+".png"))
                                       
                                    }
                                  
                                    
                                    
                                    
                                }
                                
                            }
                        showAlert.toggle()
                
                       
                    }
                    .buttonStyle(GrowingButton())
                }
            }
        }
        .alert("Drivers License Sent!", isPresented: $showFinishedAlert) {
            Button("OK", role: .cancel) { }
        }
    }
        
  
}

struct InfoRowView: View {
    var title: String
    var value: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.headline)
                .foregroundColor(.secondary)
            
            Spacer()
            
            Text(value)
                .font(.body)
        }
        .padding(.vertical, 4)
    }
}
