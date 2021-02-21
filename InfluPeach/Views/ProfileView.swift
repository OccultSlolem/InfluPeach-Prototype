//
//  ProfileView.swift
//  InfluPeach
//
//  Created by Ethan Hanlon on 2/20/21.
//
//  When a user has successfully logged in, they will be pushed to this view

import SwiftUI
import FirebaseAuth
import NavigationStack

struct ProfileView: View {
    let currentUser = Auth.auth().currentUser
    @EnvironmentObject private var navigationStack: NavigationStack
    
    //Alert box
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMsg = ""
    @State private var name = ""
    
    var body: some View {
        
        VStack {
            //Alert handler
            Button(action: {
                    print("Alert")

            }, label: {
                Text("")
            })
            .alert(isPresented: $showingAlert, content: {
                Alert(title: Text(alertTitle), message: Text(alertMsg), dismissButton: .default(Text("OK")))
            })
            .hidden()
            
            Text("Hello, " + (currentUser?.email ?? "human") + "!")
                .font(.largeTitle)
                .padding(.bottom)

            Text("Your UID is " + (currentUser?.uid ?? "not able to be found right now!"))
            
            
            Spacer()
            
            if (currentUser?.isEmailVerified) == true {
                HStack {
                    Image(systemName: "checkmark.circle")
                    
                    Text("Email verified")
                }
                .foregroundColor(.green)
                .padding(.bottom)
                .padding(.horizontal)
            } else {
                HStack {
                    Image(systemName: "xmark.circle")
                        .foregroundColor(.red)
                    
                    Text("Email not verified")
                        .foregroundColor(.red)
                    Spacer()
                    
                    Button(action: {
                        currentUser?.sendEmailVerification(completion: nil)

                        alertTitle = "Verification message sent"
                        alertMsg = "Please check your email for a verification message. Check your spam/junk folder if you can't find it in your inbox."
                        showingAlert = true
                    }, label: {
                        HStack {
                            Text("Verify Email")
                            Image(systemName: "chevron.right")
                        }
                        .foregroundColor(.green)
                        .padding(.horizontal)
                    })
                }
                
                .padding(.bottom)
                .padding(.horizontal)
            }
            
            Spacer()
            
            Button(action: {
                do {
                    try Auth.auth().signOut()
                    self.navigationStack.push(TitleView())
                } catch {
                    alertTitle = "Failed to sign out"
                    alertMsg = "Something broke on our end. Try signing out again or restarting."
                    showingAlert = true
                }
                
            }, label: {
                Image(systemName: "arrowshape.turn.up.left.circle.fill")
                Text("Sign out")
            })
        }
        .padding(.horizontal)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
