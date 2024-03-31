//
//  CategoryListView.swift
//  Willy Nilly
//
//  Created by Palatip Jantawong on 13/1/2567 BE.
//

import SwiftUI

struct CategoryListView: View {
    
    @EnvironmentObject var viewModel: apiViewModel
    var genre: Genre
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView{
            LazyVGrid(columns: columns) {
                ForEach(viewModel.MovieByGenre) {movie in
                    NavigationLink(destination: OverviewMovie(movie: movie)) {
                        MovieRemoteImage(urlString:
                                            "https://image.tmdb.org/t/p/w500\(movie.poster_path ?? "")" )
                            .frame(width: 110, height: 162.91)
                            .scaledToFill()
                            .background(Color(.label))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .contextMenu {
                                ContextMenuMovieCell(movie: movie)
                            }.scrollTransition { content, phase in
                                content
                                    .scaleEffect(phase.isIdentity ? 1 : 0.45)
                                    .blur(radius: phase.isIdentity ? 0 : 2.5)
                            }
                    }
                    .buttonStyle(FlatLinkStyle())
                }.padding(.vertical,10)
            }
        }
        .scrollIndicators(.hidden)
        .navigationBarTitle(genre.name)
        .task {
            viewModel.MovieByGenre.removeAll()
            viewModel.getMovieByGenre(genreID: String(genre.id), page: 1)
            viewModel.getMovieByGenre(genreID: String(genre.id), page: 2)
            viewModel.getMovieByGenre(genreID: String(genre.id), page: 3)
        }
    }
    
}

