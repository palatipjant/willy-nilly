//
//  MovieImage.swift
//  Willy Nilly
//
//  Created by Palatip Jantawong on 7/4/2567 BE.
//

import SwiftUI

struct MovieImage: View {
    
    @EnvironmentObject var viewModel: apiViewModel
    var movieImage: [backdrop]
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Text("Images")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.leading, 20)
                Spacer()
            }
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack{
                    ForEach(viewModel.movieImage, id: \.file_path) {image in
                        MovieRemoteImage(urlString: "https://image.tmdb.org/t/p/w500\(image.file_path ?? "")" )
                            .frame(width: 265, height: 170)
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .scrollTransition { content, phase in
                                content
                                    .scaleEffect(phase.isIdentity ? 1 : 0.85)
                                    .blur(radius: phase.isIdentity ? 0 : 2.5)
                            }
                            .aspectRatio(1, contentMode: .fit)
                    }
                    .padding(.leading, 11)
                }
                .frame(height: 180)
                .scrollTargetLayout()
            }
            .padding(.top, -10)
            .scrollTargetBehavior(.viewAligned)
            .safeAreaPadding(.horizontal, 10)
        }
    }
}

#Preview {
    MovieImage(movieImage: [backdrop(file_path: "/vq2b2VCfQ5rhyypjejPoWCYnagq.jpg", vote_average: 5.172)])
        .environmentObject(apiViewModel())
        .preferredColorScheme(.dark)
}
