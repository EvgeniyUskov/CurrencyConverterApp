//
//  StoragemanagerStub.swift
//  RxConverterAppSKBTests
//
//  Created by Evgeniy Uskov on 14/02/2021.
//

import Foundation
import CoreData
@testable import CurrencyConverterApp

//MARK: CoreDataManager
public class StorageManagerStub{
    
    //MARK: Properties
    private var testCoreDataStack = TestCoreDataStack()
    private lazy var container = testCoreDataStack.storeContainer
    private lazy var privateContext = container.newBackgroundContext()
}

//MARK: CurrencyStorageProtocol Implementation methods
extension StorageManagerStub: StorageManagerProtocol {
    //MARK: Load
    public func loadCurrencyCachedEntities(with searchTerm: String? = nil, completionHandler: @escaping (([CurrencyCachedEntity]) -> ())) {
        var entities = [CurrencyCachedEntity]()
        for i in 1...5 {
            let entity = CurrencyCachedEntity(context: self.privateContext)
            entity.currencyName = "fooName\(i)"
            entity.id = "foo\(i)"
            entities.append(entity)
            completionHandler(entities)
        }
    }
    
    private func loadEntitiesContainText(searchTerm: String?) -> [CurrencyCachedEntity]? {
        if let _ = searchTerm {
            var entities = [CurrencyCachedEntity]()
            for i in 1...5 {
                let entity = CurrencyCachedEntity(context: self.privateContext)
                entity.currencyName = "fooName\(i)"
                entity.id = "foo\(i)"
                entities.append(entity)
            }
                return entities
        }
        return nil
    }
    
    private func loadAllEntities() -> [CurrencyCachedEntity]? {
        var entities = [CurrencyCachedEntity]()
        for i in 1...5 {
            let entity = CurrencyCachedEntity(context: self.privateContext)
            entity.currencyName = "fooName\(i)"
            entity.id = "foo\(i)"
            entities.append(entity)
        }
            return entities
    }
    
    //MARK: Craete
    public func createCurrencyChachedEntity() -> CurrencyCachedEntity {
        let entity = CurrencyCachedEntity(context: privateContext)
        return entity
    }
    
    //MARK: Save
    public func saveCurrencyCachedEntities(_ entities: [CurrencyCachedEntity], completionHandler: @escaping () -> () ) {
        completionHandler()
    }
    
    public var context: NSManagedObjectContext {
        return privateContext
    }
}
