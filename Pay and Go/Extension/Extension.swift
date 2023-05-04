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
        
        // Constrainta
        let constraints = [
            
            hostingController.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            hostingController.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            hostingController.topAnchor.constraint(equalTo: scrollView.topAnchor),
            hostingController.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            // Width anchor
            hostingController.widthAnchor.constraint(equalToConstant: screenBounds().width)
        ]
        
        scrollView.addSubview(hostingController)
        scrollView.addConstraints(constraints)
        scrollView.layoutIfNeeded()
        
        return scrollView
    }
    
    // Export as pdf
    func exportPDF<Content: View>(@ViewBuilder content: @escaping () -> Content, completion: @escaping (Bool, URL?) ->()) {
           
        // URL
        let documentDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        
        let outputFileURL = documentDirectory.appendingPathComponent("paymentPDF\(UUID().uuidString).pdf")
        
        let pdfView = convertToScrollView {
            content()
        }
        
        pdfView.tag = 1009
        let size = pdfView.contentSize
        pdfView.frame = CGRect(x: 0, y: getSafeArea().top, width: size.width, height: size.height)
        
        getRootController().view.insertSubview(pdfView, at: 0)
        
        let renderer = UIGraphicsPDFRenderer(bounds: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        
        do {
            try renderer.writePDF(to: outputFileURL, withActions: { context in
                
                context.beginPage()
                pdfView.layer.render(in: context.cgContext)
            })
            
            completion(true, outputFileURL)
        } catch {
            completion(false, nil)
            print(error.localizedDescription)
        }
        
        // Removing added view
        getRootController().view.subviews.forEach { view in
            if view.tag == 1009 {
                print("Removed")
                view.removeFromSuperview()
            }
        }
    }
    
    func screenBounds() -> CGRect {
        return UIScreen.main.bounds
    }
    
    func getRootController() -> UIViewController {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .init()
        }
        
        guard let root = screen.windows.first?.rootViewController else {
            return .init()
        }
        
        return root
    }
    
    func getSafeArea() -> UIEdgeInsets {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .zero
        }
        
        guard let safeArea = screen.windows.first?.safeAreaInsets else {
            return .zero
        }
        
        return safeArea
    }
}
