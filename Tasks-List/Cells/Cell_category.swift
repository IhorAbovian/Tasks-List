//
//  Cell_category.swift
//  CoreDataSpisokDel
//
//  Created by Igor Abovyan on 14.10.2021.
//

import UIKit

class Cell_category: UITableViewCell {
    
    static var height: CGFloat {
        let h = CGFloat.offset * 2 + CGFloat.buttonHeight
        return h
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // залить по содзаным параметрам
        imageView?.contentMode = .scaleAspectFill
        imageView?.clipsToBounds = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView?.frame.size.width = CGFloat.buttonHeight
        imageView?.frame.size.height = imageView!.frame.size.width
        imageView?.frame.origin.x = CGFloat.offset
        imageView?.frame.origin.y = CGFloat.offset
        textLabel?.frame.origin.x = imageView!.frame.origin.x + CGFloat.offset + imageView!.frame.size.width
    }
    
    
}


