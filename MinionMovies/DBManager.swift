//
//  DBManageAllMovies.swift
//  MinionMovies
//
//  Created by Vitor Costa on 20/04/20.
//  Copyright © 2020 Vitor Costa. All rights reserved.
//

import Foundation
import RealmSwift

protocol DBManagerProtocol {
    init(config: ConfigurationType)
    
    func add(object: Object)
    func delete(objectId: String, type: Object.Type)
    func retrieveObject(id: String, type: Object.Type) -> Object?
    func retrieveAllObjects(type: Object.Type) -> [Object]
}

enum ConfigurationType {
    case basic
    case inMemory
}

class DBManager: DBManagerProtocol {
    var config = Realm.Configuration()
    var realm: Realm
    
    required init(config: ConfigurationType) {
        switch config {
        case .basic:
            self.realm = try! Realm()
        case .inMemory:
            self.realm = try! Realm(configuration: Realm.Configuration(inMemoryIdentifier: "inMemory"))
        }
    }
    
    func add(object: Object) {
        do {
            
            try realm.write {
                realm.add(object, update: .modified)
            }
        } catch let error as NSError {
            print(error)
        }
    }
    
    func delete(objectId: String, type: Object.Type) {
        do {
            
            try realm.write{
                realm.delete(realm.objects(type).filter("id == '\(objectId)'"))
            }
        } catch let error as NSError {
            print(error)
        }
    }
    
    func retrieveObject(id: String, type: Object.Type) -> Object? {
        let objects = realm.objects(type).filter("id = '\(id)'")
        
        return objects.first
    }
    
    func retrieveAllObjects(type: Object.Type) -> [Object] {
        var allObjects: [Object] = []
        let realmResults = realm.objects(type)
        
        for object in realmResults {
            allObjects.append(object)
        }
        
        return allObjects
    }
}
