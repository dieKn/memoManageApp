//
//  RObject.swift
//  memoApp
//
//  Created by 加藤大 on 2020/03/01.
//  Copyright © 2020 加藤大. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class RObject: Object {
    // ID
    @objc dynamic var id = 0

    // データを保存。
    func save() {
        let realm = try! Realm()
        if realm.isInWriteTransaction {
            if self.id == 0 { self.id = self.createNewId() }
            realm.add(self, update: .modified)
        } else {
            try! realm.write {
                if self.id == 0 { self.id = self.createNewId() }
                realm.add(self, update: .modified)
            }
        }
    }

//    // 新しいIDを採番します。
    private func createNewId() -> Int {
        let realm = try! Realm()
        return (realm.objects(type(of: self).self).sorted(byKeyPath: "id", ascending: false).first?.id ?? 0) + 1
    }

    // プライマリーキーの設定
    override static func primaryKey() -> String? {
        return "id"
    }
}
