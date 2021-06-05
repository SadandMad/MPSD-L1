//
//  SettingsView.swift
//  MPSD L1
//
//  Created by Евгений on 25/5/21.
//

import SwiftUI
import Combine

struct SettingsView: View {
    @ObservedObject var viewModel: unitViewModel
    @AppStorage("isDarkMode") private var isDarkMode = false
    @AppStorage("fontSize") private var fontSize = 12
    @Binding var registrated: Bool
    @State private var password: String = ""
    @State private var imageName: String = ""
    
    var body: some View {
        VStack {
            Spacer()
            Picker("Тема", selection: $isDarkMode) {
                Text("Светлая")
                    .tag(false)
                Text("Тёмная")
                    .tag(true)
            }
            .pickerStyle(SegmentedPickerStyle())
            Spacer()
            Stepper("Размер шрифта", value: $fontSize, in: 6...24)
                .font(.system(size: CGFloat(fontSize)))
            Text("Размер шрифта: \(fontSize)")
                .font(.system(size: CGFloat(fontSize)))
            Spacer()
            if viewModel.authUnit != nil
            {
                Text(viewModel.authUnit!.name)
                        .font(.system(size: CGFloat(fontSize+2), weight: .bold, design: .default))
                TextField("Стоимость", text: $password)
                    .font(.system(size: CGFloat(fontSize), weight: .semibold, design: .default))
                    .keyboardType(.numberPad)
                    .onReceive(Just(password)) {
                        newValue in let filtered = newValue.filter { "0123456789".contains($0) }
                        if filtered != newValue {
                            self.password = filtered
                        }
                    }
                    .onAppear() {
                        self.password = String(viewModel.authUnit!.price)
                    }
                TextField("Изображение", text: $imageName)
                    .font(.system(size: CGFloat(fontSize), weight: .semibold, design: .default))
                    .onAppear() {
                        self.imageName = viewModel.authUnit!.imageName ?? ""
                    }
                Button("Обновить") {
                    viewModel.updateUnit(ref: viewModel.authUnit!.refId, price: UInt(password)!, image: imageName)
                }
                
                Button("Удалить \(viewModel.authUnit!.name)") {
                    viewModel.deleteUnit(id: viewModel.authUnit!.refId)
                    viewModel.authUnit = nil
                    registrated.toggle()
                }
            }
            Spacer()
            Spacer()
        }
        .padding()
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(viewModel: unitViewModel(), registrated: .constant(true))
    }
}
