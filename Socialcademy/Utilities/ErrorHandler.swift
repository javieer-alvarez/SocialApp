//
//  ErrorHandler.swift
//  Socialcademy
//
//  Created by Javier Ignacio Alvarez Izaguirre on 11/10/25.
//

@MainActor
protocol ErrorHandler: AnyObject {
    var error: Error? { get set }
}

extension ErrorHandler {
    func withErrorHandlingTask(perform action: @escaping () async throws -> Void){
        Task{
            do{
                try await action()
            }
            catch{
                print("[\(Self.self)] ERROR. Coundn't perform action: \(error)")
                self.error = error
            }
        }
    }
}
