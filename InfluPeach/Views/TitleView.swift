//
//  TitleView.swift
//  InfluPeach
//
//  Created by Ethan Hanlon on 2/20/21.
//

import SwiftUI
import NavigationStack

struct TitleView: View {
    @EnvironmentObject private var navigationStack: NavigationStack
    
    var body: some View {
        ZStack {
            Colors.defaultBackgroundColor
                .ignoresSafeArea()
            
            VStack {
                Text("InfluPeach")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                
                Text("Optimize your social media")
                    .foregroundColor(.white)
                
                Spacer()
                
                //Login button
                CustomStyledTextButton(title: "Login", action: {
                    navigationStack.push(SignInView())
                })
                .border(Color.white, width: 4.0)
                
                //Register button
                CustomStyledTextButton(title: "Register", backgroundColor: Color.white, textColor: Color.orange, action: {
                    navigationStack.push(SignUpView())
                })
                .border(Color.white, width: 4.0)
                .padding(.bottom)
            }
        }
    }
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView()
    }
}
