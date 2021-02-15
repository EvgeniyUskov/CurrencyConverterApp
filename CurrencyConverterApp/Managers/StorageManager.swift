//
//  StorageManager.swift
//  RxClimaAppSKB
//
//  Created by Evgeniy Uskov on 10/02/2021.
//

import UIKit
import CoreData

//MARK: Protocols
public protocol StorageManagerProtocol {
    func loadCurrencyCachedEntities(with searchTerm: String?, completionHandler: @escaping (([CurrencyCachedEntity]) -> ()))
    
    func createCurrencyChachedEntity() -> CurrencyCachedEntity
    func saveCurrencyCachedEntities(_ entities: [CurrencyCachedEntity], completionHandler: @escaping () -> () )
}

//MARK: CoreDataManager
public class StorageManager{
    
    //MARK: Properties
    private let container = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
    private lazy var privateContext = container.newBackgroundContext()
}

//MARK: CurrencyStorageProtocol Implementation methods
extension StorageManager: StorageManagerProtocol {
    //MARK: Load
    public func loadCurrencyCachedEntities(with searchTerm: String? = nil, completionHandler: @escaping (([CurrencyCachedEntity]) -> ())) {
        DispatchQueue.global(qos: .utility).async {
            [weak self] in
            var sources: [CurrencyCachedEntity]?
            
            if let searchTerm = searchTerm {
                if searchTerm.isEmpty {
                    sources = self?.loadAllEntities()
                } else {
                    sources = self?.loadEntitiesContainText(searchTerm: searchTerm)
                }
            } else {
                sources = self?.loadAllEntities()
            }
            
            if let sourcesArray = sources {
                completionHandler(sourcesArray)
            } else {
                completionHandler([CurrencyCachedEntity]())
            }
        }
    }
    
    private func loadEntitiesContainText(searchTerm: String?) -> [CurrencyCachedEntity]? {
        if let searchTerm = searchTerm {
            let request : NSFetchRequest<CurrencyCachedEntity> = CurrencyCachedEntity.fetchRequest()
            let textContainsPredicate = NSPredicate(format: "currencyName CONTAINS[c] %@ OR id CONTAINS[c] %@", searchTerm, searchTerm)
            request.predicate = textContainsPredicate
            do {
                let loadedSources = try privateContext.fetch(request)
                return loadedSources
            } catch {
                return nil
            }
        }
        return nil
    }
    
    private func loadAllEntities() -> [CurrencyCachedEntity]? {
        do {
            return try privateContext.fetch(CurrencyCachedEntity.fetchRequest())
        } catch {
            return nil
        }
    }
    
    //MARK: Craete
    public func createCurrencyChachedEntity() -> CurrencyCachedEntity {
        let entity = CurrencyCachedEntity(context: privateContext)
        return entity
    }
    
    //MARK: Save
    public func saveCurrencyCachedEntities(_ entities: [CurrencyCachedEntity], completionHandler: @escaping () -> () ) {
        
            let contextArray = entities.compactMap{
                $0.managedObjectContext
            }
            let contextSet = Set(contextArray)
            
            contextSet.forEach {
                context in
                do {
                    try context.save()
                } catch {
                    print("Error saving context \(error)")
                }
            }
//            try privateContext.save()
            completionHandler()
        
    }
}
