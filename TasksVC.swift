//
//  CreateTasksVC.swift
//  CoreDataSpisokDel
//
//  Created by Igor Abovyan on 07.10.2021.
//

import UIKit

class TasksVC: UITableViewController {
    
    var category: Category!
    private var tasks = [Task].init()
}


//MARK: Controller life cucle
extension TasksVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.config()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadTasks()
    }
}


//MARK: Configuration
extension TasksVC {
    
    private func config() {
        self.createAddButton()
        self.setTitle()
    }
    
    private func createAddButton() {
        let button = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(createTasks))
        navigationItem.rightBarButtonItem = button
    }
    
    @objc private func createTasks() {
        let vc = EditTasksVC.init()
        let task = CoreDataManager.shared.createTasks(category: category)
        vc.task = task
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setTitle() {
        self.navigationItem.title = "Tasks"
    }
    
    private func loadTasks() {
        tasks = CoreDataManager.shared.getTasksFor(category: category)
        tableView.reloadData()
    }
}


//MARK: Table view data source
extension TasksVC {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "cellTask"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? Cell_task
        if cell == nil {
            cell = Cell_task.init(style: .subtitle, reuseIdentifier: identifier)
            cell?.accessoryType = .disclosureIndicator
        }
        
        let task = tasks[indexPath.row]
        cell?.textLabel?.text = task.name
        if let photoData = task.photo {
            if let photo = UIImage.init(data: photoData) {
                cell?.imageView?.image = photo
            }
        }
        
        for i in 0 ..< Int(task.rate) {
            cell!.circles[i].backgroundColor = .orange
        }
        
        for i in Int(task.rate) ..< cell!.circles.count {
            cell!.circles[i].backgroundColor = .tintColor
        }
        
        return cell!
    }
}


//MARK: Table view Delegate
extension TasksVC {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let task = tasks[indexPath.row]
        let vc = EditTasksVC.init()
        vc.task = task
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Cell_task.height
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.createAlertDelete(indexPath: indexPath)
        }
    }
}

//MARK: Delete task
extension TasksVC {
    
    private func createAlertDelete(indexPath: IndexPath) {
        let title = "Delete task"
        let message = "Delete?"
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        let yes = UIAlertAction.init(title: "yes", style: .destructive) { _ in
            let task = self.tasks.remove(at: indexPath.row)
            CoreDataManager.shared.delete(task: task)
            // анимация удаления
            self.tableView.deleteRows(at: [indexPath], with: .left)
        }
        
        let no = UIAlertAction.init(title: "no", style: .default)
        alert.addAction(yes)
        alert.addAction(no)
        self.present(alert, animated: true)
    }
}
