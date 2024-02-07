//
//  OverviewMovie.swift
//  Willy Nilly
//
//  Created by Palatip Jantawong on 22/1/2567 BE.
//

import SwiftUI
import Kingfisher

struct OverviewMovie: View {
    var NewMovie: Movie
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack{
                    if let url = NewMovie.posterURL {
                        KFImage(url)
                            .resizable()
                            .frame(maxWidth: .infinity, maxHeight: 1100)
                            .scaledToFill()
                            .background(Color(.label))
                            .ignoresSafeArea()
                    }
                    
                    VStack(alignment: .leading, spacing: 20){
                        Text(NewMovie.overview ?? "Overview Error. Please Try again later." )
                            .fontWeight(.regular)
                            .font(.system(size: 16))
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
                            .padding()
                            .multilineTextAlignment(.leading)
                    }.frame(maxWidth: .infinity)
                    Spacer()
                }
            }
            .navigationTitle(NewMovie.title)
        }
    }
}

#Preview {
    OverviewMovie(NewMovie: Movie(id: 321, title: "fee", poster_path: "/vdpE5pjJVql5aD6pnzRqlFmgxXf.jpg", overview: "Test Mock Data Overview"))
}
