//
//  SignUpView.swift
//  InfluPeach
//
//  Created by Ethan Hanlon on 2/20/21.
//

import SwiftUI
import FirebaseAuth
import NavigationStack

struct SignUpView: View {
    @EnvironmentObject private var navigationStack: NavigationStack
    
    @State private var email = ""
    @State private var password = ""
    @State private var passwordConfirm = ""
    @State private var usrMessage = ""
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
                        Text("Register")
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
                    
                    //Text inputs
                    Text("Sign up with email and password")
                        .foregroundColor(.white)
                        .padding()
                    
                    CustomStyledTextField(text: $email, placeholder: "Email", symbolName: "envelope.circle", isSecure: false)
                        .padding(.bottom)
                    
                    CustomStyledTextField(text: $password, placeholder: "Password", symbolName: "lock.circle", isSecure: true)
                        .padding(.bottom)
                    
                    CustomStyledTextField(text: $passwordConfirm, placeholder: "Confirm password", symbolName: "lock.circle", isSecure: true)
                        .padding(.bottom)
                    
                    CustomStyledTextButton(title: "Register", action: {
                        emailPasswordRegister()
                    })
                    .border(Color.white,width: 4.0)
                    
                    Divider()
                    
                    //Terms/privacy
                    HStack {
                        
                        Link("Terms", destination: TermsPrivacy.termsAndConditions!)
                        
                        Text("•")
                            .foregroundColor(.white)
                        
                        Link("Privacy", destination: TermsPrivacy.privacyPolicy!)
                    }
                    .padding(.top)
                }
                
                Spacer()
                
            }
        }
    }
    
    func emailPasswordRegister() {
        //Check for email
        if(isValidEmail(email)) {
            //Check for min password length & matching
            if(password.count >= 8) {
                //Check for passwords matching
                if(password == passwordConfirm) {
                    Auth.auth().createUser(withEmail: email, password: password) {authResult,error in
                        guard let user = authResult?.user, error == nil else {
                            alertTitle = "Error"
                            alertMsg = error!.localizedDescription
                            showingAlert = true
                            return
                        }
                        
                        sleep(UInt32(0.5))
                        
                        user.sendEmailVerification(completion: nil)
                        
                        self.navigationStack.push(ProfileView())
                        
                    }
                } else {
                    alertTitle = "Passwords don't match"
                    alertMsg = "The passwords fields do not match with each other."
                    showingAlert = true
                }
            } else {
                alertTitle = "Password not long enough"
                alertTitle = "Your password must be at least 8 characters."
                showingAlert = true
            }
        } else {
            alertTitle = "Please enter an email address"
            alertMsg = "Either the email field was left empty, or a valid email was not entered."
            showingAlert = true
        }
    }
    
    //With thanks to Maxim Shoustin on StackOverflow
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
