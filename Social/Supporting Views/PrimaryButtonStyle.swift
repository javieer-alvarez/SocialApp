//
//  PrimaryButtonStyle.swift
//  Socialcademy
//
//  Created by Javier Ignacio Alvarez Izaguirre on 5/10/25.
//

import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    
    @Environment(\.isEnabled) private var enabled
    
    func makeBody(configuration: Configuration) -> some View {
        Group{
            if enabled {
                configuration.label
            }
            else{
                ProgressView()
            }
        }
            .padding()
            .frame(maxWidth: .infinity)
            .foregroundStyle(.white)
            .background(Color.accentColor)
            .cornerRadius(10)
    }
}

extension ButtonStyle where Self == PrimaryButtonStyle {
    static var primary: PrimaryButtonStyle {
        PrimaryButtonStyle()
    }
}
