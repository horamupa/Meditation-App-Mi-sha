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
    @Binding var isShowOnboarding: Bool
    @State var onboardingState: Int = 0
    @AppStorage("signed_in") var currentUserSignedIn: Bool = false
    let transition: AnyTransition = .asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading))
    var body: some View {
        ZStack(alignment: .bottom) {
//            RadialGradient(
//                gradient: Gradient(colors: [Color.theme.main, Color.theme.main2]),
//                center: .topLeading, startRadius: 200, endRadius: 600)
            Color("AppIconWhite")
//            Color.theme.gradient
                .ignoresSafeArea()
            VStack {
                Spacer()
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
                Spacer()
                
            }
//            .animation(.easeInOut(duration: 0.1), value: onboardingState)
//            .padding(.top, 64)
            .padding(.horizontal, 8)
            bottomButton
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(isShowOnboarding: .constant(false))
    }
}

// MARK: Components

extension OnboardingView {
    
    private var welcomeSection: some View {
        VStack(spacing: 32) {
            Text("Привет!")
                .font(.labGrotesque(.medium, size: 28))
                .foregroundColor(.black)
            Image("1024AppIicon")
                .resizable()
                .scaledToFit()
                .overlay {
                    ZStack {
                        Rectangle()
                            .stroke(lineWidth: 5)
                            .foregroundColor(Color("AppIconWhite"))
                            .blur(radius: 10)
                        Rectangle()
                            .stroke(lineWidth: 5)
                            .foregroundColor(Color("AppIconWhite"))
                            .blur(radius: 10)
                    }
                    .blur(radius: 10)
                }
                .cornerRadius(30)
            Text("Медитативное путешествие в компании девочки Ми и её собачки Ша.")
                .font(.labGrotesque(.regular, size: 18))
                .foregroundColor(.black)
        }
        .padding(.horizontal, 16)
        .multilineTextAlignment(.center)
    }
    private var welcomeSection1: some View {
        VStack(spacing: 32) {
            Text("Зачем?")
                .font(.largeTitle)
                .fontWeight(.medium)
                .foregroundColor(.black)
            Image("1024AppIicon")
                .resizable()
                .scaledToFit()
                .cornerRadius(30)
            Text("Снизит фоновый уровень тревожности, поднимет самооценку и улучшит качество сна.")
                .font(.labGrotesque(.regular, size: 18))
                .foregroundColor(.black)
        }
        .padding(.horizontal, 16)
        .multilineTextAlignment(.center)
    }
    private var welcomeSection2: some View {
        VStack(spacing: 32) {
            Text("Как?")
                .font(.largeTitle)
                .fontWeight(.medium)
                .foregroundColor(.black)
            Image("1024AppIicon")
                .resizable()
                .scaledToFit()
                .cornerRadius(30)
            Text("Просто выбери удобное место, запусти аудио и отправляйся в путешествие по твоему сознанию.")
                .font(.labGrotesque(.regular, size: 18))
                .foregroundColor(.black)
        }
        .padding(.horizontal, 16)
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
