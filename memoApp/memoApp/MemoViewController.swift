//
//  MemoViewController.swift
//  memoApp
//
//  Created by 加藤大 on 2020/02/11.
//  Copyright © 2020 加藤大. All rights reserved.
//

import UIKit

class MemoViewController: UIViewController {

    var memo: String?
    
    @IBOutlet weak var memoTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let button = sender as? UIBarButtonItem, button === self.saveButton else{
            return
        }
        
        self.memo = self.memoTextField.text ?? ""
    }

}
