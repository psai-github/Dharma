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
                        MyTasksNotVolenteer(creator: job.helped, name: job.name, hours: job.hours, phonenumber: job.phonenumber, documentID: job.id)
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
    @State var hours:String

    @State var phonenumber:String
    @State var documentID:String
    @State var showDoneAccept = false
    
    
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
                        Task{await makeTaskDone(documentID: documentID)
                            showDoneAccept.toggle()
                        }
                        
                    }
                    .buttonStyle(GrowingButton())
                    Spacer()
                }
                
            }
            Spacer()
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
    

