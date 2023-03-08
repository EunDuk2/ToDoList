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
    
    @IBOutlet var lblToDo2: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let DatePick = ud.string(forKey: "DatePick")
        //let Doing = ud.string(forKey: "Doing")
        
        lblToDo.text = DatePick
        //lblToDo2.text = Doing
        
        let DoingList = ud.array(forKey: "arr")
        lblToDo2.text = (DoingList as? String)
        
    }
    
}



