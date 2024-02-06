//
//  HomeView.swift
//  Willy Nilly
//
//  Created by Palatip Jantawong on 12/1/2567 BE.
//

import SwiftUI
import Kingfisher

struct HomeView: View {
    @StateObject var viewModel = AppetizerListViewMedel()
    @State private var NewMovies: [NewMovie1] = []
    var body: some View {
        NavigationStack{
            ScrollView{
                PoppularBanner()
                HorizonScrollView(titleView: "New Release", movie_api: viewModel.appetizers)
                    .offset(y: -120)
            }
            .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        HStack {
                            Image(systemName: "popcorn.fill")
                                .symbolRenderingMode(.multicolor)
//                            Text("Willy Nilly")
//                                .font(.title2)
//                                .fontWeight(.bold)
                        }
                    }
                }
            .scrollIndicators(.hidden)
            
        }
        .task {
            viewModel.getAppetizers()
        }
    }
//    func fetchNewMovies() {
//        NewMovieNetworking.fetchNewMovies { result in
//            switch result {
//            case .success(let movies):
//                self.NewMovies = movies
//            case .failure(let error):
//                print("Error: \(error.localizedDescription)")
//            }
//        }
//    }
}
//
//#Preview {
//    HomeView(NewMovies: [NewMovie(id: 753342, title: "dssa", poster_path: "/jE5o7y9K6pZtWNNMEw3IdpHuncR.jpg")], PopMovies: [PopMovie(id: 753342, title: "dssa", posterPath: "/jE5o7y9K6pZtWNNMEw3IdpHuncR.jpg", overview: "Fee test api", mediaType: "TV")])
//}
