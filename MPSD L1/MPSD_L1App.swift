//
//  MPSD_L1App.swift
//  MPSD L1
//
//  Created by Евгений on 21/5/21.
//

import SwiftUI
import Firebase
import FirebaseFirestore

@main
struct MPSD_L1App: App {
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            LoginView()
                .environment(\.colorScheme, isDarkMode ? .dark : .light)
        }
    }
}
