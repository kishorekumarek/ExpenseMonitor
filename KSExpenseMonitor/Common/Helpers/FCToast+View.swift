//
//  FCToast+View.swift
//  FreshCaller
//
//  Created by user on 27/09/18.
//  Copyright © 2018 Freshworks. All rights reserved.
//

import Foundation
import UIKit

enum FCToastPosition {
    case top
    case bottom
    case center
}

public struct FCToastStyle {
    public var verticalPadding: CGFloat = 100
    public var horizontalPadding: CGFloat = 15
    public var verticalInset: CGFloat = 10
    public var horizontalInset: CGFloat = 10
    public var backgroundColor: UIColor = UIColor(white: 0.0, alpha: 0.8)
    public var cornerRadius: CGFloat = 10.0
    public var messageFont = UIFont(name: "Helvetica-Neue", size: 17)
    public var messageColor = UIColor.white
    public var messageAlignment = NSTextAlignment.left
    public var fadeInDuration: TimeInterval = 0.3
    public var fadeOutDuration: TimeInterval = 0.3

}

public class FCToastManager {
    static let shared = FCToastManager()
    var style: FCToastStyle
    weak var toast: UIView?
    init() {
        style = FCToastStyle()
    }
}

extension UIView {
    func showToast(_ text: String,
                   position: FCToastPosition = .bottom,
                   duration: TimeInterval = 3.0,
                   verticalPadding: CGFloat = 100) {

        if let oldToast = FCToastManager.shared.toast {
            removeToast(toast: oldToast)
        }
        
        FCToastManager.shared.style.verticalPadding = verticalPadding
        let toast = toastView(forMsg: text,
                                  position: position,
                                  style: FCToastManager.shared.style)
        FCToastManager.shared.toast = toast
        addSubview(toast)
        showToastInAnimation()
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) { [weak self] in
            if FCToastManager.shared.toast == toast {
                self?.removeToast(toast: toast, animate: true)
            }
        }
    }
    
   private func showToastInAnimation() {
        UIView.animate(withDuration: FCToastManager.shared.style.fadeInDuration) {
            FCToastManager.shared.toast?.alpha = 1.0
        }
    }
    
    @objc
    private func removeToast(toast: UIView,
                             animate: Bool = false) {
        if animate {
            UIView.animate(withDuration: FCToastManager.shared.style.fadeOutDuration, animations: {
                toast.alpha = 0.0
            }) { _ in
                toast.removeFromSuperview()
                FCToastManager.shared.toast = nil
            }
        } else {
            toast.removeFromSuperview()
            FCToastManager.shared.toast = nil
        }
    }
    
    private func toastView(forMsg msg: String, position: FCToastPosition, style: FCToastStyle) -> UIView {
        let wrapperView = UIView(frame: CGRect(x: 0,
                                               y: 0,
                                               width: frame.width - (2 * style.horizontalPadding),
                                               height: 100))
        wrapperView.translatesAutoresizingMaskIntoConstraints = false
        wrapperView.layer.cornerRadius = style.cornerRadius
        wrapperView.backgroundColor = style.backgroundColor
        wrapperView.clipsToBounds = true
        addSubview(wrapperView)
        bringSubviewToFront(wrapperView)
    
        let msgLabel = UILabel()
        msgLabel.numberOfLines = 0
        msgLabel.textAlignment = style.messageAlignment
        msgLabel.font = style.messageFont
        msgLabel.textColor = style.messageColor
        msgLabel.frame = CGRect(x: style.horizontalInset, y: style.verticalInset, width: wrapperView.frame.width - (2 * style.horizontalInset), height: 0)
        wrapperView.addSubview(msgLabel)
        msgLabel.text = msg
        msgLabel.sizeToFit()
        
        var wrapperFrame = wrapperView.frame
        wrapperFrame.size.width = msgLabel.frame.width + (2 * style.horizontalInset)
        wrapperFrame.size.height = msgLabel.frame.height + (2 * style.verticalInset)
        
        var yPos: CGFloat = 0.0
        switch position {
        case .top:
            yPos = style.verticalPadding + csSafeAreaInsets.top
        case .center:
            yPos = center.y - (wrapperFrame.height / 2)
        case .bottom:
            yPos = frame.height - wrapperFrame.height - style.verticalPadding - csSafeAreaInsets.bottom
        }
        wrapperFrame.origin.y = yPos
        wrapperFrame.origin.x = (frame.width - wrapperFrame.width) / 2.0
        wrapperView.frame = wrapperFrame
        wrapperView.alpha = 0.0
        return wrapperView

    }
}
 extension UIView {
    
     var csSafeAreaInsets: UIEdgeInsets {
        if #available(iOS 11.0, *) {
            return self.safeAreaInsets
        } else {
            return .zero
        }
    }
    
}

