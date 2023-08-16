//
//  UIFont+Extensions.swift
//  BasicNoteApp
//
//  Created by Furkan on 12.07.2023.
//

import Foundation
import UIKit

extension UIFont {

  enum FontWeight {
      case interRegular
      case interLight
      case interMedium
      case interSemiBold
      case interBold
  }

  // swiftlint:disable identifier_name
  enum FontSize {
      /// 10
      case small

      /// 40
      case large

      /// 26
      case h1

      /// 22
      case h2

      /// 17
      case h3
      
      /// 16
      case h4
      
      /// 15
      case h5
      
      /// 14
      case h6
      
      /// 13
      case h7

      /// custom
      case custom(size: CGFloat)

      public var rawValue: CGFloat {
          switch self {
          case .small: return 10
          case .large:  return 40
          case .h1: return 26
          case .h2: return 22
          case .h3: return 17
          case .h4: return 16
          case .h5: return 15
          case .h6: return 14
          case .h7: return 13
          case .custom(let size): return size
          }
      }
  }
  // swiftlint:enable identifier_name

  static func font(_ weight: UIFont.FontWeight, size: FontSize) -> UIFont {
      let font: UIFont
      switch weight {
      case .interRegular:
          font = FontFamily.Inter.regular.font(size: size.rawValue)
      case .interLight:
          font = FontFamily.Inter.light.font(size: size.rawValue)
      case .interMedium:
          font = FontFamily.Inter.medium.font(size: size.rawValue)
      case .interSemiBold:
          font = FontFamily.Inter.semiBold.font(size: size.rawValue)
      case .interBold:
          font = FontFamily.Inter.bold.font(size: size.rawValue)
      }
      return font
  }
}
