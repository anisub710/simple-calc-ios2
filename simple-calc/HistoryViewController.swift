//
//  HistoryViewController.swift
//  simple-calc
//
//  Created by Anirudh Subramanyam on 10/20/18.
//  Copyright © 2018 Anirudh Subramanyam. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {

    var currHistory: [String] = []
    var history = UserDefaults.standard
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setHistory()
        fillScroll()
        // Do any additional setup after loading the view.
    }
    
    func setHistory(){
        currHistory = history.object(forKey: "History") as? [String] ?? [String]()
    }
    
    func fillScroll(){
        var content = CGRect.zero
        for i in 0...currHistory.count - 1 {
            let label = UILabel(frame: CGRect(x: 0, y: (i * 100), width: Int(UIScreen.main.bounds.width), height: 80))
            label.text = currHistory[i]
            self.scrollView.addSubview(label)
            content = content.union(label.frame)
        }
        scrollView.contentSize = content.size
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
