//
//  Helper.swift
//  MovieDatabaseApp
//
//  Created by Kishore B on 8/20/24.
//

import Foundation
import UIKit

extension UIViewController {
    
    func toastMessage(_ message: String){
        guard let window = UIApplication.shared.keyWindow else {return}
        let messageLbl = UILabel()
        messageLbl.text = message
        messageLbl.textAlignment = .center
        messageLbl.font = UIFont.systemFont(ofSize: 12)
        messageLbl.textColor = .white
        messageLbl.backgroundColor = UIColor(white: 0, alpha: 0.5)
        
        let textSize:CGSize = messageLbl.intrinsicContentSize
        let labelWidth = min(textSize.width, window.frame.width - 40)
        
        messageLbl.frame = CGRect(x: 20, y: window.frame.height - 90, width: labelWidth + 30, height: textSize.height + 20)
        messageLbl.center.x = window.center.x
        messageLbl.layer.cornerRadius = messageLbl.frame.height/2
        messageLbl.layer.masksToBounds = true
        window.addSubview(messageLbl)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            
            UIView.animate(withDuration: 2, animations: {
                messageLbl.alpha = 0
            }) { (_) in
                messageLbl.removeFromSuperview()
            }
        }
    }}


extension UIView {
 
    func applyCardShadow(cornerRadius: CGFloat = 8, shadowColor: UIColor = .gray, shadowOpacity: Float = 0.1, shadowOffset: CGSize = CGSize(width: 1, height: 1), shadowRadius: CGFloat = 10) {
        // Set corner radius
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = false
        
        // Set shadow properties
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowRadius = shadowRadius
        
        // Apply shadow path for better performance
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: cornerRadius).cgPath
    }
}

extension UIImageView {
    
    func loadImage(from url: URL, placeholder: UIImage? = nil) {
        // Set placeholder image if provided
        self.image = placeholder
        
        // Start the background task to download the image
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            // Check for errors and valid data
            guard let data = data, error == nil, let image = UIImage(data: data) else {
                DispatchQueue.main.async {
                    // If image fails to load, set the placeholder image
                    if let placeholder = placeholder {
                        self?.image = placeholder
                    }
                }
                return
            }
            
            DispatchQueue.main.async {
                // Set the downloaded image
                self?.image = image
            }
        }.resume()
    }

}
