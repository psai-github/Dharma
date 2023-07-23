//
//  MyTasksVolunteer.swift
//  Volenteer
//
//  Created by Pranav Sai on 7/20/23.
//

import Foundation
import SwiftUI


import SDWebImageSwiftUI


struct MyTasksVolunteerMain: View {
    @StateObject var model = AcceptModel()

 

    var body: some View {
        
        VStack{
            ScrollView{
                ForEach(model.accepts) { job in
                    if job.done == false{
                        MyTasksVolenteer(creator: job.helped, name: job.name, hours: job.hours, phonenumber: job.phonenumber, documentID: job.id)
                    }
                }
            }
        }

            .onAppear(){
                
                model.getData()

                
            }
           

    }
    }


struct MyTasksVolenteer:View{
    @Environment(\.colorScheme) var colorScheme
    @State var creator:String
    @State var name:String
    @State var hours:String

    @State var phonenumber:String
    @State var documentID:String
    
    
    
    //    init(){
    //        self.edittitle = self.name
    //    }
    var body: some View{
        HStack{
            Spacer()
            VStack(spacing: 6) {

                    Text(name)
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                        .lineLimit(3)
                        .font(Font.title2.bold())
                        .foregroundColor(.primary)
                    
                    Spacer()
            
    
                        Text("Volunteer Hours : \(hours)")
                            .multilineTextAlignment(.leading)
                            .fixedSize(horizontal: false, vertical: true)
                            .lineLimit(3)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .foregroundColor(.secondary)
                        
                    
                Spacer()
                HStack{
                    Spacer()
                    Button("Contact") {
                        let number: String = phonenumber
                        let msg: String="Hi its \(username)."
                        let sms: String = "sms:\(number)&body=\(msg)"
                        let strURL: String = sms.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
                        UIApplication.shared.open(URL.init(string: strURL)!,options: [:],completionHandler: nil)
                        
                    }
                    .buttonStyle(GrowingButton())
                    Spacer()
                }
                    
                }
                Spacer()
                
            }
            .padding(15)
            .background(colorScheme == .dark ? Color("#121212") : Color.white)
            .frame(width: UIScreen.main.bounds.width - 50,height:150,alignment: .leading)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .shadow(color: colorScheme == .dark ? .white.opacity(0.01) : .black.opacity(0.1), radius: 15, x: 0, y: 5)
            
            
            
        }
        
        
        
        
        
        
        
        
    }
    

