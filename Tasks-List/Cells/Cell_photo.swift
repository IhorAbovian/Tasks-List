//
//  Cell_photo.swift
//  CoreDataSpisokDel
//
//  Created by Igor Abovyan on 06.10.2021.
//

import UIKit

class Cell_photo: UITableViewCell {
    
    var photoView: UIImageView!
    var chooseButton: UIButton!
    var takeButton: UIButton!
    
    private static let photoHeight: CGFloat = 150
    
    static var height: CGFloat {
        let h = CGFloat.buttonHeight + CGFloat.offset * 3 + photoHeight
        return h
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.createPhotoView()
        self.createTakeButton()
        self.createChooseButton()
        self.selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: UI
extension Cell_photo {
    
    private func createPhotoView() {
        photoView = UIImageView.init()
        photoView.frame.size.width = UIScreen.main.bounds.width - CGFloat.offset * 2
        photoView.frame.size.height = Cell_photo.photoHeight
        photoView.frame.origin.x = CGFloat.offset
        photoView.frame.origin.y = CGFloat.offset
        photoView.backgroundColor = .systemGray6
        photoView.contentMode = .scaleAspectFill
        photoView.clipsToBounds = true
        self.contentView.addSubview(photoView)
    }
    
    private func createTakeButton() {
        takeButton = self.createBaseButton()
        takeButton.frame.origin.x = CGFloat.offset
        takeButton.setTitle("Take", for: .normal)
        
    }
    
    private func createChooseButton() {
        chooseButton = self.createBaseButton()
        chooseButton.frame.origin.x = UIScreen.main.bounds.width / 2 + CGFloat.offset / 2
        chooseButton.setTitle("Choose", for: .normal)
    }
    
    private func createBaseButton() -> UIButton {
        let button = UIButton.init()
        button.frame.size.width = UIScreen.main.bounds.width / 2 - CGFloat.offset * 1.5
        button.frame.size.height = CGFloat.buttonHeight
        button.frame.origin.y = photoView.frame.origin.y + photoView.frame.size.height + CGFloat.offset
        button.backgroundColor = self.tintColor
        self.contentView.addSubview(button)
        return button
    }
}
