//
//  CustomTextFieldView.swift
//  Pay and Go
//
//  Created by Md Abir Hossain on 03-05-2023.
//

import SwiftUI

struct CustomTextFieldView: View {
    // MARK: - PROPERTIES
    
    var title: String
    var themeColor: String
    @Binding var text: String
    
    // MARK: - BODY
    
    var body: some View {
        VStack {
            ZStack(alignment: .leading) {
                // Field Title
                Text("\(title)")
                    .padding(.leading, 10)
                    .font(.system(size: 18))
                    .fontWeight(.semibold)
                    .foregroundColor(text.isEmpty ? Color.gray.opacity(0.5) : Color(themeColor))
                    .offset(y: text.isEmpty ? 0 : -25)
                    .scaleEffect(text.isEmpty ? 1 : 0.8, anchor: .leading)
                
                
                HStack {
                    // Text
                    TextField("", text: $text)
                        .padding(.leading, 10)
                        .accentColor(.blue)
                }
            }
            .animation(.default, value: text.isEmpty)
            Divider()
                .frame(height: text.isEmpty ? 0 : 3)
                .overlay(text.isEmpty ? Color.gray : Color(themeColor))
                .animation(.easeOut(duration: 1), value: text.isEmpty)
        }
    }
}

// MARK: - PREVIEW
struct CustomTextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextFieldView(title: "Demo Title", themeColor: "BkashBackground", text: .constant(""))
    }
}


