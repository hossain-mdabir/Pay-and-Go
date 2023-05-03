//
//  PaymentView.swift
//  Pay and Go
//
//  Created by Md Abir Hossain on 03-05-2023.
//

import SwiftUI

struct PaymentView: View {
    // MARK: - PROPERTIES
    
    let paymentData: PaymentServiceProvider
    
    @State var  accNumber: String = ""
    @State var  accName: String = ""
    @State var  paymentAmount: String = ""
    @State var  narration: String = ""
    
    // MARK: - BODY
    
    var body: some View {
        VStack(spacing: 50) {
            VStack(spacing: 20) {
                // Payment type logo
                Image(paymentData.imgName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width > 600 ? 200 : 150, height: UIScreen.main.bounds.width > 600 ? 120 : 80)
                
                // Inut fields
                CustomTextFieldView(title: paymentData.accNumber, themeColor: paymentData.backgroundColor, text: $accNumber)
                CustomTextFieldView(title: paymentData.accName, themeColor: paymentData.backgroundColor, text: $accName)
                CustomTextFieldView(title: paymentData.paymentAmount, themeColor: paymentData.backgroundColor, text: $paymentAmount)
                CustomTextFieldView(title: paymentData.narration, themeColor: paymentData.backgroundColor, text: $narration)
            }
            .padding(.horizontal, 15)
            
            Button {
                
            } label: {
                Text("Submit")
                    .navButtonDesign(backgroundColor: paymentData.backgroundColor)
            }
            
            Spacer()
        }
    }
    
    @
}

// MARK: - PREVIEW

struct PaymentView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentView(paymentData: PaymentServiceProvider(id: 1, type: "Bkash", imgName: "bkash_money_send_icon", accNumber: "Nagad Account", accName: "Nagad Name", paymentAmount: "Amount", narration: "Narration", backgroundColor: "BkashBackground"))
    }
}
