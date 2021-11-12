//
//  Cell_rate.swift
//  CoreDataSpisokDel
//
//  Created by Igor Abovyan on 11.10.2021.
//

import UIKit

class Cell_rate: UITableViewCell {
    
    static var height: CGFloat {
        let height = CGFloat.offset * 2 + CGFloat.buttonHeight
        return height
    }
    
    var rateLabel: UILabel!
    
    var buttons = [UIButton].init()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.createRate()
        self.createButtons()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension Cell_rate {
    
    private func createRate() {
        rateLabel = UILabel.init()
        rateLabel.frame.size.width = (UIScreen.main.bounds.width - CGFloat.offset * 2) / 3
        rateLabel.frame.size.height = CGFloat.buttonHeight
        rateLabel.frame.origin.x = CGFloat.offset
        rateLabel.frame.origin.y = CGFloat.offset
        rateLabel.backgroundColor = .systemGray6
        rateLabel.textAlignment = .center
        rateLabel.font = UIFont.systemFont(ofSize: 30)
        self.contentView.addSubview(rateLabel)
    }
    
    private func createButtons() {
        // ширина под кнопку
        let width = (UIScreen.main.bounds.width - rateLabel.frame.size.width - CGFloat.offset * 3) / 5
        for i in 0 ..< 5 {
            let button = self.createButton()
            button.center.x = rateLabel.frame.origin.x + rateLabel.frame.size.width + CGFloat.offset + width / 2 + width * CGFloat(i)
            button.tag = i + 1
        }
    }
    
    private func createButton() -> UIButton {
        let button = UIButton.init()
        button.frame.size.width = CGFloat.buttonHeight * 0.8
        button.frame.size.height = button.frame.size.width
        button.center.y = Cell_rate.height / 2
        button.backgroundColor = tintColor
        self.contentView.addSubview(button)
        button.layer.cornerRadius = button.frame.size.width / 2
        buttons.append(button)
        return button
        
    }
}
