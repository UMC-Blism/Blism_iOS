//
//  Font_Extension.swift
//  Blism
//
//  Created by 이수현 on 12/18/24.
//

import UIKit

public enum CustomFont {
    case SejongGeulggot
    case GanwonEduBold
    case GanwonEduLight
    case KyoboHandWriting
    case PretendardLight
    case PretendardRegular
    case PretendardMedium
    case PretendardBold
    case PretendardSemiBold
    case Inter
}



extension UIFont {
    class func customFont(font : CustomFont, ofSize fontSize : CGFloat) -> UIFont {
        switch font {
        case .GanwonEduBold:
            return UIFont(name: "GangwonEduAll-OTFBold", size: fontSize) ?? .systemFont(ofSize: fontSize, weight: .bold)
        case .GanwonEduLight:
            return UIFont(name: "GangwonEduAll-OTFLight", size: fontSize) ?? .systemFont(ofSize: fontSize, weight: .light)
        case .KyoboHandWriting:
            return UIFont(name: "KyoboHandwriting2021sjy", size: fontSize) ?? .systemFont(ofSize: fontSize, weight: .regular)
        case .PretendardBold:
            return UIFont(name: "Pretendard-Bold", size: fontSize) ?? .systemFont(ofSize: fontSize, weight: .bold)
        case .PretendardMedium:
            return UIFont(name: "Pretendard-Medium", size: fontSize) ?? .systemFont(ofSize: fontSize, weight: .medium)
        case .PretendardRegular:
            return UIFont(name: "Pretendard-Regular", size: fontSize) ?? .systemFont(ofSize: fontSize, weight: .regular)
        case .PretendardSemiBold:
            return UIFont(name: "Pretendard-SemiBold", size: fontSize) ?? .systemFont(ofSize: fontSize, weight: .semibold)
        case .PretendardLight:
            return UIFont(name: "Pretendard-Light", size: fontSize) ?? .systemFont(ofSize: fontSize, weight: .light)
        case .SejongGeulggot:
            return UIFont(name: "SejongGeulggot", size: fontSize) ?? .systemFont(ofSize: fontSize)
        case .Inter:
            return UIFont(name: "InterVariable-Italic", size: fontSize) ?? .systemFont(ofSize: fontSize)
        }
    }
}

/* Example
  label.font = .customFont(font: .GanwonEduBold, ofSize: 14)
 
 */
