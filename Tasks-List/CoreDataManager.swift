//
//  CoreDataManager.swift
//  CoreDataSpisokDel
//
//  Created by Igor Abovyan on 05.10.2021.
//

import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager.init()
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "CoreDataSpisokDel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

//MARK: Create
extension CoreDataManager {
    
    func createCategory() -> Category {
        let context = persistentContainer.viewContext
        let category = Category.init(context: context)
        self.saveContext()
        return category
    }
    
    func createTasks(category: Category) -> Task {
        let context = persistentContainer.viewContext
        let task = Task.init(context: context)
        category.addToTasks(task)
        self.saveContext()
        return task
    }
}


//MARK: Get objects
extension CoreDataManager {
    
    func getAllCategories() -> [Category] {
        // создаем запрос
        let fetchRequest = NSFetchRequest<Category>.init(entityName: "Category")
        //сортировка (по имени)
        let sortDescriptor = NSSortDescriptor.init(key: #keyPath(Category.name), ascending: true)
        // запрос для поиска
        fetchRequest.sortDescriptors = [sortDescriptor]
        // получаем контекст
        let context = persistentContainer.viewContext
        do {
            // создаем масив в который пытаемся получить ответ на запрос
            let categories = try context.fetch(fetchRequest)
            return categories
            
        }catch {
            fatalError("Не удалось получить категории")
        }
    }
    
    func getTasksFor(category: Category) -> [Task] {
        let fetchRequest = NSFetchRequest<Task>.init(entityName: "Task")
        let sortDescriptor = NSSortDescriptor.init(key: #keyPath(Task.name), ascending: true)
        let predicate = NSPredicate.init(format: "category == %@", category)
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = [sortDescriptor]
        let context = persistentContainer.viewContext
        do {
            let tasks = try context.fetch(fetchRequest)
            return tasks
        }catch {
            fatalError("error")
        }
    }
}

//MARK: Delete
extension CoreDataManager {
    
    func delete(category: Category) {
        category.tasks?.forEach({ task in
            category.removeFromTasks(task as! Task)
            delete(task: task as! Task)
        })
        
        let context = persistentContainer.viewContext
        context.delete(category)
        self.saveContext()
    }
    
    
    func delete(task: Task) {
        let category = task.category
        category?.removeFromTasks(task)
        let context = persistentContainer.viewContext
        context.delete(task)
        self.saveContext()
    }
    
    
}
