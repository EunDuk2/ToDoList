//
//  ViewController.swift
//  ToDoList
//
//  Created by EUNSUNG on 2023/02/07.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, TableViewCellDelegate {
    
    var doing:[Day] = []
    let ud = UserDefaults.standard
    var formatter = DateFormatter()
    
    var index:Int = 0
    
    var today:String?
    
    @IBOutlet var lblToDo: UILabel!
    @IBOutlet var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        todayDoing()
        table.reloadData()
    }
    
    func didTapButton(cellIndex: Int?, button: UIButton?) {
        // 메시지창 객체 생성
        let alert = UIAlertController(title: "선택", message: "체크여부를 선택해주세요", preferredStyle: .actionSheet)

        let clear = UIAlertAction(title: "✅ 완료", style: .default) { (_) in
            if(button?.title(for: .normal) != "✅") {
                button?.setTitle("✅", for: .normal)
                self.doing[self.index].checkButton[cellIndex!] = "✅"
            }
        }
        
        let delay = UIAlertAction(title: "💬 미루기", style: .default) { (_) in
            if(button?.title(for: .normal) != "💬") {
                button?.setTitle("💬", for: .normal)
                self.doing[self.index].checkButton[cellIndex!] = "💬"
                let delayDoing = self.doing[self.index].doingList[cellIndex!]
                
                self.addTomorrow(delayDoing: delayDoing)
            }
        }
        
        let cancel = UIAlertAction(title: "❎ 취소", style: .destructive) { (_) in
            if(button?.title(for: .normal) != "❎") {
                button?.setTitle("❎", for: .normal)
                self.doing[self.index].checkButton[cellIndex!] = "❎"
            }
        }
        
        let origin = UIAlertAction(title: "🟩 원래대로", style: .default) { (_) in
            if(button?.title(for: .normal) != "🟩") {
                button?.setTitle("🟩", for: .normal)
                self.doing[self.index].checkButton[cellIndex!] = "🟩"
            }
        }
        
        let back = UIAlertAction(title: "돌아가기", style: .cancel) { (_) in }
        
        alert.addAction(clear)
        alert.addAction(delay)
        alert.addAction(cancel)
        alert.addAction(origin)
        alert.addAction(back)
        
        self.present(alert, animated: true)
        
        ud.set(try? PropertyListEncoder().encode(doing), forKey: "day")
    }
    
    func addTomorrow(delayDoing: String) {
        // 보고 있는 날짜의 날짜 키를 가져와보자 일단
        let nowKey = doing[index].key
        // 가져왔으니까 string인 키를 date로 바꾸고
        let now = nowKey?.toDate()?.timeIntervalSince1970
        // 다음날 계산
        
        
        // 지금은 오늘 날짜 가져와서 다음날 계산한 거임
        // 지금 보고 있는 날짜에 다음날 계산해서 추가해야됨
        // 다음날 doing 존재하는지 검사하기
        
        let tomorrowKey: String?
        let tomorrowDate: String?
//
//        let now = Date().timeIntervalSince1970
//
        let date: DateFormatter = {
            let df = DateFormatter()
            df.locale = Locale(identifier: "ko_KR")
            df.timeZone = TimeZone(abbreviation: "KST")
            df.dateFormat = "yyyyMMdd"
            return df
        }()

        let today = Int(now!) + 86400
        let timeInterval = TimeInterval(today)
        let cellTxt = Date(timeIntervalSince1970: timeInterval)

        //lblToDo.text = "\(date.string(from: cellTxt))"
        tomorrowKey = String(date.string(from: cellTxt))

        date.dateFormat = "MM월 dd일"
        tomorrowDate = String(date.string(from: cellTxt))
        
        let i = checkTomorrow(dateKey: tomorrowKey!)
        if (i != -1) {
            doing[i].addDoing(Doing: delayDoing)
            doing[i].addButton(ButtonText: "🟩")
        } else if (i == -1) {
            doing.append(Day(key: tomorrowKey, date: tomorrowDate))
            doing[index+1].addDoing(Doing: delayDoing)
            doing[index+1].addButton(ButtonText: "🟩")
        }
        doing.sort(by: {$0.key! < $1.key!})
        
        ud.set(try? PropertyListEncoder().encode(doing), forKey: "day")
    }
    
    func checkTomorrow(dateKey: String) -> Int {
        for i in 0..<doing.count {
            if(doing[i].key == dateKey) {
                return i
            }
        }
        return -1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        doing = getDoing()
        
        if(doing.count != 0) {
            return doing[index].doingList.count
        } else {
            return 0
        }
            
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row1 = self.doing[index].checkButton[indexPath.row]
        let row2 = self.doing[index].doingList[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainDoingCell") as! MainDoingCell
        
        cell.index = indexPath.row
        cell.btnCheck?.setTitle(row1, for: .normal)
        cell.lblDoing?.text = row2
        
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func todayDoing() {
        formatter.dateFormat = "yyyyMMdd"
        today = formatter.string(from: Date())
        
        doing = getDoing()
        if(todayCheckKey() != -1) {
            index = todayCheckKey()
            outputDay(i: index)
        } else {
            formatter.dateFormat = "MM월 dd일"
            lblToDo.text = formatter.string(from: Date())
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
        } else {
            
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
        table.reloadData()
    }
    
    
}

extension String {
    func toDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        if let date = dateFormatter.date(from: self) {
            return date
        } else {
            return nil
        }
    }
}


