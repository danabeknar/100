//
//  CardView.swift
//  Flashzilla
//
//  Created by Beknar Danabek on 23.05.21.
//

import SwiftUI

struct CardView: View {
    let card: Card
    var removal: ((_ isRight: Bool) -> Void)? = nil
    
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @State private var isShowingAnswer = false
    @State private var offset = CGSize.zero
    @State private var feedback = UINotificationFeedbackGenerator()
    @Environment(\.accessibilityEnabled) var accessibilityEnabled
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(
                    differentiateWithoutColor
                        ? Color.white
                        : Color.white
                            .opacity(1 - Double(abs(offset.width / 50)))

                )
                .background(
                    differentiateWithoutColor
                        ? nil
                        : RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .fill(color(for: offset.width))
                )
                .shadow(radius: 10)
            
            VStack {
                if accessibilityEnabled {
                    Text(isShowingAnswer ? card.answer : card.prompt)
                        .font(.largeTitle)
                        .foregroundColor(.black)
                } else {
                    Text(card.prompt)
                        .font(.largeTitle)
                        .foregroundColor(.black)

                    if isShowingAnswer {
                        Text(card.answer)
                            .font(.title)
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding(20)
            .multilineTextAlignment(.center)
        }
        .frame(width: 450, height: 250)
        .rotationEffect(.degrees(Double(offset.width / 5)))
        .offset(x: offset.width * 5, y: 0)
        .opacity(2 - Double(abs(offset.width / 50)))
        .accessibility(addTraits: .isButton)
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    self.offset = gesture.translation
                    feedback.prepare()
                }
            
                .onEnded { _ in
                    if abs(offset.width) > 100 {
                        if offset.width > 0 {
                            feedback.notificationOccurred(.success)
                        } else {
                            feedback.notificationOccurred(.error)
                        }
                        
                        removal?(offset.width > 0)
                    } else {
                        self.offset = .zero
                    }
                }
        )
        .onTapGesture {
            isShowingAnswer.toggle()
        }
        .animation(.spring())
    }
    
    func color(for offset: CGFloat) -> Color {
        switch offset {
        case let a where a > 0:
            return .green
        case let b where b < 0:
            return .red
        default:
            return .white
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card.example)
    }
}
