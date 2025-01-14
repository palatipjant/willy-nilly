//
//  OverviewMovie.swift
//  Willy Nilly
//
//  Created by Palatip Jantawong on 22/1/2567 BE.
//

import SwiftUI

struct OverviewMovie: View {
    
    @EnvironmentObject var viewModel: apiViewModel
    @State var isRead = false
    var movie: Movie
    
    var body: some View {
        ZStack(alignment: .bottom){
            
            if viewModel.isLoading {
                LoadingView()
            }
            GeometryReader{_ in
                ScrollView{
                    VStack{
                        MovieRemoteImage(urlString: "https://image.tmdb.org/t/p/w500\(movie.poster_path ?? "")" )
                            .bannerImage()
                            .overlay(content: { LinearPoster() })
                            .background(ScrollViewConfigurator { $0?.bounces = false })
                        
                        VStack(alignment: .leading, spacing: 20){
                            Text(viewModel.MovieDetail.title)
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .multilineTextAlignment(.leading)
                                .padding(.horizontal)
                            
                            Detail(movieDetail: viewModel.MovieDetail)
                            
                            VStack(alignment: .leading, spacing: 3) {
                                Text(viewModel.MovieDetail.overview ?? "")
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(isRead ? 30 : 4)
                                    .onTapGesture {
                                        isRead.toggle()
                                    }
                            }
                            .font(.system(size: 16, weight: .regular))
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
                            .padding()
                            .multilineTextAlignment(.leading)
                            
                            if !viewModel.MovieCredits.isEmpty{
                                HorizonCastView(titleView: "Top Billed Cast", cast: viewModel.MovieCredits)
                            }
                            if !viewModel.movieImage.isEmpty{
                                MovieImage(movieImage: viewModel.movieImage)
                            }
                            if !viewModel.MovieReview.isEmpty{
                                ReviewCard(movie_review: viewModel.MovieReview)
                            }
                            if !viewModel.MovieSimilar.isEmpty{
                                HorizonScrollView(titleView: "Similar", movie_api: viewModel.MovieSimilar)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .offset(y: -150)
                    }
                    
                }
                .scrollIndicators(.hidden)
                .toolbarBackground(.hidden, for: .navigationBar)
            }
        }
        .task {
            viewModel.getMovieDetail(movieID: String(movie.id))
            viewModel.getMovieSimilar(movieID: String(movie.id))
            viewModel.getMovieCredits(movieID: String(movie.id))
            viewModel.MovieReview.removeAll()
            viewModel.getMovieReview(movieID: String(movie.id))
            viewModel.getMovieImage(id: movie.id)
        }
        .ignoresSafeArea(edges: .top)
        .alert(item: $viewModel.alertItem) { alert in
            Alert(title: alert.title,
                  message: alert.message,
                  dismissButton: alert.dismissButton)
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                LikeButton(movie: movie)
            }
        }
    }
}

#Preview {
    OverviewMovie(movie: Mockdata.sampledata)
        .environment(apiViewModel())
        .preferredColorScheme(.dark)
}

struct Detail: View {
    
    var movieDetail: MovieDetail
    
    var body: some View {
        VStack{
            HStack{
                Capsule()
                    .fill(.blendMode(.multiply))
                    .strokeBorder(.white, lineWidth: 1)
                    .frame(width: 60, height: 25)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .opacity(0.6)
                    .overlay {
                        HStack{
                            Image(systemName: "star.fill")
                                .resizable()
                                .foregroundStyle(.yellow)
                                .frame(width: 12, height: 12)
                            Text("\(movieDetail.vote_average, specifier: "%.2f")")
                                .fontWeight(.medium)
                                .font(.system(size: 12))
                        }
                    }
                Capsule()
                    .fill(.blendMode(.multiply))
                    .strokeBorder(.white, lineWidth: 1)
                    .frame(width: 35, height: 25)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .opacity(0.6)
                    .overlay {
                        Text("\(movieDetail.original_language.uppercased())")
                            .fontWeight(.medium)
                            .font(.system(size: 12))
                    }
                Capsule()
                    .fill(.blendMode(.multiply))
                    .strokeBorder(.white, lineWidth: 1)
                    .frame(width: 50, height: 25)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .opacity(0.6)
                    .overlay {
                        Text("\(movieDetail.runtime) M")
                            .fontWeight(.medium)
                            .font(.system(size: 12))
                    }
                Capsule()
                    .fill(.blendMode(.multiply))
                    .strokeBorder(.white, lineWidth: 1)
                    .frame(width: 95, height: 25)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .opacity(0.6)
                    .overlay {
                        Text("\(movieDetail.release_date)")
                            .fontWeight(.medium)
                            .font(.system(size: 12))
                    }
            }
        }.padding(.leading)
    }
}
