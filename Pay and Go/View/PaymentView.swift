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
    
    @State var date: Date
    
    // Text Input Fields
    @State private var  accNumber: String = ""
    @State private var  accName: String = ""
    @State private var  paymentAmount: String = ""
    @State private var  narration: String = ""
    
    // Toast message
    @State var isToast: Bool = false
    @State var  msg: String = ""
    
    // Dsmiss keyboard
    @FocusState private var isFocused: Bool
    
    @State private var isSubmit: Bool = false
    
    // MARK: - BODY
    
    var body: some View {
        ZStack {
            VStack(spacing: 50) {
                VStack(spacing: 20) {
                    // Payment type logo
                    Image(paymentData.imgName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.main.bounds.width > 600 ? 200 : 150, height: UIScreen.main.bounds.width > 600 ? 200 : 150)
                    
                    // Inut fields
                    CustomTextFieldView(title: paymentData.accNumber, themeColor: paymentData.backgroundColor, text: $accNumber)
                        .keyboardType(.numberPad)
                        .focused($isFocused)
                    CustomTextFieldView(title: paymentData.accName, themeColor: paymentData.backgroundColor, text: $accName)
                        .focused($isFocused)
                    CustomTextFieldView(title: paymentData.paymentAmount, themeColor: paymentData.backgroundColor, text: $paymentAmount)
                        .keyboardType(.decimalPad)
                        .focused($isFocused)
                    CustomTextFieldView(title: paymentData.narration, themeColor: paymentData.backgroundColor, text: $narration)
                        .focused($isFocused)
                }
                .padding(.horizontal, 15)
                
                Button {
                    isFocused = false
                    if accNumber.isEmpty {
                        isToast = true
                        msg = "Please enter \(paymentData.type) account number"
                    } else if accName.isEmpty {
                        isToast = true
                        msg = "Please enter \(paymentData.type) account name"
                    } else if paymentAmount.isEmpty {
                        isToast = true
                        msg = "Please enter \(paymentData.type) amount"
                    } else {
                        withAnimation(.easeOut(duration: 1)) {
                            isSubmit = true
                        }
                    }
                } label: {
                    Text("Submit")
                        .navButtonDesign(backgroundColor: paymentData.backgroundColor) // Reusable
                }
                
                Spacer()
            }
            
            // Submission PopUp
            // Order post PopUp
            if isSubmit {
                Color.gray
                    .opacity(0.5)
                submitPopUp()
                    .cornerRadius(20)
                    .padding(.horizontal,20)
                    .padding(.vertical, 40)
            }
        }
        .navigationTitle("Payment")
        .navigationBarTitleDisplayMode(.inline)
        .toastAlertView(isToast: $isToast, msg: $msg, themeColor: paymentData.backgroundColor)
    }
    
    @ViewBuilder
    func submitPopUp() -> some View {
        VStack(spacing: 0) {
            HStack  {
                Spacer()
                Button {
                    withAnimation(.easeOut(duration: 1)) {
                        isSubmit = false
                    }
                } label: {
                    Image(systemName: "x.circle.fill")
                        .font(.title2.bold())
                        .foregroundColor(Color.blue.opacity(0.7))
                }
            }
            
            HStack  {
                Image(paymentData.imgName)
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(Color.blue)
                    .frame(width: 120, height: 40)
                Spacer()
            }
            
            // Bank Logo and text
            HStack(spacing: 0)  {
                Spacer()
                Image("cbbl_logo")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(Color.blue)
                    .frame(width: 40, height: 40)
                
                VStack(spacing: 0) {
                    Text("Community Bank")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(Color.blue.opacity(0.7))
                    
                    HStack(spacing: 5) {
                        Text("Trust")
                            .font(.system(size: 8, weight: .bold))
                        
                        Image(systemName: "circle.fill")
                            .font(.system(size: 3, weight: .bold))
                        
                        Text("Security")
                            .font(.system(size: 8, weight: .bold))
                        
                        Image(systemName: "circle.fill")
                            .font(.system(size: 3, weight: .bold))
                        
                        Text("Progress")
                            .font(.system(size: 8, weight: .bold))
                    }
                }
            }
            
            HStack {
                Text("bkash Fund Transfer")
                    .font(.system(size: 8))
                    .multilineTextAlignment(.trailing)
                Spacer()
                Text("Police Plaza Concord(Level 10, Tower 2) Plot 2, Road 144, Gulshan 1")
                    .font(.system(size: 8))
                    .multilineTextAlignment(.trailing)
            }
            
            VStack(spacing: 0) {
                Text("COMMUNITY CASH\nTRANSACTION RECEIPT")
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                
                // Source
                VStack(spacing: 5) {
                    HStack {
                        Text("Source Account/Card")
                            .font(.system(size: 14, weight: .semibold))
                        Spacer()
                        Text("001300004201")
                            .font(.system(size: 14, weight: .semibold))
                    }
                    .background(Color.gray.opacity(0.3))
                    
                    HStack {
                        Text("Amount")
                            .font(.system(size: 14))
                        Spacer()
                        Text("BDT \(Double(paymentAmount) ?? 0.00, specifier: "%.2f")")
                            .font(.system(size: 14))
                    }
                    .foregroundColor(Color.gray)
                    
                    HStack {
                        Text("Transaction Date Time")
                            .font(.system(size: 14))
                        Spacer()
                        Text(date.formatted())
                            .font(.system(size: 14))
                    }
                    .foregroundColor(Color.gray)
                    
                    HStack {
                        Text("Narration")
                            .font(.system(size: 14))
                        Spacer()
                        Text(narration)
                            .font(.system(size: 14))
                    }
                    .foregroundColor(Color.gray)
                    
                }
                .padding(.vertical)
                
                // Transaction Info
                VStack(spacing: 5) {
                    HStack {
                        Text("Transaction Info")
                            .font(.system(size: 14, weight: .semibold))
                        Spacer()
                    }
                    .background(Color.gray.opacity(0.3))
                    
                    HStack {
                        Text(paymentData.accNumber)
                            .font(.system(size: 14))
                        Spacer()
                        Text(accNumber)
                            .font(.system(size: 14))
                    }
                    .foregroundColor(Color.gray)
                    
                    HStack {
                        Text("Reference No")
                            .font(.system(size: 14))
                        Spacer()
                        Text("TXN13901")
                            .font(.system(size: 14))
                    }
                    .foregroundColor(Color.gray)
                    Divider()
                    HStack {
                        Text("Total")
                            .font(.system(size: 14))
                        Spacer()
                        Text("\(Double(paymentAmount) ?? 0.00, specifier: "%.2f")")
                            .font(.system(size: 14))
                    }
                    .foregroundColor(Color.gray)
                    
                    // Success Logo
                    HStack {
                        Spacer()
                        Image("successseal")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(Color.blue)
                            .frame(width: 90, height: 70)
                    }
                }
                .padding(.vertical, 5)
            }
            .padding(.vertical, 20)
            Spacer()
            
            Button {
                
            } label: {
                HStack(spacing: 30) {
                    Text("DODNLOAD RECEIPT")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(Color.gray.opacity(0.5))
                    
                    VStack {
                        Image("icon-download")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .opacity(0.3)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: 50)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(30)
            }
            .padding(.horizontal, 40)
        }
        .padding(30)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
    }
}

// MARK: - PREVIEW

struct PaymentView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentView(paymentData: PaymentServiceProvider(id: 1, type: "Bkash", imgName: "bkash_money_send_icon", accNumber: "Nagad Account", accName: "Nagad Name", paymentAmount: "Amount", narration: "Narration", backgroundColor: "BkashBackground"), date: Date())
    }
}
