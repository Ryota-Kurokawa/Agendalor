//
//  SideBar.swift
//  Agendalor
//
//  Created by 黒川良太 on 2024/10/30.
//

import SwiftUI

struct SideBar: View {
    let minutesList: [Minutes] = [Minutes(title: "Meeting 1", icon: "calendar", createdAt: Date(), agenda: []),
                                  Minutes(title: "Meeting 2", icon: "calendar", createdAt: Date(), agenda: []),
                                  Minutes(title: "Meeting 3", icon: "calendar", createdAt: Date(), agenda: []),
                                  Minutes(title: "Meeting 4", icon: "calendar", createdAt: Date(), agenda: []),
                                  Minutes(title: "Meeting 5", icon: "calendar", createdAt: Date(), agenda: []),
                                  Minutes(title: "Meeting 6", icon: "calendar", createdAt: Date(), agenda: []),
                                  Minutes(title: "Meeting 7", icon: "calendar", createdAt: Date(), agenda: []),
                                  Minutes(title: "Meeting 8", icon: "calendar", createdAt: Date(), agenda: []),
                                  Minutes(title: "Meeting 9", icon: "calendar", createdAt: Date(), agenda: []),
                                  Minutes(title: "Meeting 10", icon: "calendar", createdAt: Date(), agenda: []),
                                  Minutes(title: "Meeting 11", icon: "calendar", createdAt: Date(), agenda: []),
                                  Minutes(title: "Meeting 12", icon: "calendar", createdAt: Date(), agenda: []),
                                  Minutes(title: "Meeting 13", icon: "calendar", createdAt: Date(), agenda: []),
                                  Minutes(title: "Meeting 14", icon: "calendar", createdAt: Date(), agenda: []),
                                  Minutes(title: "Meeting 15", icon: "calendar", createdAt: Date(), agenda: []),
                                  Minutes(title: "Meeting 16", icon: "calendar", createdAt: Date(), agenda: []),
                                  Minutes(title: "Meeting 17", icon: "calendar", createdAt: Date(), agenda: []),
                                  Minutes(title: "Meeting 18", icon: "calendar", createdAt: Date(), agenda: []),
                                  Minutes(title: "Meeting 19", icon: "calendar", createdAt: Date(), agenda: []),
                                  Minutes(title: "Meeting 20", icon: "calendar", createdAt: Date(), agenda: [])]
    
    var body: some View {
        NavigationStack {
            List(minutesList) { minutes in
                NavigationTile(title: minutes.title, systemImage: minutes.icon, createdAt: minutes.createdAt)
            }
            .navigationTitle("Agendalor")
        }
    }
}

extension SideBar {
    struct NavigationTile: View {
        let title: String
        let systemImage: String
        let createdAt: Date
        
        var body: some View {
            HStack {
                Image(systemName: systemImage)
                    .resizable()
                    .frame(width: 20, height: 20)
                Text(title)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .lineLimit(2)
                    .padding(.leading, 16)
                Spacer()
                VStack {
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
            .padding(.vertical, 8)
        }
    }
}

struct SideBar_Previews: PreviewProvider {
    static var previews: some View {
        SideBar()
    }
}

