//
//  EditTasksVC.swift
//  CoreDataSpisokDel
//
//  Created by Igor Abovyan on 07.10.2021.
//

import UIKit

class EditTasksVC: UITableViewController {
    
    var task: Task!
    var photoManager: PhotoManager!
    
}

//MARK: Controller Life Style
extension EditTasksVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.config()
    }
}

//MARK: Configuration
extension EditTasksVC {
    
    private func config() {
        photoManager = PhotoManager.init(viewController: self)
        photoManager.myDelegate = self
        self.createSaveButton()
        self.setTitle()
    }
    
    private func createSaveButton() {
        let button = UIBarButtonItem.init(barButtonSystemItem: .save, target: self, action: #selector(save))
        navigationItem.rightBarButtonItem = button
    }
    
    @objc private func save() {
        let indexPath = IndexPath.init(row: 1, section: 0)
        let cellTextField = tableView.cellForRow(at: indexPath) as! Cell_textField
        task.name = cellTextField.textField.text
        CoreDataManager.shared.saveContext()
        navigationController?.popViewController(animated: true)
    }
    
    private func setTitle() {
        if let name = task.name {
            navigationItem.title = name
        }else {
            navigationItem.title = "Task"
        }
    }
}

//MARK: Table view data source
extension EditTasksVC {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let identifier = "cellPhoto"
            var cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? Cell_photo
            if  cell == nil {
                cell = Cell_photo.init(style: .subtitle, reuseIdentifier: identifier)
                
                cell?.takeButton.addTarget(self, action: #selector(take), for: .touchUpInside)
                
                cell?.chooseButton.addTarget(self, action: #selector(choose), for: .touchUpInside)
            }
            // отображение в таблицу то что есть в таск.фото
            if let photoData = task.photo {
                if let photo = UIImage.init(data: photoData) {
                    cell?.photoView.image = photo
                }
            }
            return cell!
        }else if indexPath.row == 1 {
            let identifier = "cellTextField"
            var cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? Cell_textField
            if  cell == nil {
                cell = Cell_textField.init(style: .subtitle, reuseIdentifier: identifier)
            }
            
            cell?.textField.text = task.name
            
            return cell!
        }else {
            let identifier = "cellRate"
            var cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? Cell_rate
            if  cell == nil {
                cell = Cell_rate.init(style: .subtitle, reuseIdentifier: identifier)
                
                for i in 0 ..< cell!.buttons.count {
                    cell?.buttons[i].addTarget(self, action: #selector(setRate(button:)), for: .touchUpInside)
                }
            }
            
            cell?.rateLabel.text = "Rate"
            
            for i in 0 ..< Int(task.rate) {
                cell!.buttons[i].backgroundColor = .orange
            }
            
            for i in Int(task.rate) ..< cell!.buttons.count {
                cell!.buttons[i].backgroundColor = .tintColor
            }
            return cell!
        }
        
    }
}

//MARK: Table view Delegate
extension EditTasksVC {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return Cell_photo.height
        }else if indexPath.row == 1 {
            return Cell_textField.height
        }else {
            return Cell_rate.height
        }
    }
}

extension EditTasksVC {
    
    @objc private func setRate(button: UIButton) {
        self.paintButtons(tag: button.tag)
        task.rate = Int16(button.tag)
        CoreDataManager.shared.saveContext()
    }
    
    private func paintButtons(tag: Int) {
        let indexPath = IndexPath.init(row: 2, section: 0)
        if let cellRate = tableView.cellForRow(at: indexPath) as? Cell_rate {
            for i in 0 ..< tag {
                cellRate.buttons[i].backgroundColor = .orange
            }
            
            for i in tag ..< cellRate.buttons.count {
                cellRate.buttons[i].backgroundColor = .tintColor
            }
        }
    }
}

//MARK: Add photo
extension EditTasksVC {
    
    @objc private func take() {
        photoManager.takePhoto()
    }
    
    @objc private func choose() {
        photoManager.choosePhoto()
        
    }
}

extension EditTasksVC: PhotoManagerDelegate {
    func getPhoto(photo: UIImage) {
        let photoData = photo.pngData()
        task.photo = photoData
        CoreDataManager.shared.saveContext()
        tableView.reloadData()
    }
}
