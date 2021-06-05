//
//  MapView.swift
//  MPSD L1
//
//  Created by Евгений on 25/5/21.
//

import SwiftUI
import MapKit

struct MapView : View{
    @AppStorage("isDarkMode") private var isDarkMode = false
    @ObservedObject var viewModel: unitViewModel = unitViewModel()
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 53.8800, longitude: 27.5600), span: MKCoordinateSpan(latitudeDelta: 0.20, longitudeDelta: 0.20))
    @State private var showingUnitInfo = false
    @State private var unit: Unit = Unit()
    
    var body: some View {
        Map(coordinateRegion: $region, annotationItems: self.viewModel.units) { place in
            MapAnnotation(coordinate: place.coordinate) {
                Button (action: {
                    unit = place
                    showingUnitInfo.toggle()
                }) {
                    VStack {
                        Image(systemName: "hand.point.down.fill")
                            .frame(width: 30.0, height: 30.0)
                        Circle()
                            .strokeBorder(Color.red, lineWidth: 1)
                            .frame(width: 8.0, height: 8.0)
                    }
                    .foregroundColor(.red)
                }
            }
        }
        .sheet(isPresented: $showingUnitInfo) {
            UnitView(unit: $unit)
        }
        .ignoresSafeArea(.all)
        .environment(\.colorScheme, isDarkMode ? .dark : .light)
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(viewModel: unitViewModel())
    }
}
