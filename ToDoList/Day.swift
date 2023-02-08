//
//  Day.swift
//  ToDoList
//
//  Created by EUNSUNG on 2023/02/08.
//

import Foundation

class Day {
    var date:Date
    var doing:[Doing] = []
    
    init(date: Date) {
        self.date = date
    }
    
    func addContent(content:String) {
        doing.append(Doing(checkBool: false, dayContent: ""))
    }
}

class Doing {
    var checkBool:Bool = false
    ///var everydayContent:String
    var dayContent:String
    
    init(checkBool: Bool, dayContent: String) {
        self.checkBool = checkBool
        self.dayContent = dayContent
    }
}
