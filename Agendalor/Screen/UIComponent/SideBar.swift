//
//  SideBar.swift
//  Agendalor
//
//  Created by 黒川良太 on 2024/10/30.
//

import SwiftUI

struct SideBar: View {
    let minutesList = [Minutes(title: "Mobile App デイリー", icon: "paperplane", createdAt: Date(), agenda: [Agenda(section: "評価制度の見直しについて", description: "色々かんがえたんですがやっぱり実力主義の方がいいのではないでしょうか？　いや，そんなことはない，わしゃあ年功序列がいいと思うんじゃぁ")]), Minutes(title: "本日のWeekly", icon: "paperplane", createdAt: Date(), agenda: [Agenda(section: "評価制度の見直しについて", description: "色々かんがえたんですがやっぱり実力主義の方がいいのではないでしょうか？　いや，そんなことはない，わしゃあ年功序列がいいと思うんじゃぁ")]), Minutes(title: "本日のWeekly", icon: "paperplane", createdAt: Date(), agenda: [Agenda(section: "評価制度の見直しについて", description: "色々かんがえたんですがやっぱり実力主義の方がいいのではないでしょうか？　いや，そんなことはない，わしゃあ年功序列がいいと思うんじゃぁ")])]
    
    var body: some View {
        NavigationStack {
            List(minutesList) { minutes in
                NavigationLink(destination: DetailScreen(minutes: minutes)) {
                    NavigationTile(title: minutes.title, systemImage: minutes.icon, createdAt: minutes.createdAt)
                }
            }
        }
    }
}

extension SideBar {
    struct NavigationTile: View {
        let title: String
        let systemImage: String
        let createdAt: Date
        
        var body: some View {
            VStack {
                HStack {
                    Image(systemName: systemImage)
                        .resizable()
                        .frame(width: 16, height: 16)
                    Text(title)
                        .font(.title3)
                        .fontWeight(.bold)
                        .lineLimit(2)
                        .padding(.leading, 16)
                    Spacer()
                }
                HStack {
                    Spacer()
                    Text(createdAt, style: .date)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .padding(.trailing, 10)
                        .lineLimit(1)
                        .truncationMode(.tail)
                        .padding(.bottom, 4)
                }
            }
        }
    }
}

struct SideBar_Previews: PreviewProvider {
    static var previews: some View {
        SideBar()
    }
}

