//
//  MemoTableViewController.swift
//  memoApp
//
//  Created by 加藤大 on 2020/02/11.
//  Copyright © 2020 加藤大. All rights reserved.
//

import UIKit
import RealmSwift


class MemoTableViewController: UITableViewController, UISearchBarDelegate {
    
    var memos = [String]()
    var searchResultMemos = [String]()
    var memoObjects: Results<Memo>!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    @IBAction func unwindToMemoList(sender: UIStoryboardSegue){
        guard let sourceVC = sender.source as? MemoViewController, let memo = sourceVC.memo, let tags = sourceVC.tags else{
            print("ガードしました！")
            return
        }
        if let selectedIndexPath = self.tableView.indexPathForSelectedRow{
            self.memos[selectedIndexPath.row] = memo
            
            // realm
            let realm = try! Realm()
            let memoModel = realm.objects(Memo.self).filter("id == " + String(sourceVC.memoId!)).first ?? Memo()
            try! realm.write {
                memoModel.title = memo
                memoModel.tags.removeAll()
                memoModel.tags.append(objectsIn: tags)
                memoModel.save()
            }
        }else{
            self.memos.append(memo)
            // realm
            let memoModel = Memo()
            let realm = try! Realm()
            try! realm.write {
                memoModel.title = memo
                memoModel.content = memo
                memoModel.tags.removeAll()
                memoModel.tags.append(objectsIn: tags)
                memoModel.save()
            }
        }
        
        self.tableView.reloadData()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        // realm 初期化
        let realm = try! Realm()
        self.memoObjects = realm.objects(Memo.self)
        // realmから情報取得
        if !self.memoObjects.isEmpty{
            for memoObject in self.memoObjects{
                self.memos.append(memoObject.title)
            }
        } else{
            self.memos = []//["memo1","memo2","memo3"]
        }
        self.searchResultMemos = self.memos
print(Realm.Configuration.defaultConfiguration.fileURL!)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.searchResultMemos.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemoTableViewCell", for: indexPath)

        // Configure the cell...
        
        cell.textLabel?.text = self.searchResultMemos[indexPath.row]
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let realm = try! Realm()
            let memoObjects = realm.objects(Memo.self)
            try! realm.write() {
                realm.delete(memoObjects[indexPath.row])
            }
            self.memos.remove(at: indexPath.row)
            
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    //検索ボタン押下時の呼び出しメソッド
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //キーボードを閉じる。
        searchBar.endEditing(true)
    }


    //テキスト変更時の呼び出しメソッド
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //検索結果配列を空にする。
        self.searchResultMemos.removeAll()
        if(searchBar.text == "") {
            //検索文字列が空の場合はすべてを表示する。
            self.searchResultMemos = memos
        } else {
            //検索文字列を含むデータを検索結果配列に追加する。
            for memo in memos {
                if memo.contains(self.searchBar.text!) {
                    self.searchResultMemos.append(memo)
                }
            }
        }
        //テーブルを再読み込みする。
        self.tableView.reloadData()
    }
    

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

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        guard let identifier = segue.identifier else {
            return
        }
        if identifier == "editMemo"{
            let memoVC = segue.destination as! MemoViewController
            memoVC.memo = self.memos[(self.tableView.indexPathForSelectedRow?.row)!]
            
            let realm = try! Realm()
            let memoObjects = realm.objects(Memo.self)
            memoVC.memoId = memoObjects[(self.tableView.indexPathForSelectedRow?.row)!].id
            memoVC.tags = Array(memoObjects[(self.tableView.indexPathForSelectedRow?.row)!].tags)
        }
    }

}
