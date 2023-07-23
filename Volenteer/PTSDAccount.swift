//
//  PTSDAccount.swift
//  Final HelperX
//
//  Created by Pranav Sai on 6/30/23.
//

import Foundation
import SwiftUI

struct PTSDView:View{
    var body:some View{
        TabView {
            Text("All")
                .tabItem {
                    Image(systemName: "globe.americas.fill")
                    Text("All")
                }
            Text("Helpers")
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Helpers")
                }
            Text("Jobs")
                .tabItem {
                    Image(systemName: "mappin.circle.fill")
                    Text("Jobs")
                }
        }
    }
}

