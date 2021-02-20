//
//  InfluPeachApp.swift
//  InfluPeach
//
//  Created by Ethan Hanlon on 2/20/21.
//

import SwiftUI
import Firebase
import NavigationStack

@main
struct InfluPeachApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStackView {
                ContentView()
            }
        }
    }
}


//Connect Firebase
class Delegate: NSObject, UIApplicationDelegate, ObservableObject {
    @Published var signedIn: Bool = false
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
}
