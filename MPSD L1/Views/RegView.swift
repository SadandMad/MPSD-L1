//
//  RegView.swift
//  MPSD L1
//
//  Created by Евгений on 25/5/21.
//

import SwiftUI

struct RegView: View {
    @Environment(\.presentationMode) var presentationMode
    @AppStorage("isDarkMode") private var isDarkMode = false
    @AppStorage("fontSize") private var fontSize = 12
    @ObservedObject var viewModel: unitViewModel
    @Binding var login: String
    @Binding var password: String
    @State var shortDesk: String = ""
    @State var longDesk: String = ""
    @State var isFavourite: Bool = false
    @State var category: Int = 2
    @State var latitude: String = ""
    @State var longitude: String = ""
    @State var imageName: String = ""
    private let categories = ["HQ", "Troops", "Elites", "Fast Attack", "Heavy Support"]
    
    var body: some View {
            Form {
                Section {
                    TextField("Имя", text: $login)
                        .font(.system(size: CGFloat(fontSize), weight: .semibold, design: .default))
                    TextField("Стоимость", text: $password)
                        .font(.system(size: CGFloat(fontSize), weight: .semibold, design: .default))
                        .keyboardType(.numberPad)
                    TextField("Короткое описание", text: $shortDesk)
                        .font(.system(size: CGFloat(fontSize), weight: .semibold, design: .default))
                    TextField("Полное описание", text: $longDesk)
                        .font(.system(size: CGFloat(fontSize), weight: .semibold, design: .default))
                    TextField("Широта", text: $latitude)
                        .font(.system(size: CGFloat(fontSize), weight: .semibold, design: .default))
                    TextField("Долгота", text: $longitude)
                        .font(.system(size: CGFloat(fontSize), weight: .semibold, design: .default))
                    TextField("Изображение", text: $imageName)
                        .font(.system(size: CGFloat(fontSize), weight: .semibold, design: .default))
                    
                    Picker(selection: $category, label: Text("Категория")
                            .font(.system(size: CGFloat(fontSize), weight: .semibold, design: .default))) {
                        ForEach(0..<categories.count) {
                            Text(categories[$0])
                        }
                    }
                    Toggle("Избранный", isOn: $isFavourite)
                        .font(.system(size: CGFloat(fontSize), weight: .semibold, design: .default))
                }
                
                Section {
                    Button("Добавить") {
                        self.viewModel.addUnit(name: login, price: UInt(password)!,
                                               shortDesk: shortDesk, longDesk: longDesk,
                                               isFavourite: isFavourite, category: categories[category],
                                               latitude: Double(latitude) ?? 53.9122, longitude: Double(longitude) ?? 27.5944,
                                               imageName: imageName)
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    .font(.system(size: CGFloat(fontSize+4), weight: .bold, design: .default))
                    Button("Главная") {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    .font(.system(size: CGFloat(fontSize+4), weight: .bold, design: .default))
                }
            }
        .environment(\.colorScheme, isDarkMode ? .dark : .light)
    }
}

struct RegView_Previews: PreviewProvider {
    static var previews: some View {
        RegView(viewModel: unitViewModel(), login: .constant(""), password: .constant(""))
    }
}
