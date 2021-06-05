//
//  FilterView.swift
//  MPSD L1
//
//  Created by Евгений on 30/5/21.
//

import SwiftUI

struct FilterView: View {
    @Environment(\.presentationMode) var presentationMode
    @AppStorage("isDarkMode") private var isDarkMode = false
    @AppStorage("fontSize") private var fontSize = 12
    @ObservedObject var viewModel: unitViewModel
    @State private var nameString: String = ""
    @State private var greatString: String = ""
    @State private var lessString: String = ""
    @State var filterCategory: Int = 1
    @State private var favoutite: Bool = true
    private let filterCategories = ["HQ", "Troops", "Elites", "Fast Attack", "Heavy Support"]
    
    var body: some View {
        Form {
            Section {
                Button(action: {
                    viewModel.filterUnits(type: 0, filter: nameString)
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    HStack{
                        Text("Фильтр по ")
                            .font(.system(size: CGFloat(fontSize)))
                        TextField("Имени", text: $nameString)
                            .font(.system(size: CGFloat(fontSize)))
                    }
                })
            }
            Section {
                Button(action: {
                    viewModel.filterUnits(type: 1, filter: greatString)
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    HStack{
                        Text("Цена меньше ")
                            .font(.system(size: CGFloat(fontSize)))
                        TextField("100", text: $greatString)
                            .font(.system(size: CGFloat(fontSize)))
                    }
                })
            }
            Section {
                Button(action: {
                    viewModel.filterUnits(type: 2, filter: lessString)
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    HStack{
                        Text("Цена больше ")
                            .font(.system(size: CGFloat(fontSize)))
                        TextField("0", text: $lessString)
                            .font(.system(size: CGFloat(fontSize)))
                    }
                })
            }
            Section {
                Button(action: {
                    viewModel.filterUnits(type: 3, filter: filterCategories[filterCategory])
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Фильтр по ")
                        .font(.system(size: CGFloat(fontSize)))
                })
                Picker("Категории", selection: $filterCategory) {
                    ForEach(filterCategories, id: \.self) {
                        Text($0)
                    }
                }
                .font(.system(size: CGFloat(fontSize)))
            }
            Section {
                Button(action: {
                    viewModel.filterUnits(type: 4, filter: String(favoutite))
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Toggle("Избранный", isOn: $favoutite)
                        .font(.system(size: CGFloat(fontSize)))
                })
            }
        }
        .environment(\.colorScheme, isDarkMode ? .dark : .light)
    }
}

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView(viewModel: unitViewModel())
    }
}
