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
    func add(object: Object)
    func delete(object: Object)
    func check(object: Object) -> Bool
}

enum ConfigurationType {
    case basic
    case inMemory
}

class DBManager {
    
    var config = Realm.Configuration()
    let realm = try! Realm()
    
    init(config: ConfigurationType) {
        switch config {
        case .basic:
            self.config = Realm.Configuration()
        case .inMemory:
            self.config = Realm.Configuration(inMemoryIdentifier: "inMemory")
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
    
    func delete(object: Object) {
        do {
            
            try realm.write{
                realm.delete(object)
            }
        } catch let error as NSError {
            print(error)
        }
    }
    
    func check(object: Object, type: Object.Type) -> Bool {
        
        let objects = realm.objects(type)
        
        return objects.contains(object)
    }
    
    func retrieveAllObjects(type: Object.Type) -> [Object] {
        
        var allObjects: [Object] = []
        
        var realmResults = realm.objects(type)
        
        for object in realmResults {
            allObjects.append(object)
        }
        
        return allObjects
    }
}
