//
//  Cell_task.swift
//  CoreDataSpisokDel
//
//  Created by Igor Abovyan on 14.10.2021.
//

import UIKit

class Cell_task: Cell_category {
    
    var circles = [UIView].init()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.createCircles()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension Cell_task {
    
    private func createCircles() {
        let firstCircleX = CGFloat.offset * 2 + CGFloat.buttonHeight
        for i in 0 ..< 5 {
            let circle = self.createCircle()
            let offset = circle.frame.size.width * 1.5
            circle.frame.origin.x = firstCircleX + offset * CGFloat(i)
            
            
        }
    }
    
    private func createCircle() -> UIView {
        let circle = UIView.init()
        circle.frame.size.width = CGFloat.offset * 0.5
        circle.frame.size.height = circle.frame.size.width
        circle.frame.origin.y = Cell_task.height - CGFloat.offset - circle.frame.size.height
        circle.backgroundColor = .gray
        circle.layer.cornerRadius = circle.frame.size.width / 2
        self.contentView.addSubview(circle)
        circles.append(circle)
        return circle
    }
    
    
}
