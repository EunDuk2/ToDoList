//
//  ViewController.swift
//  ToDoList
//
//  Created by EUNSUNG on 2023/02/07.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var doing:[Day] = []
    let ud = UserDefaults.standard
    var formatter = DateFormatter()
    
    var index:Int = 0
    
    var today:String?
    
    @IBOutlet var lblToDo: UILabel!
    @IBOutlet var lblToDo2: UILabel!
    @IBOutlet var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        todayDoing()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        doing = getDoing()
        NSLog(doing[index].doingList[0] + "test")
            return doing[index].doingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = self.doing[index].doingList[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainDoingCell") as! MainDoingCell
        
        cell.lblDoing?.text = row
        NSLog("test")
        return cell
    }
    
    func todayDoing() {
        formatter.dateFormat = "yyyyMMdd"
        today = formatter.string(from: Date())
        
        doing = getDoing()
        if(todayCheckKey() != -1) {
            index = todayCheckKey()
            outputDay(i: index)
        }
    }
    
    func getDoing() -> [Day] {
        guard let savedData = ud.value(forKey: "day") as? Data,
                    let loadDoing = try? PropertyListDecoder().decode([Day].self, from: savedData) else { return [] }
                    return loadDoing
    }
    
    func todayCheckKey() -> Int {
        for i in 0..<doing.count {
            if(doing[i].key == today) {
                return i
            }
        }
        return -1
    }
    
    func outputDay(i:Int) {
        doing = getDoing()
        
        if(todayCheckKey() != -1) {
            lblToDo.text = doing[i].outputDate()
            lblToDo2.text = doing[i].outputDoing()
        } else {
            lblToDo2.text = ""
        }
    }
    
    @IBAction func onBack(_ sender: Any) {
        doing = getDoing()
        if(index > 0) {
            index -= 1
            outputDay(i: index)
            table.reloadData()
        }
        
    }
    
    @IBAction func onNext(_ sender: Any) {
        doing = getDoing()
        if(index < doing.count-1) {
            index += 1
            outputDay(i: index)
            table.reloadData()
        }
    }
    
    @IBAction func onToday(_ sender: Any) {
        todayDoing()
    }
    
    
}



