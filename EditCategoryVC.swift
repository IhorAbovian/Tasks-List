//
//  EditCategoryVC.swift
//  CoreDataSpisokDel
//
//  Created by Igor Abovyan on 05.10.2021.
//

import UIKit


class EditCategoryVC: UITableViewController {
    
    var category: Category!
    var photoManager: PhotoManager!
}


//MARK: Controller Life Cycle
extension EditCategoryVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.config()
        
    }
}

//MARK: Configuration
extension EditCategoryVC {
    
    private func config() {
        photoManager = PhotoManager.init(viewController: self)
        photoManager.myDelegate = self
        self.createButton()
        self.setTitle()
    }
    
    private func createButton() {
        let button = UIBarButtonItem.init(barButtonSystemItem: .save, target: self, action: #selector(save))
        navigationItem.rightBarButtonItem = button
    }
    
    @objc private func save() {
        let indexPath = IndexPath.init(row: 1, section: 0)
        let cellTextField = tableView.cellForRow(at: indexPath) as! Cell_textField
        category.name = cellTextField.textField.text
        CoreDataManager.shared.saveContext()
        navigationController?.popViewController(animated: true)
    }
    
    private func setTitle() {
        if let name = category.name {
            navigationItem.title = name
        }else {
            self.navigationItem.title = "Category"
        }
    }
    
    
}

//MARK: Table view Data source
extension EditCategoryVC {
   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let identifier = "cellPhoto"
            var cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? Cell_photo
            if cell == nil {
                cell = Cell_photo.init(style: .subtitle, reuseIdentifier: identifier)
                
                cell?.takeButton.addTarget(self, action: #selector(takePhoto), for: .touchUpInside)
                cell?.chooseButton.addTarget(self, action: #selector(choosePhoto), for: .touchUpInside)
            }
            
            if let photoData = category.photo {
                if let photo = UIImage.init(data: photoData) {
                    cell?.photoView.image = photo
                }
            }
         
            return cell!
        }else {
            let identifier = "cellTextField"
            var cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? Cell_textField
            if cell == nil {
                cell = Cell_textField.init(style: .subtitle, reuseIdentifier: identifier)
            }
            
            cell?.textField.placeholder = "Category Name"
            cell?.textField.text = category.name
            return cell!
        }
        
    }

}

//MARK: Table view Delegate
extension EditCategoryVC {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            return Cell_photo.height
        }else {
            return Cell_textField.height
        }
    }
}


//MARK: Add photo
extension EditCategoryVC {
    
    @objc private func takePhoto() {
        photoManager.takePhoto()
    }
    
    @objc private func choosePhoto() {
        photoManager.choosePhoto()
    }
}

extension EditCategoryVC: PhotoManagerDelegate {
    func getPhoto(photo: UIImage) {
        category.photo = photo.pngData()
        CoreDataManager.shared.saveContext()
        tableView.reloadData()
    }
}



