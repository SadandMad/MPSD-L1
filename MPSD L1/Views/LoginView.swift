//
//  ContentView.swift
//  MPSD L1
//
//  Created by Евгений on 21/5/21.
//

import SwiftUI
import Combine

struct LoginView: View {
    @StateObject var viewModel: unitViewModel = unitViewModel()
    @AppStorage("isDarkMode") private var isDarkMode = false
    @AppStorage("fontSize") private var fontSize = 12
    @State private var registration = false
    @State private var registrated = false
    @State var login: String = ""
    @State var password: String = ""
    
    var body: some View {
        NavigationView {
            VStack{
                Divider()
                TextField("Логин", text: $login)
                    .font(.system(size: CGFloat(fontSize), weight: .semibold, design: .default))
                    .offset(x: 50, y: -5)
                TextField("Пароль", text: $password).offset(x: 50, y: 5)
                    .font(.system(size: CGFloat(fontSize), weight: .semibold, design: .default))
                    .keyboardType(.numberPad)
                    .onReceive(Just(password)) {
                        newValue in let filtered = newValue.filter { "0123456789".contains($0) }
                        if filtered != newValue {
                            self.password = filtered
                        }
                    }
                Divider()
                Button(action: {
                    if (viewModel.unitAuth(login: login, password: password)) {
                        registrated = true
                        registration = false
                        
                    } else {
                        registrated = false
                        registration = true
                    }
                }) {
                    Text("Авторизация")
                        .font(.system(size: CGFloat(fontSize+4), weight: .bold, design: .default))
                }.onAppear() {
                    self.viewModel.getUnits()
                }
                .padding(.top)
                Button(action: {
                    registrated = false
                    login = ""
                    password = ""
                }) {
                    Text("Выйти")
                        .font(.system(size: CGFloat(fontSize+4), weight: .bold, design: .default))
                }
                .padding(.top)
                NavigationLink(
                    destination: MainView(viewModel: viewModel, registrated: $registrated),
                    isActive: $registrated
                ) {
                    EmptyView()
                }
                .navigationBarTitle("Главная")
                .navigationBarItems(trailing:
                                        Button(action: {
                                            self.registration.toggle()
                                        }) {
                                            Text("Регистрация")
                                                .font(.system(size: CGFloat(fontSize+4), weight: .bold, design: .default))
                                        }
                    .sheet(isPresented: $registration) {
                        RegView(viewModel: viewModel, login: $login, password: $password)
                    }
                )
            }
        }
        .environment(\.colorScheme, isDarkMode ? .dark : .light)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
