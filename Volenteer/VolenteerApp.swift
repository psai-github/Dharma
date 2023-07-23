//
//  VolenteerApp.swift
//  Volenteer
//
//  Created by Pranav Sai on 7/3/23.
//

import SwiftUI
import Firebase

@main
struct VolenteerApp: App {
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {

        WindowGroup {
            
            ContentView()
        }
    }
}
