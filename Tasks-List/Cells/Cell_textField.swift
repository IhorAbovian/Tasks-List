//
//  Cell_textField.swift
//  CoreDataSpisokDel
//
//  Created by Igor Abovyan on 06.10.2021.
//

import UIKit

class Cell_textField: UITableViewCell {
    
    var textField: UITextField!
    
    static var height: CGFloat {
        let h = CGFloat.offset * 2 + CGFloat.buttonHeight
        return h
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.createTextField()
        self.selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension Cell_textField {
    
    private func createTextField() {
        textField = UITextField.init()
        textField.frame.size.width = UIScreen.main.bounds.width - CGFloat.offset
        textField.frame.size.height = CGFloat.buttonHeight
        textField.frame.origin.y = CGFloat.offset
        textField.frame.origin.x = CGFloat.offset
        self.contentView.addSubview(textField)
    }
}



