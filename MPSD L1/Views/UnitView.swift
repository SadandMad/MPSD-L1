//
//  UnitView.swift
//  MPSD L1
//
//  Created by Евгений on 25/5/21.
//

import SwiftUI
import AVKit

struct UnitView: View {
    @Binding var unit: Unit
    @AppStorage("isDarkMode") private var isDarkMode = false
    @AppStorage("fontSize") private var fontSize = 12
    @StateObject var viewModel: imageViewModel = imageViewModel()
    
    var body: some View {
        Form {
            Section {
                HStack {
                    Spacer()
                    if viewModel.image != nil {
                        Image(uiImage: viewModel.image!)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 250.0, height: 200.0, alignment: .top)
                            .clipShape(RoundedRectangle(cornerRadius: 25))
                    } else {
                        Image(systemName: "timelapse")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300.0, height: 200.0, alignment: .top)
                    }
                    Spacer()
                }
            }
            Section {
                Text(unit.name)
                    .font(.system(size: CGFloat(fontSize+4), weight: .semibold, design: .default))
                Text(String(unit.price))
                    .font(.system(size: CGFloat(fontSize+4), weight: .semibold, design: .default))
                Text(unit.category)
                    .font(.system(size: CGFloat(fontSize), weight: .semibold, design: .default))
                Text(unit.shortDesk)
                    .font(.system(size: CGFloat(fontSize-2), weight: .light, design: .default))
                Text(unit.longDesk)
                    .font(.system(size: CGFloat(fontSize-4), weight: .ultraLight, design: .default))
            }
            Section {
                Text(String(unit.latitude))
                    .font(.system(size: CGFloat(fontSize), weight: .semibold, design: .default))
                Text(String(unit.longitude))
                    .font(.system(size: CGFloat(fontSize), weight: .semibold, design: .default))
            }
            Section {
                if unit.videoName != nil {
                    let player = AVPlayer(url: URL(string: unit.videoName!)!)
                    VideoPlayer(player: player)
                        .onAppear() {
                            player.play()
                        }
                        .frame(height: 250)
                }
            }
        }
        .onAppear() {
            viewModel.getImage(name: unit.imageName ?? "")
        }
        .environment(\.colorScheme, isDarkMode ? .dark : .light)
    }
}

struct UnitView_Previews: PreviewProvider {
    static var previews: some View {
        UnitView(unit: .constant(Unit(name: "Abaddon", shortDesk: "AAaAaaA", category: "Elites")))
    }
}
