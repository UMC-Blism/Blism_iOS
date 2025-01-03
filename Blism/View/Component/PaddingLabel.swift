//
//  PaddingLabel.swift
//  Blism
//
//  Created by 송재곤 on 12/19/24.
//
import UIKit

class PaddingLabel: UILabel {
    private var padding = UIEdgeInsets(top: 6.0, left: 10.0, bottom: 6.0, right: 10.0)

    convenience init(padding: UIEdgeInsets) {
        self.init()
        self.padding = padding
    }

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }

    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += padding.top + padding.bottom
        contentSize.width += padding.left + padding.right

        return contentSize
    }
}
