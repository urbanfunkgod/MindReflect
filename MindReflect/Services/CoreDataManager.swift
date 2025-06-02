//
//  CoreDataManager.swift
//  MindReflect
//
//  Created by Johann Flores on 5/13/25.
//
import CoreData

class CoreDataManager {
    private let persistentContainer: NSPersistentContainer
    
    init() {
        persistentContainer = NSPersistentContainer(name: "MindReflect")
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Core Data store failed: \(error)")
            }
        }
        if var storeURL = persistentContainer.persistentStoreCoordinator.persistentStores.first?.url {
            var resourceValues = URLResourceValues()
            resourceValues.isExcludedFromBackup = true
            try? storeURL.setResourceValues(resourceValues)
        }
    }
    
    func saveEntry(_ entry: JournalEntry) {
        let context = persistentContainer.viewContext
        let entity = NSEntityDescription.insertNewObject(forEntityName: "JournalEntry", into: context)
        entity.setValue(entry.id, forKey: "id")
        entity.setValue(entry.content, forKey: "content")
        entity.setValue(entry.timestamp, forKey: "timestamp")
        entity.setValue(entry.type.rawValue, forKey: "type")
        entity.setValue(entry.tags, forKey: "tags")
        // Note: emotions are not saved here yet; we'll handle this if needed later
        
        do {
            try context.save()
        } catch {
            print("Failed to save entry: \(error)")
        }
    }
    
    func fetchEntries() -> [JournalEntry] {
        let context = persistentContainer.viewContext
        let request = NSFetchRequest<NSManagedObject>(entityName: "JournalEntry")
        
        do {
            let objects = try context.fetch(request)
            return objects.map { obj in
                JournalEntry(id: obj.value(forKey: "id") as! UUID,
                           content: obj.value(forKey: "content") as! String,
                           timestamp: obj.value(forKey: "timestamp") as! Date,
                           type: .init(rawValue: obj.value(forKey: "type") as! String)!,
                           tags: obj.value(forKey: "tags") as! [String],
                           emotions: []) // Temporarily empty since emotions aren't stored in CoreData yet
            }
        } catch {
            print("Failed to fetch entries: \(error)")
            return []
        }
    }
}
