//
//  CreateNewJobView.swift
//  Volenteer
//
//  Created by Pranav Sai on 7/3/23.
//

import Foundation
import SwiftUI
import PhotosUI
import FirebaseStorage
struct CreatenewJobView:View{
//    @State var username:String

    @State var jobname = ""
    @State var choices = ["10 min","15 min","30 min","1 hour","1 hour and 30 min","2 hours","3 hours","4 hours","4+ hours"]
    @State var selection = "30 min"
    @State var des=""
    @State var showingAlert = false
    @State private var image = UIImage()
    @State var showimagePicker = false
    @State var data: Data?
    @State var isOn = false
    @State var selectedItem: [PhotosPickerItem] = []
    let storageReference = Storage.storage().reference().child("\(UUID().uuidString)")
    @State var date = Date()
    var body: some View{
        Form{
            
            Section() {
                
                TextField("Name of Job", text: $jobname)
                TextField("Description of Job", text: $des)
            }
            
            Section(){
                Picker("How much time will this job take?", selection: $selection) {
                    ForEach(choices, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.menu)
                
            }
            
            DatePicker(
                "",
                selection: $date,
                displayedComponents: [.date, .hourAndMinute])
            .padding()
            .datePickerStyle(.compact)
            .padding()
            .border(Color.cyan)
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
            Section(){
                Toggle(isOn: $isOn) {
                    Text("Only allow verified volunteers request")
                }
                .toggleStyle(iOSCheckboxToggleStyle())
            }
            Button("Upload Job"){
           
                Storage.storage().reference().child("images").child(jobname+".png").putData(data!, metadata: nil)
                    
                    { metadata, error in
                        
                        if let error = error {
                            
                            print("There was an error in firebase \(error.localizedDescription)")
                            
                        } else {
                            print("Start")
                            
                            print("Success.")
                            
                            Task{
                                showingAlert.toggle()
                                let a = await getimageUrl(ref: Storage.storage().reference().child("images").child(jobname+".png"))
                                await createJobFunction(username: username, name: jobname, des: des, date: date,img:a,onlyverified: isOn,hours: selection)
                            }
                          
                            
                            
                            
                        }
                        
                    }
                

            }
            
            .sheet(isPresented: $showimagePicker) {
                // Pick an image from the photo library:
                ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
            }
            .alert("Job has been uploaded!", isPresented: $showingAlert) {
                Button("OK", role: .cancel) { }
            }
        }
        
        
        //  If you wish to take a photo from camera instead:
        // ImagePicker(sourceType: .camera, selectedImage: self.$image)
        
        
        
        
        
        
        
        
    }
    
    
    
    
    
    
    
}
