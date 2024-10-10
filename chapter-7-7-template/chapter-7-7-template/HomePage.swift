//
//  HomePage.swift
//  chapter-7-7-template
//
//  Created by Sanpawat Sewsuwan on 30/6/2567 BE.
//

import SwiftUI

struct HomePage: View {

    @State private var quizes: [Quiz] = [
        Quiz(question: "Is cat a mammal?", choices: [
            Choice(title: "Yes", isAnswered: true),
            Choice(title: "No", isAnswered: false)
        ]),
        Quiz(question: "What is the color of apple?", choices: [
            Choice(title: "Blue", isAnswered: false),
            Choice(title: "Yellow", isAnswered: false),
            Choice(title: "Red", isAnswered: true)
        ])
    ]

    var body: some View {
        ZStack {
            Color.darkCyan
                .ignoresSafeArea()

            VStack {
                HStack {
                    Text("My Quiz")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.brightOrange)
                        .padding(.leading)
                    
                    Spacer()
                    
                    Button(action: {
                        
                    }, label: {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 35, height: 35)
                            .foregroundStyle(Color.brightOrange)
                            .padding(.trailing)
                    })
                }

                Spacer()

                Button(action: {

                }, label: {
                    Text("Start")
                        .frame(width: 300, height: 65)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.white)
                        .background(Color.darkBlue)
                        .clipShape(.capsule)
                })
            }
        }
    }

}

#Preview {
    HomePage()
}
