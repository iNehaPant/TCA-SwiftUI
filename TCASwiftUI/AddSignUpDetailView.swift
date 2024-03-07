//
//  AddSignUpDetailView.swift
//  TCASwiftUI
//
//  Created by Neha Pant on 07/03/2024.
//

import SwiftUI
import ComposableArchitecture

struct AddSignUpDetailView: View {
    @Bindable var store: StoreOf<SignUpFeature>
    
    var body: some View {
        Form {
            TextField("Name", text: $store.contact.name.sending(\.setName))
            TextField("Las Name", text: $store.contact.lastName.sending(\.setLastName))
            TextField("DOB", text: $store.contact.dob.sending(\.setDob))
            NavigationLink("Next", state: AuthenticationFeature.Path.State.showSignUpDetailsFeature(SignUpDetailsFeature.State(contact: Contact(id: store.contact.id, name: store.contact.name, lastName: store.contact.lastName, dob: store.contact.dob))))
        }
    }
}


#Preview {
    AddSignUpDetailView(store: Store(initialState: SignUpFeature.State(contact: Contact(id: UUID(), name: "", lastName: "", dob: "")), reducer: {
        SignUpFeature()
    }))
}

@Reducer
struct SignUpFeature {
    
    @ObservableState
    struct State: Equatable {
        var contact: Contact
    }
    
    enum Action {
        case setName(String)
        case setLastName(String)
        case setDob(String)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .setName(name):
                state.contact.name = name
                return .none
            case let .setLastName(lastName):
                state.contact.lastName = lastName
                return .none
            case let .setDob(dob):
                state.contact.dob = dob
                return .none
            }
        }
    }
}
