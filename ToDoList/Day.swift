//
//  Day.swift
//  ToDoList
//
//  Created by EUNSUNG on 2023/02/08.
//

import Foundation

class Day: Codable {
    let key: String?
    let date: String?
    var doing: [String] = []
    
    init(key: String?, date: String?) {
        self.key = key
        self.date = date
    }
    
    func addDoing(Doing:String) {
        doing.append(Doing)
    }
    
    func outputDate() -> String {
        return date!
    }
    
    func outputDoing() -> String {
        var List: String = ""
        for i in 0..<doing.count {
            List += (doing[i] + "\n")
        }
        return List
    }
    
    
}
