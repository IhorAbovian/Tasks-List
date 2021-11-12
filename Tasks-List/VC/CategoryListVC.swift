

import UIKit

class CategoryListVC: UITableViewController {

    
    var categories = [Category].init()
    
}


//MARK: Controller Life Cycle
extension CategoryListVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.config()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadCategories()
    }
}


//MARK: Configuration
extension CategoryListVC {
   
    private func config() {
        self.createAddButton()
        self.setTitle()
        
    }
    
    private func createAddButton() {
        let button = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(createSecondVC))
        navigationItem.rightBarButtonItem = button
    }
    
    @objc private func createSecondVC() {
        let vc = EditCategoryVC.init()
        let category = CoreDataManager.shared.createCategory()
        vc.category = category
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setTitle() {
        self.navigationItem.title = "Category List"
    }
    
    private func loadCategories() {
        categories = CoreDataManager.shared.getAllCategories()
        tableView.reloadData()
    }
}


//MARK: Table view data source
extension CategoryListVC {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "cell"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? Cell_category
        if cell == nil {
            cell = Cell_category.init(style: .value1, reuseIdentifier: identifier)
            cell?.accessoryType = .detailDisclosureButton
        }
        
        let category = categories[indexPath.row]
        
        cell?.textLabel?.text = category.name
        cell?.detailTextLabel?.text = String(category.tasks!.count)
        if let photoData = category.photo {
            if let photo = UIImage.init(data: photoData) {
                cell?.imageView?.image = photo
            }
        }
        return cell!
    }
}


//MARK: Table view Delegate
extension CategoryListVC {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Cell_category.height
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = TasksVC.init()
        let category = categories[indexPath.row]
        vc.category = category
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    // кнопка в конце ячейки
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let vc = EditCategoryVC.init()
        let category = categories[indexPath.row]
        vc.category = category
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.createAlertDelete(indexPath: indexPath)
        }
    }
}

//MARK: Delete category
extension CategoryListVC {
    
    private func createAlertDelete(indexPath: IndexPath) {
        let title = "Delete category"
        let message = "Delete?"
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        let yes = UIAlertAction.init(title: "yes", style: .destructive) { _ in
            let category = self.categories.remove(at: indexPath.row)
            CoreDataManager.shared.delete(category: category)
            self.tableView.deleteRows(at: [indexPath], with: .left)
        }
        let no = UIAlertAction.init(title: "no", style: .default)
        alert.addAction(yes)
        alert.addAction(no)
        self.present(alert, animated: true)
    }
}


