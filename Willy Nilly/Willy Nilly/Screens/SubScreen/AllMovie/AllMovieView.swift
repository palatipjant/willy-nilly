//
//  AllMovieView.swift
//  Willy Nilly
//
//  Created by Palatip Jantawong on 8/2/2567 BE.
//

import SwiftUI

struct AllMovieView: View {
    
    var movie: [Movie]
    var titleView: String
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        ScrollView{
            LazyVGrid(columns: columns) {
                ForEach(movie) {movie in
                    NavigationLink(destination: OverviewMovie(movie: movie)) {
                        MovieRemoteImage(urlString:
                                            "https://image.tmdb.org/t/p/w500\(movie.poster_path ?? "")" )
                        .frame(width: 110, height: 162.91)
                        .scaledToFill()
                        .background(Color(.label))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .scrollTransition { content, phase in
                            content
                                .scaleEffect(phase.isIdentity ? 1 : 0.45)
                                .blur(radius: phase.isIdentity ? 0 : 2.5)
                        }
                        .contextMenu {
                            ContextMenuMovieCell(movie: movie)
                        }
                        
                    }
                    .buttonStyle(FlatLinkStyle())
                }.padding(.vertical,10)
            }
        }
        .navigationTitle(titleView)
    }
}

#Preview {
    AllMovieView(movie: Mockdata.movielist, titleView: "Trending")
}
