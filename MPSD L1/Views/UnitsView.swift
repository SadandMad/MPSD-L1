//
//  UnitsView.swift
//  MPSD L1
//
//  Created by Евгений on 25/5/21.
//

import SwiftUI

struct UnitsView: View {
    @ObservedObject var viewModel: unitViewModel
    @AppStorage("isDarkMode") private var isDarkMode = false
    @AppStorage("fontSize") private var fontSize = 12
    @State private var showingUnitInfo = false
    @State private var infoUnit: Unit = Unit()
    let layout = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        /*List(viewModel.units) { unit in
            VStack(alignment: .leading) {
                Text(unit.name)
                    .font(.system(size: CGFloat(fontSize+4), weight: .semibold, design: .default))
                Text(unit.shortDesk)
                    .font(.system(size: CGFloat(fontSize), weight: .semibold, design: .default))
                Text(String(unit.price))
                    .font(.system(size: CGFloat(fontSize+2), weight: .semibold, design: .default))
            }
            .onTapGesture {
                infoUnit = unit
                showingUnitInfo.toggle()
            }
        }
        .sheet(isPresented: $showingUnitInfo) {
            UnitView(unit: $infoUnit)
        }
        .navigationBarTitle("Юниты")*/
        ScrollView {
            LazyVGrid(columns: layout, spacing: 10) {
                ForEach(viewModel.units) { unit in
                    VStack {
                        Text(unit.name)
                            .font(.system(size: CGFloat(fontSize+4), weight: .semibold, design: .default))
                        Text(unit.shortDesk)
                            .font(.system(size: CGFloat(fontSize), weight: .semibold, design: .default))
                        Text(String(unit.price))
                            .font(.system(size: CGFloat(fontSize+2), weight: .semibold, design: .default))
                    }
                    .onTapGesture {
                        infoUnit = unit
                        showingUnitInfo.toggle()
                    }
                }
            }
            .sheet(isPresented: $showingUnitInfo) {
                UnitView(unit: $infoUnit)
            }
            .navigationBarTitle("Юниты")
        }
    }
}

struct UnitsView_Previews: PreviewProvider {
    static var previews: some View {
        UnitsView(viewModel: unitViewModel())
    }
}
