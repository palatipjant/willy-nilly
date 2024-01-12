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
                .tabItem {
                Image(systemName: "house.fill")
                Text("Home")
            }
            CategoryView()
                .tabItem {
                    Image(systemName: "books.vertical.fill")
                    Text("Category")
                }
        }
    }
}

#Preview {
    TabHome()
}
