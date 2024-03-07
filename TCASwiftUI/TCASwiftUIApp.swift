//
//  TCASwiftUIApp.swift
//  TCASwiftUI
//
//  Created by Neha Pant on 04/03/2024.
//

import SwiftUI
import ComposableArchitecture

@main
struct TCASwiftUIApp: App {

    var body: some Scene {
        WindowGroup {
            WelcomeView(store:
                            Store(initialState: AuthenticationFeature.State(),
                                  reducer: {
                AuthenticationFeature()
            }))
        }
    }
}
