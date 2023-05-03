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
    
    // MARK: - BODY
    
    var body: some View {
        VStack {
            
        }
    }
}

// MARK: - PREVIEW

struct PaymentView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentView(paymentData: PaymentServiceProvider(id: 1, type: "Bkash", accNumber: "Nagad Account", accName: "Nagad Name", paymentAmount: "Amount", narration: "Narration", backgroundColor: "BkashBackground"))
    }
}
