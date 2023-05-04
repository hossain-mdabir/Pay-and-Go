//
//  Extension.swift
//  Pay and Go
//
//  Created by Md Abir Hossain on 03-05-2023.
//

import Foundation
import SwiftUI


extension View {
    func navButtonDesign(backgroundColor: String) -> some View {
        self
            .padding()
            .font(UIScreen.main.bounds.width > 600 ? .largeTitle.bold() : .title2.bold())
            .frame(width: UIScreen.main.bounds.width > 600 ? 200 : 150, height: UIScreen.main.bounds.width > 600 ? 120 : 80)
            .foregroundColor(Color.white)
            .background(Color(backgroundColor))
            .cornerRadius(5)
    }
    
    func convertToScrollView<Content: View> (@ViewBuilder content: @escaping () -> Content) -> UIScrollView {
        
        let scrollView = UIScrollView()
        
        let hostingController = UIHostingController(rootView: content()).view!
        
        let constraints = [
            
        ]
        
        return scrollView
    }
}
