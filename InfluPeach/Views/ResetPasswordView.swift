//
//  ResetPasswordView.swift
//  InfluPeach
//
//  Created by Ethan Hanlon on 2/20/21.
//

import SwiftUI
import FirebaseAuth
import NavigationStack

struct ResetPasswordView: View {
    @EnvironmentObject private var navigationStack: NavigationStack
    
    @State private var email = ""
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMsg = ""
    
    var body: some View {
        ZStack {
            
            //Alert handler
            Button(action: {
                print("Alert")
            }, label: {
                Text("")
            })
            .alert(isPresented: $showingAlert, content: {
                Alert(title: Text(alertTitle), message: Text(alertMsg), dismissButton: .default(Text("OK")))
            })
            
            //Background
            Colors.defaultBackgroundColor
                .ignoresSafeArea()
            VStack {
                //Register text
                Group {
                    HStack {
                        Text("Reset Password")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .padding(.leading)
                        
                        Spacer()
                    }
                
                
                    //Back button
                    HStack {
                        Button(action: {
                            self.navigationStack.pop()
                        }, label: {
                            Group {
                                Image(systemName: "chevron.left.circle.fill")
                                    .padding(.leading)
                                Text("Back")
                            }
                            .padding(.top, 1.0)
                            .foregroundColor(.white)
                            
                        })
                        
                        Spacer()
                    }
                    
                    Spacer()
                    
                    CustomStyledTextField(text: $email, placeholder: "Email", symbolName: "envelope", isSecure: false)
                        .padding(.bottom)
                    
                    CustomStyledTextButton(title: "Reset Password", action: {
                        //If no email is input
                        if(email == "") {
                            alertTitle = "Reset failed"
                            alertMsg = "Please insert an email"
                            showingAlert = true
                        } else {
                        
                            Auth.auth().sendPasswordReset(withEmail: email) { error in
                                if(error != nil) {
                                    //Error
                                    alertTitle = "Reset failed"
                                    alertMsg = "Something went wrong. Make sure you entered your email correctly and try again"
                                    showingAlert = true
                                } else {
                                    //Successful reset
                                    alertTitle = "Reset sent"
                                    alertMsg = "Check your email for a link to reset your password"
                                    showingAlert = true
                                    
                                }
                            }
                        }
                    })
                    .border(Color.white, width: 4.0)
                    
                    Spacer()
                }
            }
        }
    }
}

struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView()
    }
}
