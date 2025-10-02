//
//  FormViewModel.swift
//  Socialcademy
//
//  Created by Javier Ignacio Alvarez Izaguirre on 26/9/25.
//

import SwiftUI

@MainActor
@dynamicMemberLookup
class FormViewModel<Value>: ObservableObject {
    
    typealias Action = (Value) async throws -> Void
    
    @Published var value: Value
    @Published var error: Error?
    
    subscript<T>(dynamicMember keyPath: WritableKeyPath<Value, T>) -> T{
        get { value[keyPath: keyPath] }
        set { value[keyPath: keyPath] = newValue }
    }
    
    private let action: Action
    
    init(initialValue: Value, action: @escaping Action){
        self.value = initialValue
        self.action = action
    }
    
    nonisolated func submit() {
        Task{
            await handleSubmit()
        }
    }
    
    private func handleSubmit() async {
        do{
            try await action(value)
        }
        catch{
            print("[FormViewModel], couldn't perform action: \(error)")
            self.error = error
        }
    }
    
}
