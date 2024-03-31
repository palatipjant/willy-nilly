//
//  TabHome.swift
//  Willy Nilly
//
//  Created by Palatip Jantawong on 12/1/2567 BE.
//

import SwiftUI

struct TabHome: View {
    var body: some View {
        TabView{
            HomeView()
                .tabItem { Label("Home", systemImage: "film") }
            DiscoverView()
                .tabItem { Label("Discover", systemImage: "rectangle.portrait.on.rectangle.portrait.angled.fill") }
            PersonView()
                .tabItem { Label("Cast", systemImage: "person.crop.rectangle.stack.fill") }
            MyListsView()
                .tabItem { Label("Lists", systemImage: "heart.circle") }
        }
    }
}

#Preview {
    TabHome()
        .environmentObject(apiViewModel())
        .preferredColorScheme(.dark)
}
