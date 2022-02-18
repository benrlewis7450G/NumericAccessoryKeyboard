//
//  KeyboardView.swift
//  NumericAccessoryKeyboard
//
//  Created by Benjamin Lewis on 1/18/22.
//

import UIKit

public class KeyboardView: UIInputView {
    public static let instance=KeyboardView(frame: .zero,inputViewStyle: .keyboard)
    
    var target:UITextInput?
    
    public override init(frame: CGRect, inputViewStyle: UIInputView.Style) {
        let screenBounds = UIScreen.main.bounds
        let size = screenBounds.size
        let width = size.width
        
        let space = 4.0
        
        var keyboardHeight:Float
        if(UIDevice.current.userInterfaceIdiom == .phone){
            keyboardHeight = 50.0
        }else{
            keyboardHeight = 60.0
        }
        
        super.init(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat(keyboardHeight)), inputViewStyle: inputViewStyle)
        autoresizingMask = .flexibleWidth
        
        var prev:UIButton?
        for i in 0...9 {
            let button = KeyboardButton(letter: "\(i)")
            button.addAction(UIAction(handler: { [unowned self] ActionHandler in
                if let t = target, let selectedRange = t.selectedTextRange {
                    target?.replace(selectedRange, withText: button.title(for: .normal) ?? "?")
                    UIDevice.current.playInputClick()
                }
            }), for: .touchUpInside)
            addSubview(button)
            
            if(i == 0){
                let c = NSLayoutConstraint(item: button, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1.0, constant: space)
                addConstraint(c)
            }
            
            if let p = prev{
                let widthC = NSLayoutConstraint(item: button, attribute: .width, relatedBy: .equal, toItem: p, attribute: .width, multiplier: 1.0, constant: 0)
                addConstraint(widthC)
                
                let leftC = NSLayoutConstraint(item: button, attribute: .left, relatedBy: .equal, toItem: p, attribute: .right, multiplier: 1.0, constant: space)
                addConstraint(leftC)
            }
            
            if(i == 9){
                let rightC = NSLayoutConstraint(item: button, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1.0, constant: -space)
                addConstraint(rightC)
            }
            
            let topC = NSLayoutConstraint(item: button, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: space)
            let bottomC = NSLayoutConstraint(item: button, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: -space)
            addConstraints([topC,bottomC])
            prev = button
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(editingDidBegin), name: UITextField.textDidBeginEditingNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(editingDidEnd), name: UITextField.textDidEndEditingNotification, object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func editingDidBegin(notification:NSNotification){
        if let dest = notification.object as? UITextInput {
            target = dest
        }
    }
    
    @objc func editingDidEnd(notification:NSNotification){
        target = nil
    }
    
    
}

extension KeyboardView:UIInputViewAudioFeedback {
    public var enableInputClicksWhenVisible:Bool {
        return true
    }
    
    
}
