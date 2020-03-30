//
//  MemoModel.swift
//  memoApp
//
//  Created by 加藤大 on 2020/02/24.
//  Copyright © 2020 加藤大. All rights reserved.
//

import Foundation
import RealmSwift

class Memo: RObject {
    @objc dynamic var title : String = ""
    @objc dynamic var content : String = ""
    @objc dynamic var createdDate : Date = NSDate() as Date
    @objc dynamic var updatedDate : Date = NSDate() as Date
    
    // タグ機能
    var tags = List<Tag>()
}

class Tag: Object {
    @objc dynamic var tagName = ""
    
    var memos: LinkingObjects<Memo> {
        return LinkingObjects(fromType: Memo.self, property: "tags")
    }
}
