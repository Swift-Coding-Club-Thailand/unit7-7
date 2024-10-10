//
//  QuizView.swift
//  chapter-7-7-template
//
//  Created by Sanpawat Sewsuwan on 30/6/2567 BE.
//

import SwiftUI
import Observation

enum Result {
    case correct
    case wrong
    case none
}

enum AnimationPhase: CaseIterable {
    case fadingIn
    case staying
    case tilting
    case zoomingOut
    
    var scale: CGFloat {
        switch self {
        case .fadingIn:
            return 0
        case .staying:
            return 1.5
        case .tilting:
            return 1.5
        case .zoomingOut:
            return 2.5
        }
    }
    
    var opacity: CGFloat {
        switch self {
        case .fadingIn:
            return 0
        case .staying:
            return 1
        case .tilting:
            return 1
        case .zoomingOut:
            return 0
        }
    }
    
    var rotationEffect: Angle {
        switch self {
        case .fadingIn:
            return Angle.zero
        case .staying:
            return Angle.zero
        case .tilting:
            return Angle.degrees(-25)
        case .zoomingOut:
            return Angle.degrees(-25)
        }
    }
}

struct QuizView: View {
    
    @Binding var quizes: [Quiz]
    @State private var currentQuiz: Int = 0
    @State private var result: Result = .none
    @State private var submitAnswer: Int = 0
    @State private var score: Int = 0
    @State private var isEnded: Bool = false
    
    var resultImageName: String {
        get {
            switch result {
            case .correct:
                return "hand.thumbsup.circle.fill"
            case .wrong:
                return "hand.thumbsdown.circle.fill"
            case .none:
                return ""
            }
        }
    }
    
    var resultImageColor: Color {
        get {
            switch result {
            case .correct:
                return Color.green
            case .wrong:
                return Color.red
            case .none:
                return Color.clear
            }
        }
    }
    
    var body: some View {
        ZStack {
            Color.darkCyan
                .ignoresSafeArea()

            /// แสดงชุดคำถามและคำตอบ
            VStack {
                Spacer()
                
                VStack(alignment: .leading) {
                    Text("Question \(currentQuiz + 1)")
                        .foregroundStyle(Color.white)
                        .font(.title3)
                    
                    Text(quizes[currentQuiz].question)
                        .foregroundStyle(Color.white)
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.bottom, 20)
                    
                    VStack(spacing: 18) {
                        ForEach(quizes[currentQuiz].choices) { choice in
                            let backgroundColor = choice.isSelected ? Color.brightOrange : Color.white
                            let foregroundColor = choice.isSelected ? Color.white : Color.darkCyan
                            let scale = choice.isSelected ? CGSize(width: 1.05, height: 1.05) : CGSize(width: 1, height: 1)
                            
                            Text(choice.title)
                                .frame(maxWidth: .infinity, minHeight: 80)
                                .background(backgroundColor)
                                .foregroundStyle(foregroundColor)
                                .font(.title2)
                                .fontWeight(.semibold)
                                .clipShape(.rect(cornerRadius: 12))
                                .scaleEffect(scale)
                                .onTapGesture {
                                    withAnimation {
                                        quizes[currentQuiz].choices.forEach { $0.isSelected = false }
                                        choice.isSelected = true
                                    }
                                }
                        }
                    }
                    
            
                    Spacer()
                    
                    Button(action: {
                        if let selectedChoice = quizes[currentQuiz].choices.first(where: { $0.isSelected }) {
                            
                            if selectedChoice.isAnswered {
                                result = .correct
                                score += 1
                            } else {
                                result = .wrong
                            }
                            
                            submitAnswer += 1
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                quizes[currentQuiz].choices.first(where: { $0.isSelected })?.isSelected = false
                                
                                if currentQuiz < quizes.count - 1 {
                                    currentQuiz += 1
                                } else {
                                    withAnimation {
                                        isEnded = true
                                    }
                                }
                                
                                result = .none
                            }
                        }
                    }, label: {
                        Text("Submit")
                            .frame(maxWidth: .infinity, minHeight: 80)
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.white)
                            .background(Color.darkBlue)
                            .clipShape(.capsule)
                    })
                }
                .padding([.leading, .trailing], 26)
                
                Spacer()
            }
            
            ZStack {
                Circle()
                    .frame(width: 130, height: 130)
                    .foregroundStyle(result == .none ? .clear : Color.white)
                Image(systemName: resultImageName)
                    .resizable()
                    .frame(width: 120, height: 120)
                    .foregroundStyle(resultImageColor)
            }
            .opacity(result == .none ? 0 : 1)
            .phaseAnimator(AnimationPhase.allCases, trigger: submitAnswer) { content, phase in
                content
                    .scaleEffect(phase.scale)
                    .opacity(phase.opacity)
                    .rotationEffect(phase.rotationEffect)
            } animation: { phase in
                switch phase {
                case .fadingIn: .easeIn
                default: .bouncy
                }
            }
            
            ZStack {
                Color.black.opacity(0.6)
                    .ignoresSafeArea()
                
                VStack {
                    Text("Finished")
                        .foregroundStyle(Color.white)
                        .font(.system(size: 40))
                        .fontWeight(.semibold)
                    
                    ZStack {
                        Circle()
                            .frame(width: 200, height: 200)
                            .foregroundStyle(Color.brightOrange)
                        
                        VStack {
                            Text("Score")
                                .foregroundStyle(Color.pureOrange)
                                .font(.system(size: 30))
                                .fontWeight(.semibold)
                            Text("\(score)")
                                .foregroundStyle(Color.white)
                                .font(.system(size: 80))
                                .fontWeight(.bold)
                        }
                    }
                    
                    Button(action: {
                        withAnimation {
                            isEnded = false
                        } completion: {
                            score = 0
                            currentQuiz = 0
                        }
                        result = .none
                    }, label: {
                        Text("Test Again")
                            .frame(width: 160, height: 60)
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.white)
                            .background(Color.darkBlue)
                            .clipShape(.capsule)
                    })
                }
            }
            .opacity(isEnded ? 1 : 0)
        }
    }
}

#Preview {
    HomePage()
}

