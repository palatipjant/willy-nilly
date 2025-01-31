//
//  LinearPoster.swift
//  Willy Nilly
//
//  Created by Palatip Jantawong on 9/2/2567 BE.
//

import SwiftUI

struct LinearPoster: View {
    var body: some View {
        VStack{
            LinearGradient(colors: [.clear, .black], startPoint: .bottom, endPoint: .top)
                .frame(maxWidth: .infinity, maxHeight: 140)
            Spacer()
            LinearGradient(colors: [.clear, .black], startPoint: .top, endPoint: .bottom)
                .frame(maxWidth: .infinity, maxHeight: 190)
        }
    }
}

#Preview {
    LinearPoster()
}
