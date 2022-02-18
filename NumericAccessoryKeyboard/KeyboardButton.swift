//
//  KeyboardButton.swift
//  NumericAccessoryKeyboard
//
//  Created by Benjamin Lewis on 1/18/22.
//

import UIKit

class KeyboardButton: UIButton{
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(letter: String) {
        super.init(frame: .zero)
        setTitle(letter, for: .normal)
        layer.cornerRadius = 5.0
        clipsToBounds = true
        backgroundColor = .systemGray2
        setTitleColor(.label, for: .normal)
        isEnabled = true
        translatesAutoresizingMaskIntoConstraints = false
        autoresizingMask = .flexibleWidth.union(.flexibleHeight)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension KeyboardButton{
    
}
