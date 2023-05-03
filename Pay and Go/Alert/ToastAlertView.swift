//
//  ToastAlertView.swift
//  Pay and Go
//
//  Created by Md Abir Hossain on 04-05-2023.
//

import SwiftUI

struct ToastAlertView: ViewModifier {
    // MARK: - PROPERTIES
    
    @Binding var isToast: Bool
    @Binding var message: String
    
    var themeColor: String
    
    let duration: TimeInterval
    
    // MARK: - BODY
    
    func body(content: Content) -> some View {
        ZStack {
            content
            
            if isToast {
                VStack {
                    Spacer()
                    HStack {
                        Image("thp_logo")
                            .resizable()
                            .frame(width: 20, height: 20)
                        
                        Text(message)
                            .font(.footnote)
                    }
                    .scaledToFit()
                    .padding()
                    .foregroundColor(Color.primary)
                    .background(Color(themeColor).opacity(0.5))
                    .shadow(color: .gray, radius: 2, x: 0, y: 3)
                }
                .padding(.bottom, 80)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                        withAnimation {
                            isToast = false
                        }
                    }
                }
            }
            
        }
    }
}

//MARK: - Order Toast Duration Extension
extension View {
    func toastAlertView(isToast: Binding<Bool>, msg: Binding<String>, themeColor: String, duration: TimeInterval = 3) -> some View {
        modifier(ToastAlertView(isToast: isToast, message: msg, themeColor: themeColor, duration: duration))
    }
}
