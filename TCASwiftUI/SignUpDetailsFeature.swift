//
//  SignUpDetailsFeature.swift
//  TCASwiftUI
//
//  Created by Neha Pant on 07/03/2024.
//

import SwiftUI

@Reducer
struct SignUpDetailsFeature {
    
    @ObservableState
    struct State: Equatable {
        var contact: Contact
    }
    
    enum Action {
        case saveButtonTapped
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .saveButtonTapped:
                return .none
            }
        }
    }
}

#Preview {
    SignUpDetailsFeature()
}
