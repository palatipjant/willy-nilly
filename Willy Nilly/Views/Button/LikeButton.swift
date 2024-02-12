//
//  LikeButton.swift
//  Willy Nilly
//
//  Created by Palatip Jantawong on 10/2/2567 BE.
//

import SwiftUI
import ConfettiSwiftUI

struct LikeButton: View{
    
    @State private var confetti = 0
    @State private var likeClick = false
    
    var body: some View {
        Button(action: {
            likeClick.toggle()
            confetti += 1
        }, label: {
            Circle()
                .fill(.white)
                .shadow(radius: 5)
                .frame(width: 50, height: 50)
                .overlay {
                    Image(systemName: likeClick ? "heart.fill" : "heart")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(likeClick ? .red : .black)
                }
                .tint(likeClick ? .red : .gray)
        })
        .buttonStyle(LikeEffectButtonStyle(confetti: $confetti, emoji1: "🎬", emoji2: "🍿", emoji3: "🍷", emoji4: "❤️"))
    }
}

struct LikeEffectButtonStyle: ButtonStyle {
    
    @Binding var confetti: Int
    var emoji1: String
    var emoji2: String
    var emoji3: String
    var emoji4: String
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.7 : 1.0)
            .opacity(configuration.isPressed ? 0.6 : 1.0)
            .animation(.easeInOut, value: configuration.isPressed)
            .confettiCannon(counter: $confetti,
                            confettis: [.text(emoji1 ), .text(emoji2 ), .text(emoji3 ), .text(emoji4 )],
                            confettiSize: 20,
                            radius: 220)
    }
}


#Preview {
    LikeButton()
}
