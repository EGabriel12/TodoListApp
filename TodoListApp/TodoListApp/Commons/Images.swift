//
//  Images.swift
//  TodoListApp
//
//  Created by Elias Gabriel on 24/07/22.
//

import UIKit

extension UIImage {
     static let mediumConfiguration = UIImage.SymbolConfiguration(weight: .medium)
     static let lightConfiguration = UIImage.SymbolConfiguration(weight: .light)

     public class var heart: UIImage? {
         return UIImage(systemName: "suit.heart", withConfiguration: UIImage.mediumConfiguration)
     }

     public class var heartFill: UIImage? {
         return UIImage(systemName: "suit.heart.fill", withConfiguration: UIImage.mediumConfiguration)
     }

     public class var share: UIImage? {
         return UIImage(systemName: "square.and.arrow.up", withConfiguration: UIImage.mediumConfiguration)
     }

     public class var success: UIImage? {
         return UIImage(systemName: "checkmark", withConfiguration: UIImage.lightConfiguration)
     }

     public class var warning: UIImage? {
         return UIImage(systemName: "exclamationmark.triangle", withConfiguration: UIImage.lightConfiguration)
     }

     public class var error: UIImage? {
         return UIImage(systemName: "xmark", withConfiguration: UIImage.lightConfiguration)
     }

     public class var dismiss: UIImage? {
         return UIImage(systemName: "xmark", withConfiguration: UIImage.mediumConfiguration)
     }
 }
