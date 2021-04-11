//
//  ReservationViewController.swift
//  EscapeGame2
//
//  Created by 維衣 on 2020/12/28.
//

import UIKit

@available(iOS 13.4, *)
class EscapeResViewController: UIViewController,UITextFieldDelegate{
    
    @IBOutlet weak var res_escapeLabel: UILabel!
    @IBOutlet weak var res_datePicker: UIDatePicker!
    @IBOutlet weak var res_peopleText: UITextField!
    @IBOutlet weak var res_stepper: UIStepper!
    @IBOutlet weak var res_megText: UITextView!
    @IBOutlet weak var res_button: UIButton!
    @IBOutlet weak var res_timePicker: UIPickerView!
    @IBOutlet weak var res_nameText: UITextField!
    @IBOutlet weak var res_telNumber: UITextField!
    @IBOutlet weak var res_peopleMeno: UILabel!
    @IBOutlet weak var res_phoneMeno: UILabel!
    
    var nameText: String! = ""
    var resDate: String = ""
    var timerArray = [String]()
    var resContent = [ResContent]()
    var pickerTitle:String = ""
    let timePicker = UIDatePicker()
    var valueRange = [Int]()
    var pNumCount: Int = 0
    var minimum: Int = 0
    var maximum: Int = 0
    var escapeDate: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        didViewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyBoard))
            self.view.addGestureRecognizer(tap)
        
        let tomorrow = Date().addingTimeInterval(86400)
        res_datePicker.minimumDate = tomorrow
        res_peopleText.keyboardType = .numberPad
        res_telNumber.keyboardType = .numberPad
        res_phoneMeno.text = "請輸入含09共10碼手機號碼"
    }
    
    func didViewDidLoad(){

        res_escapeLabel.text = (nameText)
        res_datePicker.preferredDatePickerStyle = .compact
        res_megText.text = "注意事項: \n\n★遊戲進行過程禁止攜帶危險物品，例如:尖銳物品。\n\n★遊戲過程禁止拍照、攝影、錄音，不需要攜帶個人電子產品，請將密室內的一切保密。\n\n★遊戲空間內標有禁止觸碰及警告標語，請遵照指示，不用觸碰、使用，不執行禁止的動作。\n\n★有心臟疾病、幽閉恐懼症者，或是孕婦，請於預約時事先告知，斟酌是否適合參加遊戲。"
        res_timePicker.delegate = self
        res_timePicker.dataSource = self

        showEscapeTimer(resName: String(res_escapeLabel.text!))
    }
    
    
    @objc func dismissKeyBoard() {
            self.view.endEditing(true)
        }
    
    @IBAction func resSelectdata(_ sender: Any) {
        let dataFormatter = DateFormatter()
        dataFormatter.dateFormat = "yyy/MM/dd"
        res_datePicker.locale = Locale(identifier: "zh_TW")
        resDate = dataFormatter.string(from: res_datePicker.date)
    }
    
    @IBAction func playPeople(_ sender: UIStepper) {
        res_peopleText.text = "\(Int(sender.value))"
        settingStepper(res_escapeLabel.text!)
    }
    
    @IBAction func uploadBtn(_ sender: UIButton) {
          
        if (res_nameText.text!).isEmpty == false && checkPhone(res_telNumber.text!) == true {
            sendData()
        }else{
            let controller = UIAlertController(title: "是否還有資料沒輸入?", message: "輸入不正確?", preferredStyle: .actionSheet)
            let action = UIAlertAction(title: "重新確認", style: .default) { (action) in
               }

            let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            controller.addAction(action)
            controller.addAction(cancelAction)

            present(controller, animated: true, completion: nil)
            
        }
    }
    
    func postRes(with newRes: ResContent){
        var reguest = URLRequest(url: URL(string: "\(UrlRequestTask.shared.sheetDBResLink)")!)
        reguest.httpMethod = "POST"
        reguest.setValue("application/json", forHTTPHeaderField: "Content-type")

        let resData = UploadData(data: newRes)
        
        if let uploadDbData = try? JSONEncoder().encode(resData){
            URLSession.shared.uploadTask(with: reguest, from: uploadDbData){(data, response, error) in
                if let data = data,let passResult = try? JSONDecoder().decode([String:Int].self, from: data),passResult["created"] == 1 {
                    print("**OK")
                }else{
                    print("**error")
                }
            }.resume()
        }
    }
    
    func sendData(){
        let escapeResName = res_escapeLabel.text!

        let formatter = DateFormatter()
            formatter.locale = Locale.init(identifier: "zh_TW")
            formatter.dateFormat = String("yyy/MM/dd")
        let tomorrow = Date().addingTimeInterval(86400)

        if resDate.isEmpty == true {
        escapeDate = formatter.string(from: tomorrow)
        }else{
        escapeDate = resDate
        }
        
        let row = res_timePicker?.selectedRow(inComponent: 0)
        let escapeTimer = String(timerArray[row!])
        //sheetDB的儲存格要設格式不然會是小數點
        let escapePeople = res_peopleText.text!
        let escapeName = res_nameText.text!
        let escapeTel = "\(res_telNumber.text!)"
        let newResContent = ResContent(res_topic: escapeResName, res_date: escapeDate, res_time: escapeTimer, res_people: escapePeople, res_name: escapeName, res_tel: escapeTel)

        self.resContent.append(newResContent)
        postRes(with: newResContent)
    }
    
    func showEscapeTimer(resName: String){

    switch resName {
    case "莎士比亞的邀請":
        timerArray = ["10:15","11:45","13:15","14:45","16:15","17:45","19:15","20:45"]
        valueRange = [2,6]
        res_peopleText.text = String(valueRange[0])
        res_peopleMeno.text = "本場遊戲遊玩人數：\(valueRange[0])到\(valueRange[1])人"
    case "時鐘之國":
        timerArray = ["09:30","11:00","12:30","13:30","15:00","16:30","17:30","19:00","20:30"]
        valueRange = [2,4]
        res_peopleText.text = String(valueRange[0])
        res_peopleMeno.text = "本場遊戲遊玩人數：\(valueRange[0])到\(valueRange[1])人"
    case "鄉間小盜":
        timerArray = ["10:30","11:30","12:30","13:30","14:30","15:30","16:30","17:30","18:30","19:30","20:30"]
        valueRange = [2,4]
        res_peopleText.text = String(valueRange[0])
        res_peopleMeno.text = "本場遊戲遊玩人數：\(valueRange[0])到\(valueRange[1])人"
    case "禁錮之村":
        timerArray = ["11:00","13:00","15:00","17:00","19:00","21:00"]
        valueRange = [5,10]
        res_peopleText.text = String(valueRange[0])
        res_peopleMeno.text = "本場遊戲遊玩人數：\(valueRange[0])到\(valueRange[1])人"
    case "流亡黯道":
        timerArray = ["11:00","13:00","15:00","17:00","19:00","21:00"]
        valueRange = [4,8]
        res_peopleText.text = String(valueRange[0])
        res_peopleMeno.text = "本場遊戲遊玩人數：\(valueRange[0])到\(valueRange[1])人"
    default: break
            }
        }
    
    func settingStepper(_ resName: String){

        res_stepper.minimumValue = Double(valueRange[0])
        res_stepper.maximumValue = Double(valueRange[1])
        res_stepper.stepValue = 1
        res_stepper.autorepeat = true

        // UIStepper 是否可以在變動時同步執行動作
        // 設定 false 時 則是放開按鈕後才會執行動作
        res_stepper.isContinuous = true

        // UIStepper 數值是否可以循環
        // 例如填 true 時 如果值已達到最大值
        // 再按一次 + 會循環到最小值繼續加
        res_stepper.wraps = false

        // UIStepper 按下增減按鈕後 執行的動作
        res_stepper.addTarget(self, action: #selector(onStepperChange), for: .valueChanged)

    }
    @objc func onStepperChange() {
        // 將 UILabel 的值設置為 UIStepper 目前的值
        res_peopleText.text = "\(Int(res_stepper.value))"
    }
    
    func checkPhone(_ phoneNumber: String) -> Bool {
        pNumCount = 0
            for _ in phoneNumber{
                pNumCount += 1
            }
        if pNumCount == 10 && (res_telNumber.text!).hasPrefix("09") == true{
            return true
        }else{
        return false
            
        }
    }
    
    func alartResOk(){
        let controller = UIAlertController(title: "預約成功!", message: "恭喜你預約成功!別忘了準時到達現場唷!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "確定", style: .default, handler: nil)
        controller.addAction(okAction)
        present(controller, animated: true, completion: nil)
    }
}

@available(iOS 13.4, *)
extension EscapeResViewController: UIPickerViewDelegate,UIPickerViewDataSource{

    // UIPickerView 有幾列可以選
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // UIPickerView 各列有多少行資料
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return timerArray.count
    }
    
    // UIPickerView 每個選項顯示的資料
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        _ = "\(timerArray[row].description)"
        return timerArray[row]
    }
    
}
