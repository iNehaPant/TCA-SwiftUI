//
//  WelcomeView.swift
//  TCASwiftUI
//
//  Created by Neha Pant on 07/03/2024.
//

import SwiftUI
import ComposableArchitecture

struct WelcomeView: View {
    @Bindable var store: StoreOf<AuthenticationFeature>

    var body: some View {
        NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                 if let contact = store.state.contact {
                     HStack {
                         Text("Name:")
                         Text(contact.name)
                     }
                     HStack {
                         Text("Last Name:")
                         Text(contact.lastName)
                     }
                     
                     HStack {
                         Text("DOb Name:")
                         Text(contact.dob)
                     }
                }
                NavigationLink(
                    "Sign Up for details",
                    state: AuthenticationFeature.Path.State.addContactFeature(SignUpFeature.State(contact: Contact(id: UUID(), name: "", lastName: "", dob: "")))
                )
            }
            .padding()
        } destination: { store in
            switch store.case {
            case let .addContactFeature(store):
                AddSignUpDetailView(store: store)
            case let .showSignUpDetailsFeature(store):
                SignUpCompleteView(store: store)
            }
        }

        
    }
}

#Preview {
    WelcomeView(store: Store(initialState: AuthenticationFeature.State(), reducer: {
        AuthenticationFeature()
    }))
}


@Reducer
struct AuthenticationFeature {
    @Reducer(state: .equatable)
   
    enum Path {
        case addContactFeature(SignUpFeature)
        case showSignUpDetailsFeature(SignUpDetailsFeature)
    }
    
    @ObservableState
    struct State {
        var addContact: SignUpFeature.State = SignUpFeature.State(contact: Contact(id: UUID(), name: "", lastName: "", dob: ""))
        var contact: Contact?
        var path = StackState<Path.State>()
    }
    
    enum Action {
        //When tapped on Add
        case addButtonTapped
        case path(StackAction<Path.State, Path.Action>)
        case popToRoot

    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .addButtonTapped:
                state.addContact = SignUpFeature.State(
                    contact: Contact(id: UUID(), name: "", lastName: "", dob: "")
                )
                return .none
            case .popToRoot:
              state.path.removeAll()
              return .none
 
            case let .path(.element(id: id, action: .showSignUpDetailsFeature(.saveButtonTapped))):
                guard let signUpDetailFeatureState = state.path[id: id]
                else { return .none }
                  print(signUpDetailFeatureState.showSignUpDetailsFeature?.contact.name)
                  if let feature = signUpDetailFeatureState.showSignUpDetailsFeature {
                      state.contact = feature.contact
                  }
                
               // let data = try? JSONEncoder().encode(state.contact)
               // userDefaults.set(data, forKey: "contact")
                state.path.removeAll()
                return .none
                
            case let .path(action):
              switch action {
              default:
                return .none
              }

            }
        }
        .forEach(\.path, action: \.path)
    }
}


struct Contact: Identifiable, Equatable {
    var id: UUID
    var name: String
    var lastName: String
    var dob: String
}
