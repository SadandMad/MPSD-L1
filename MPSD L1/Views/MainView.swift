//
//  UnitsView.swift
//  MPSD L1
//
//  Created by Евгений on 25/5/21.
//

import SwiftUI

struct MainView : View{
    @State private var selectedView = 1
    @ObservedObject var viewModel: unitViewModel
    @AppStorage("isDarkMode") private var isDarkMode = false
    @AppStorage("fontSize") private var fontSize = 12
    @State private var filter = false
    @Binding var registrated: Bool
    
    var body: some View {
        TabView(selection: $selectedView) {
            UnitsView(viewModel: viewModel)
                .tabItem {
                    Image(systemName: "list.dash")
                    Text("Юниты")
                        .font(.system(size: CGFloat(fontSize), weight: .semibold, design: .default))
                }.tag(1)
            UnitsView(viewModel: viewModel)
                .tabItem {
                    Image(systemName: "increase.indent")
                    Text("Фильтр")
                        .font(.system(size: CGFloat(fontSize), weight: .semibold, design: .default))
                }.tag(2)
            MapView(viewModel: viewModel)
                .tabItem {
                    Image(systemName: "map")
                    Text("Карта")
                        .font(.system(size: CGFloat(fontSize), weight: .semibold, design: .default))
                }.tag(3)
            SettingsView(viewModel: viewModel, registrated: $registrated)
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("Настройки")
                        .font(.system(size: CGFloat(fontSize), weight: .semibold, design: .default))
                }.tag(4)
        }
        .onChange(of: selectedView, perform: { value in
            if selectedView == 2 {
                filter = true
                selectedView = 0
            } else {
                viewModel.getUnits()
            }
        })
        .sheet(isPresented: $filter) {
            FilterView(viewModel: viewModel)
        }
        .environment(\.colorScheme, isDarkMode ? .dark : .light)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(viewModel: unitViewModel(), registrated: .constant(true))
    }
}
