//
//  contentViewController.swift
//  EscapeGame2
//
//  Created by 維衣 on 2020/12/23.
//

import UIKit

@available(iOS 13.4, *)
class ContentViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var picImage: UIImageView!
    @IBOutlet weak var star: UILabel!
    @IBOutlet weak var accommodate: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var push: UIButton!
    
    var escapeData: InitEscapeData
    var nameText: String?
    
    init?(coder: NSCoder, escapeData: InitEscapeData) {
        self.escapeData = escapeData
        super.init(coder: coder)
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = escapeData.initEscape_Name
        
        star.text = "難易度：\(escapeData.initEscape_Star)"
        time.text = "遊戲時間：\(escapeData.initEscape_Timer)"
        accommodate.text = "遊戲人數：\(escapeData.initEscape_Accommodate)"
        
        content.lineBreakMode = NSLineBreakMode.byWordWrapping
        content.numberOfLines = 0
        content.text = escapeData.initEscape_Intro
        
        if let imageURL = URL(string: escapeData.initEscape_Picture){
            URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
                if let data = data {
                    DispatchQueue.main.async { [self] in
                    
                    picImage.image = UIImage(data: data)
                    }
                }
            }.resume()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let controller = storyboard?.instantiateViewController(withIdentifier:"ResVC") as? EscapeResViewController {
            controller.nameText = nameLabel.text!
            present(controller, animated: true, completion: nil)
        }
    }
}
