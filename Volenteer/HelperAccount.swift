//
//  HelperAccount.swift
//  Final HelperX
//
//  Created by Pranav Sai on 6/30/23.
//

import Foundation
import SwiftUI

struct HelperView:View{
    @State public var showMyTasksVolunteer = false
    @State public var showMyTasksNotVolunteer = false
    var body:some View{
        TabView {
            BlogPostCardMain()
                .tabItem {
                    Image(systemName: "calendar.badge.plus")
                    Text("All Tasks")
                }
            CreatenewJobView()
                .tabItem {
                    Image(systemName: "square.and.arrow.up.circle.fill")
                    Text("New")
                }
            ProfileView(image: profile_img, name: username, job: typeOfUser)
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("Profile")
                }
            if typeOfUser == "Volunteer"{
                MyTasksVolunteerMain()
                    .tabItem {
                        Image(systemName: "calendar")
                        Text("My Tasks")
                    }
            }
            else{
                MyTasksNotVolunteerMain()
                    .tabItem {
                        Image(systemName: "calendar")
                        Text("My Tasks")
                    }
            }
            InboxView()
                .tabItem {
                    Image(systemName: "envelope.fill")
                    Text("Inbox")
                }

            
        }
    }
    
}
