////
////  NotHelperAccount.swift
////  Volenteer
////
////  Created by Pranav Sai on 7/22/23.
////
//
//import Foundation
//import SwiftUI
//
//struct HelperView:View{
//    @State public var showMyTasksVolunteer = false
//    @State public var showMyTasksNotVolunteer = false
//    var body:some View{
//        TabView {
//            BlogPostCardMain()
//                .tabItem {
//                    Image(systemName: "calendar.badge.plus")
//                    Text("All Tasks")
//                }
//            ProfileView(image: profile_img, name: username, job: typeOfUser)
//                .tabItem {
//                    Image(systemName: "person.crop.circle")
//                    Text("Profile")
//                }
//            InboxView()
//                .tabItem {
//                    Image(systemName: "envelope.fill")
//                    Text("Inbox")
//                }
//            if showMyTasksVolunteer{
//                MyTasksVolunteerMain()
//                    .tabItem {
//                        Image(systemName: "calendar")
//                        Text("My Tasks")
//                    }
//            }
//            if showMyTasksNotVolunteer{
//               MyTasksNotVolunteerMain()
//                    .tabItem {
//                        Image(systemName: "calendar")
//                        Text("My Tasks")
//                    }
//            }
//            
//        }
//    }
//    
//}
