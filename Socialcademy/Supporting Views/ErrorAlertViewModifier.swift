//
//  ErrorAlertViewModifier.swift
//  Socialcademy
//
//  Created by Javier Ignacio Alvarez Izaguirre on 18/9/25.
//

import SwiftUI

struct ErrorAlertViewModifier: ViewModifier {
    
    let title: String
    @Binding var error: Error?
    
    func body(content: Content) -> some View{
        content
            .alert(title, isPresented: $error.hasValue, presenting: error, actions: {_ in}){ error in
                Text(error.localizedDescription)
            }
    }
}

private extension Optional {
    var hasValue: Bool{
        get { self != nil }
        set {self = newValue ? self : nil}
    }
}

extension View {
    func alert(_ title: String, error: Binding<Error?>) -> some View {
        modifier(ErrorAlertViewModifier(title: title, error: error))
    }
}
