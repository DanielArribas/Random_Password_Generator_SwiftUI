//
//  ContentView.swift
//  Random Pass
//
//  Created by Daniel Arribas on 10/23/23.
//

import SwiftUI

struct ContentView: View {

    // User defaults
    let defaults = UserDefaults.standard

    // Variables with AppStorage to retrieve user defaults
    @AppStorage("useNumbers") var useNumbers = false
    @AppStorage("useLower") var useLower = false
    @AppStorage("useUpper") var useUpper = false
    @AppStorage("useSymbols") var useSymbols = false
    @AppStorage("length") var length = 8

    // Other variables
    let LengthRange = 1 ... 50
    @State var password = ""
    @State var showAlert = false
    @State var showGenerateAlert = false

    @State var randomPassword = RandomPassword()

    // View
    var body: some View {

        VStack(alignment: .center) {
            Text("Random Password Generator")
                .font(.title)
                .multilineTextAlignment(.center)
                .padding()

            Spacer()
                .frame(height: 30.0)

            // Toggle switches
            Toggle(isOn: $useNumbers) {
                Text("Numbers")
            }
            Toggle(isOn: $useLower) {
                Text("Lower Case letters")
            }
            Toggle(isOn: $useUpper) {
                Text("Upper Case Letters")
            }
            Toggle(isOn: $useSymbols) {
                Text("Symbols (e.g. $ % ^ & * > < / @)")
            }

            // Password length selection stepper
            Stepper(value: $length, in: LengthRange) {
                Text("Password length: \(length)")
            }
            .padding(.vertical)

            // Generate button
            Button("Generate") {
                password = randomPassword.generatePass(useNumbers, useLower, useUpper, useSymbols, length)
                if password == "" {
                    showGenerateAlert = true
                }
            }
            .buttonStyle(.borderedProminent)
            .padding()
            .alert(isPresented: $showGenerateAlert) {
                Alert(
                    title: Text("No options selected"),
                    message: Text("Select at least one option to include from above")
                )
            }

            TextField("", text: $password, axis: .vertical)
                .textFieldStyle(.roundedBorder)
                .padding()
                .disabled(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                .multilineTextAlignment(.center)

            // Copy button
            Button("Copy") {
                UIPasteboard.general.setValue(password, forPasteboardType: "public.plain-text")
                showAlert = true
            }
            .buttonStyle(.bordered)
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Password Copied")
                )
            }
            .padding()
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
