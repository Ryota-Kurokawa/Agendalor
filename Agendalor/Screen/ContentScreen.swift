//
//  ContentScreen.swift
//  Agendalor
//
//  Created by 黒川良太 on 2024/10/30.
//

import SwiftUI

struct ContentScreen: View {
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            let sideBarWidth: CGFloat = 320
            
            ZStack(alignment: .leading) {
                SideBar()
                    .frame(width: sideBarWidth)
                    .background(Color(.systemGray6))
            }
        }
    }
}

#Preview {
    ContentScreen()
}
