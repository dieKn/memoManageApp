//
//  MemoViewController.swift
//  memoApp
//
//  Created by 加藤大 on 2020/02/11.
//  Copyright © 2020 加藤大. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class MemoViewController: UIViewController {

    var memo: String?
    var memoId: Int?
    var tags: Array<Tag>?
    
    @IBOutlet weak var memoTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var tagTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.saveButton.isEnabled = false
        if let memo = self.memo{
            self.memoTextField.text = memo
            self.navigationItem.title = "Edit Memo"
        }
        if let memoId = self.memoId{
            self.memoId = memoId
        }
        if let memoTags = self.tags{
            var tagNameArray = Array<String>()
            memoTags.forEach {tag in
                tagNameArray.append(tag.tagName)
            }
            self.tagTextField.text = tagNameArray.joined(separator: ",")
        }
        self.updateSaveButtonState()
    }
    
    private func updateSaveButtonState(){
        let memo = self.memoTextField.text ?? ""
        self.saveButton.isEnabled = !memo.isEmpty
    }
    @IBAction func memoTextFieldChanged(_ sender: Any) {
        self.updateSaveButtonState()
    }
    
    @IBAction func cancel(_ sender: Any) {
        if self.presentingViewController is UINavigationController{
            self.dismiss(animated: true, completion: nil)
        }else{
            self.navigationController?.popViewController(animated: true)
        }
        
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
        let inputTagName = self.tagTextField.text ?? ""
        let tagNames = inputTagName.split(separator: ",")
        self.tags = Array<Tag>()
        tagNames.forEach{tagName in
            let tag = Tag()
            tag.tagName = String(tagName)
            self.tags?.append(tag)
        }
    }

}
