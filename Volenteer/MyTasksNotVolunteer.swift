//
//  MyTasksNotVolunteer.swift
//  Volenteer
//
//  Created by Pranav Sai on 7/21/23.
//

//

import Foundation
import SwiftUI


import SDWebImageSwiftUI


struct MyTasksNotVolunteerMain: View {
    @StateObject var model = AcceptModel()

 

    var body: some View {
        
        VStack{
            ScrollView{
                ForEach(model.accepts) { job in
                    if job.done == false{
                        MyTasksNotVolenteer(creator: job.helped, name: job.name,taskDocumentID: job.job_id, hours: job.hours, phonenumber: job.phonenumber, documentID: job.id)
                    }
                }
            }
        }

            .onAppear(){
                
                model.getData()

                
            }
           

    }
    }


struct MyTasksNotVolenteer:View{
    @Environment(\.colorScheme) var colorScheme
    @State var creator:String
    @State var name:String
    @State var taskDocumentID:String
    @State var hours:String
    @State var showAlert = false
    @State var phonenumber:String
    @State var documentID:String
    @State var showButton = false
    @State var showDoneAccept = false
    @State var comment = ""
    @State var choices = ["1","2","3","4","5"]
    @State var selection = "5"
    
    
    //    init(){
    //        self.edittitle = self.name
    //    }
    var body: some View{
        HStack{
            Spacer()
            VStack(alignment: .leading,spacing: 6) {
                
                
                Text(name)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
                    .lineLimit(3)
                    .font(Font.title2.bold())
                    .foregroundColor(.primary)
                
                Spacer()
                
                
                HStack{
                    Spacer()
                    
                    Button("Task Completed") {
                        
                        showAlert.toggle()
                    }
                    
                }
                .buttonStyle(GrowingButton())
                Spacer()
            }
            Spacer()
        }
        .sheet(isPresented: $showAlert, onDismiss: nil){
            Form{
                Section(){
                    Text("Please write a Review and Rate how the job was done")
                }
                Section{
                    TextField("Write a review!", text: $comment)
                   
//                        .textFieldStyle(PlainTextFieldStyle())
//                        .padding([.horizontal], 4)
//                        .cornerRadius(16)
//                        .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.gray))
//                        .padding([.horizontal], 24)
                }
                Section{
                    Picker("Rate Job 1-5", selection: $selection) {
                        ForEach(choices, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.menu)
                    
                }
                Section{
                    Button("Done") {
                        Task{await makeAcceptDone(documentID: documentID,comment: comment,rate: selection)
                            await makeTaskDone(documentID: taskDocumentID)
                        }
                        showDoneAccept.toggle()
                        showAlert.toggle()
                        showButton.toggle()
                    }
                    .buttonStyle(GrowingButton())
                }
            }
        }
        //                .frame(height: 110)
     .padding(15)
                .background(colorScheme == .dark ? Color("#121212") : Color.white)
    //            .frame(width: UIScreen.main.bounds.width, alignment: .leading)
                .frame(width: UIScreen.main.bounds.width - 50,height:120,alignment: .leading)
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .shadow(color: colorScheme == .dark ? .white.opacity(0.01) : .black.opacity(0.1), radius: 15, x: 0, y: 5)
                .alert("Task marked as finished!", isPresented: $showDoneAccept) {
                    Button("OK", role: .cancel) { }
                }
                
                
            }
        
    }
    
    

        
        
        
        
        
        
        
        
    
    

