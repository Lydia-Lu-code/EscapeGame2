//
//  MeunTableViewController.swift
//  EscapeGame2
//
//  Created by 維衣 on 2020/12/21.
//

import UIKit
import Foundation

@available(iOS 13.4, *)
class MenuTableViewController: UITableViewController {

    var escapeData = [InitEscapeData]()
    
    @IBSegueAction func showContentVC(_ coder: NSCoder) -> ContentViewController? {
        guard let row = tableView.indexPathForSelectedRow?.row else { return nil }
        return ContentViewController(coder: coder, escapeData: escapeData[row])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }

    func getData() {
        
        if let url = URL(string: UrlRequestTask.shared.spreadSheetMenuLink) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in

            if let data = data, let GoogleSheetJSON = try? JSONDecoder().decode(GoogleSheetJSON.self, from: data) {
                let escapeSheets = GoogleSheetJSON.feed.entry
                
                for i in 0...escapeSheets.count - 1 {
                    let name = escapeSheets[i].name.text
                    let intro = escapeSheets[i].intro.text
                    let picture = escapeSheets[i].picture.text
                    let address = escapeSheets[i].address.text
                    let accommodate = escapeSheets[i].accommodate.text
                    let star = escapeSheets[i].star.text
                    let timer = escapeSheets[i].timer.text
                    
                    let getDatas = InitEscapeData(initEscape_Name: name, initEscape_Intro: intro, initEscape_Picture: picture, initEscape_Address: address, initEscape_Accommodate: accommodate, initEscape_Star: star, initEscape_Timer: timer)
                    
                    self.escapeData.append(getDatas)
                }
                DispatchQueue.main.async{
                    self.tableView.reloadData()
                }
            }
        }.resume()
        }
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
 
        return escapeData.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let showEscape = escapeData[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as? MenuTableViewCell
        
        cell?.picImage.image = UIImage(named: "0.jpg")
        cell?.nameLabel.text = "\(showEscape.initEscape_Name)"
        cell?.introLabel.text = "\(showEscape.initEscape_Intro)"
        cell?.accommodateLabel.text = "\(showEscape.initEscape_Accommodate)"

        if let imageURL = URL(string: showEscape.initEscape_Picture){
            URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
                if let data = data {
                    DispatchQueue.main.async {
                    cell?.picImage.image = UIImage(data: data)
                    }
                }
            }.resume()
        }
        return cell!
    }
    

    
    
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//        if let controller = segue.destination as? ContentViewController,
//           let row = tableView.indexPathForSelectedRow?.row {
//            controller.escapeData = escapeData[row]
//        }
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
    

}
