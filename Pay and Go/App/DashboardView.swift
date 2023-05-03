//
//  DashboardView.swift
//  Pay and Go
//
//  Created by Md Abir Hossain on 03-05-2023.
//

import SwiftUI

struct DashboardView: View {
    // MARK: - PROPERTIES
    
    
    
    // MARK: - BODY
    
    var body: some View {
        VStack {
            ForEach(0 ..< paymentServiceProviderData.count, id: \.self) { type in
                NavigationLink(destination: PaymentView(paymentData: paymentServiceProviderData[type])) {
                    
                    Text(paymentServiceProviderData[type].type)
                        .navButtonDesign(backgroundColor: paymentServiceProviderData[type].backgroundColor)
                }
            }
        }
    }
}

// MARK: - PREVIEW

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}



//// MARK: - PROPERTIES
//
//
//
//// MARK: - BODY
//
//var body: some View {
//    Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//}
//}
//
//// MARK: - PREVIEW