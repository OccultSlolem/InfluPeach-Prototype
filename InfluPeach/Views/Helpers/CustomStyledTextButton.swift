//
//  CustomStyledTextButton.swift
//  InfluPeach
//
//  Created by Ethan Hanlon on 2/20/21.
//

import SwiftUI

struct CustomStyledTextButton: View {
    var title: String
    var backgroundColor: Color? = Color.orange
    var textColor: Color? = Color.white
    var action: () -> Void
    
    var body: some View {
        Button(action: action, label: {
            ZStack {
                Rectangle()
                    .frame(width: 215, height: 60)
                    .foregroundColor(backgroundColor)
                
                Text(title)
                    .foregroundColor(textColor)
                    .font(.title)
            }

        })
    }
}

struct CustomStyledTextButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomStyledTextButton(title: "String", action: {
            print(":)")
        })
    }
}
