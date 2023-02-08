//
//  ViewController.swift
//  ToDoList
//
//  Created by EUNSUNG on 2023/02/07.
//

import UIKit

class ViewController: UIViewController {
    var day:[Day] = []
    
    @IBOutlet var testLabel: UILabel!
    
    @IBOutlet var testLabel2: UILabel!
    @IBOutlet var txtContent: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        test()
    }
    func test() {
        day.append(Day(date: DateFormatter()))
        
    }

    @IBAction func acBtnOk(_ sender: UIButton) {
        day[0].addContent(content: txtContent.text!)
        
        testLabel2.text = day[0].doing[0].dayContent
    }
}



