//
//  InboxView.swift
//  Volenteer
//
//  Created by Pranav Sai on 7/12/23.
//

import Foundation
import SwiftUI

struct InboxView:View {

    @State var df=DateFormatter()
    @StateObject var model = InboxModel()

    var body: some View{
        VStack{
            NavigationView{
                List(model.msg){ mail in
                    NavigationLink(destination: MessageStruct(helper: mail.helper, job_name: mail.job_name,hours:mail.hours,msg: mail.msg,phonenumber: mail.phonenumber)){
                        HStack{
                            VStack(alignment: .leading){
                                HStack{
                                    Text(mail.helper)
                                        .font(.title2)
                                        .fontWeight(.medium)
                                    if mail.verified == true{
                                        Image(systemName: "checkmark.seal")
                                            .foregroundColor(.blue)
                                    }
                                    
                                    
                                }
                                
                                Text(mail.msg)
                                    .fontWeight(.light)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                            Button("Contact") {
                                let number: String = mail.phonenumber
                                let msg: String="Hi its \(username)."
                                let sms: String = "sms:\(number)&body=\(msg)"
                                let strURL: String = sms.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
                                UIApplication.shared.open(URL.init(string: strURL)!,options: [:],completionHandler: nil)
                                
                            }
                            .padding()
                            .background(.yellow)
                            .foregroundStyle(.black)
                            .clipShape(Capsule())
                        }
                    }
                    
                }.listStyle(.inset)
                    .navigationTitle("Inbox")
                
                
            }
//            Button("Reload") {
//                model.getData()
//
//            }
//            .buttonStyle(GrowingButton())
            .onAppear{model.getData()}
        }
//        .onAppear(){
//            Task{
////                model.getData()
////                allmsg=model.msg
//                df.dateFormat = "yyyy-MM-dd hh:mm:ss"
//            }
        }
}




struct MessageStruct:View{
    @State var helper:String
    @State var job_name:String
    @State var hours:String
    @State var msg:String
    @State var phonenumber:String

    var body: some View{
        Text("\(helper) has requested to help you \n \t[\(job_name)]! \n \n Message: \(msg)").fontWeight(.light).font(.title3)
        Button("Contact") {
            let number: String = phonenumber
            let msg: String="Hi its \(username)."
            let sms: String = "sms:\(number)&body=\(msg)"
            let strURL: String = sms.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            UIApplication.shared.open(URL.init(string: strURL)!,options: [:],completionHandler: nil)
        }
        .padding()
        .background(.yellow)
        .foregroundStyle(.black)
        .clipShape(Capsule())

        Button("Accept") {
            Task{
                Task{ await createAcceptFunction(name: job_name, hours: hours,helper: helper)}
            }
            
        }.buttonStyle(GrowingButton())

    }
    
}
