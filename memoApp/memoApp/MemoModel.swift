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
    @objc dynamic var tags : String = ""
    @objc dynamic var createdDate : Date = NSDate() as Date
    @objc dynamic var updatedDate : Date = NSDate() as Date
    
}
