//
//  ViewController.swift
//  ToDoList
//
//  Created by EUNSUNG on 2023/02/07.
//

import UIKit

class ViewController: UIViewController {
    let ud = UserDefaults.standard
    
    @IBOutlet var lblToDo: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let DatePick = ud.string(forKey: "DatePick")
        
        lblToDo.text = DatePick
    }
    
}



