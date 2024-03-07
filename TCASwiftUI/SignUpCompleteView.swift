//
//  SignUpCompleteView.swift
//  TCASwiftUI
//
//  Created by Neha Pant on 07/03/2024.
//

import SwiftUI
import ComposableArchitecture


struct SignUpCompleteView: View {
    @Bindable var store: StoreOf<SignUpDetailsFeature>
    
    var body: some View {
        VStack {
            // if let contact = store.state.contact {
            HStack {
                Text("Name:")
                Text(store.state.contact.name)
            }
            HStack {
                Text("Last Name:")
                Text(store.state.contact.lastName)
            }
            
            HStack {
                Text("DOb Name:")
                Text(store.state.contact.dob)
            }
            
            Button("Save") {
                store.send(.saveButtonTapped)
            }
            // }
        }
    }
    
}

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
    SignUpCompleteView(store: Store(initialState: SignUpDetailsFeature.State(contact: Contact(id: UUID(), name: "", lastName: "", dob: "")), reducer: {
        SignUpDetailsFeature()
    }))
}
