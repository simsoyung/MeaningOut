//
//  Database.swift
//  MeaningOut
//
//  Created by 심소영 on 7/7/24.
//

import UIKit
import RealmSwift

class Database: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted(indexed: true) var productId: String
    @Persisted var favorite: Bool
    
    convenience init(id: ObjectId, memoName: String, productId: String) {
        self.init()
        self.id = id
        self.productId = productId
        self.favorite = false
    }
}
