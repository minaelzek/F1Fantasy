//
//  F1FantasyApp.swift
//  F1Fantasy
//
//  Created by Mina Elzik on 2023-11-22.
//

import SwiftUI
import GoogleSignIn

@main
struct F1FantasyApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            WelcomeView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        //GIDSignIn.clientID = "253286656535-9a2g5lemtgm701oqqcc9686skjis7312.apps.googleusercontent.com"
        GIDSignIn.clientID="253286656535-9a2g5lemtgm701oqqcc9686skjis7312.apps.googleusercontent.com"
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance.handle(url)
    }
}
