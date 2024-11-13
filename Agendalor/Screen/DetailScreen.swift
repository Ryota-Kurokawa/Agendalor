//
//  DetailScreen.swift
//  Agendalor
//
//  Created by 黒川良太 on 2024/11/03.
//

import SwiftUI

struct DetailScreen: View {
    let minutes: Minutes
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack {
                    Text(minutes.title)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .underline()
                        .padding()
                    Spacer()
                    Image(systemName: minutes.icon)
                        .font(.title3)
                        .padding()
                        .navigationBarTitleDisplayMode(.inline)
                        .padding()
                }
                Divider()
                    .shadow(radius: 32)
                ScrollView {
                    ForEach(minutes.agenda, id: \.self) { agenda in
                        VStack {
                            HStack {
                                Text(agenda.section)
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                    .underline()
                                    .opacity(0.9)
                                    .padding()
                            }
                            Text(agenda.description)
                                .font(.body)
                                .padding()
                        }
                    }
                }
                .frame(width: geometry.size.width * 0.9)
            }
        }
    }
}

#Preview {
    DetailScreen(minutes: Minutes(title: "本日のWeekly", icon: "paperplane", createdAt: Date(), agenda: [Agenda(section: "評価制度の見直しについて", description: "色々かんがえたんですがやっぱり実力主義の方がいいのではないでしょうか？　いや，そんなことはない，わしゃあ年功序列がいいと思うんじゃぁ"), Agenda(section: "退職金制度の見直しについて", description: "わしゃ，これまで頑張ってきたぞい，なんじゃこれはぁ？！")]))
}
