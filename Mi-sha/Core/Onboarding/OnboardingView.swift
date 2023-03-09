//
//  OnboardingView.swift
//  BootCamp
//
//  Created by MM on 22.12.2022.
//

import SwiftUI

struct OnboardingView: View {
    //Onboarding state
    /*
     0 - Welcome screen
     1 - Add name
     2 - Add age
     3 - Add gender
     */
    @State var onboardingState: Int = 0
    @AppStorage("signed_in") var currentUserSignedIn: Bool = false
    let transition: AnyTransition = .asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading))
    var body: some View {
        ZStack {
//            RadialGradient(
//                gradient: Gradient(colors: [Color.theme.main, Color.theme.main2]),
//                center: .topLeading, startRadius: 200, endRadius: 600)
            Color.theme.gradient
                .ignoresSafeArea()
            VStack {
                switch onboardingState {
                case 0:
                    welcomeSection
                        .transition(transition)
                case 1:
                    welcomeSection1
                        .transition(transition)
                case 2:
                    welcomeSection2
                        .transition(transition)
                default:
                    welcomeSection
                }
                
                Spacer()
                bottomButton
            }
            
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}

// MARK: Components

extension OnboardingView {
    
    private var welcomeSection: some View {
        VStack(spacing: 36) {
            Spacer()
            logoView
//            LogoView()
//                .frame(width: 150, height: 150)
//                .cornerRadius(10)
            Text("Привет!")
                .font(.largeTitle)
                .fontWeight(.medium)
                .foregroundColor(.black.opacity(0.7))
            Text("Медитативное путешествие по твоему сознанию. В компании девочки Ми и её собачки Ша.")
//                .font(.callout)
                .font(.labGrotesque(.regular, size: 18))
                .foregroundColor(.black)
                .padding(.horizontal, 36)
            Spacer()
            Spacer()
        }
        .multilineTextAlignment(.center)
    }
    private var welcomeSection1: some View {
        VStack(spacing: 36) {
            Spacer()
            LogoView()
                .frame(width: 150, height: 150)
                .cornerRadius(10)
            Text("Зачем?")
                .font(.largeTitle)
                .fontWeight(.medium)
                .foregroundColor(.black.opacity(0.7))
            Text("Поможет снизить уровень тревожности и стресса. а также улучшит настроение, самооценку и качество сна.")
                .font(.labGrotesque(.regular, size: 18))
                .foregroundColor(.black)
//                .padding(.top, 10)
                .padding(.horizontal, 36)
            Spacer()
            Spacer()
        }
        .multilineTextAlignment(.center)
    }
    private var welcomeSection2: some View {
        VStack(spacing: 36) {
            Spacer()
            LogoView()
                .frame(width: 150, height: 150)
                .cornerRadius(10)
            Text("Как?")
                .font(.largeTitle)
                .fontWeight(.medium)
                .foregroundColor(.black.opacity(0.7))
            Text("Просто выбери удобное место, запусти путешествие и мы проведем тебя.")
                .font(.labGrotesque(.regular, size: 18))
                .foregroundColor(.black)
//                .padding(.top, 10)
                .padding(.horizontal, 36)
            Spacer()
            Spacer()
        }
        .multilineTextAlignment(.center)
    }
    
    private var bottomButton: some View {
        Text(onboardingState == 2 ? "Приступим" : "Дальше")
            .font(.headline)
//            .foregroundColor(Color.theme.smollDoggo)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background()
            .cornerRadius(25)
            .padding()
            .padding(.horizontal, 16)
            .animation(nil)
            .environment(\.colorScheme, .light)
            .onTapGesture {
                nextOnboardingStep()
            }
    }
    
    private var logoView: some View {
        ZStack(alignment: .bottomLeading) {
            Circle()
                .frame(width: 150, height: 150)
                .foregroundColor(Color(#colorLiteral(red: 0.9559542537, green: 0.5613597035, blue: 0.4460546374, alpha: 1)))
            Circle()
                .frame(width: 100, height: 100)
                .foregroundColor(Color(#colorLiteral(red: 1, green: 0.8323456645, blue: 0.4732058644, alpha: 1)))
        }
        .background {
            Circle()
                .frame(width: 200, height: 200)
                .foregroundColor(.white.opacity(0.2))
                .blur(radius: 10)
                
        }
    }
}

// MARK: Functions

extension OnboardingView {
    
    func nextOnboardingStep() {
        withAnimation(.spring()) {
            if onboardingState == 2 {
                currentUserSignedIn = true
                print(currentUserSignedIn)
            } else {
                onboardingState += 1
            }
        }
    }
    
    func finishOnboarding() {
         
    }
    
}
