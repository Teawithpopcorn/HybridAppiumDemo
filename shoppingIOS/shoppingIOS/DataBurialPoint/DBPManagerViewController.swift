//
//  DBPManagerViewController.swift
//  shoppingIOS
//
//  Created by Darsky on 2018/1/2.
//  Copyright © 2018年 Holy. All rights reserved.
//

import UIKit

@objcMembers class DBPManagerViewController: UIViewController,UITableViewDataSource,UITableViewDelegate
{
    var leftButton:UIButton? = nil
    
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var _listTableView: UITableView!
    var _dataArray:NSMutableArray?
    static let DBPManagerCellIdentifier:String = "DBPManagerCell"
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        leftButton = UIButton(type: UIButtonType.system)
        leftButton?.setTitle("编辑", for: UIControlState.normal)
        leftButton?.setTitle("取消", for: UIControlState.selected)
        leftButton?.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        leftButton?.addTarget(self, action: #selector(self.didLeftNaviButtonTouch), for: UIControlEvents.touchUpInside)
        let managerItem:UIBarButtonItem = UIBarButtonItem(customView: leftButton!)
        self.navigationItem.setRightBarButton(managerItem, animated: false)
        _listTableView.register(UINib.init(nibName: DBPManagerViewController.DBPManagerCellIdentifier, bundle: Bundle.main), forCellReuseIdentifier: DBPManagerViewController.DBPManagerCellIdentifier)
        self.loadAndRefreshList()
        // Do any additional setup after loading the view.
    }
    
    // :UITableViewDataSource Method
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return (_dataArray?.count)!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 100
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle(rawValue: UITableViewCellEditingStyle.delete.rawValue | UITableViewCellEditingStyle.insert.rawValue)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var cell:DBPManagerCell? = tableView.dequeueReusableCell(withIdentifier: DBPManagerViewController.DBPManagerCellIdentifier) as? DBPManagerCell
        
        if cell == nil
        {
            cell = DBPManagerCell(style: UITableViewCellStyle.default, reuseIdentifier: DBPManagerViewController.DBPManagerCellIdentifier)
        }
        
        cell?.setupDisplayDBPInfoWithDic(dic: _dataArray![indexPath.row] as! NSDictionary)
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if _listTableView.isEditing
        {
            if _listTableView.indexPathsForSelectedRows?.count == _dataArray?.count
            {
                print("删除全部")
                deleteButton.isSelected = true
            }
            else
            {
                deleteButton.isSelected = false
            }
        }
        else
        {
            _listTableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath)
    {
        if _listTableView.isEditing
        {
            if _listTableView.indexPathsForSelectedRows == nil && _dataArray?.count != 0
            {
                print("删除全部")
                deleteButton.isSelected = true
            }
            else
            {
                deleteButton.isSelected = false
            }
        }
    }
    
    // :UITableViewDataSource Method
    
    func loadAndRefreshList() -> ()
    {
        _dataArray = DataBurialPointManager.shareManager.loadDataBurialPointFromSandBox()
        
        _listTableView.reloadData()
    }
    
    @objc func didLeftNaviButtonTouch() -> ()
    {
        if _listTableView.isEditing
        {
            leftButton?.isSelected = false
            deleteButton.alpha = 0.5
            deleteButton.isUserInteractionEnabled = false
            _listTableView.setEditing(false, animated: true)
        }
        else if _dataArray?.count != 0
        {
            leftButton?.isSelected = true
            deleteButton.isSelected = true
            deleteButton.alpha = 1
            deleteButton.isUserInteractionEnabled = true
            _listTableView.setEditing(true, animated: true)
        }
    }
    @IBAction func didDeleteButtonTouch(_ sender: Any)
    {
        if _listTableView.indexPathsForSelectedRows == nil && _dataArray?.count != 0
        {
            self.cleanAllData()
            self.didLeftNaviButtonTouch()
        }
        else if _listTableView.indexPathsForSelectedRows?.count == _dataArray?.count
        {
            self.cleanAllData()
            self.didLeftNaviButtonTouch()
        }
        else if _listTableView.indexPathsForSelectedRows?.count != 0
        {
            let deleteArray:NSMutableArray = NSMutableArray()
            for i in _listTableView.indexPathsForSelectedRows!
            {
                deleteArray.add(_dataArray?.object(at: i.row) as Any)
            }
            _dataArray?.removeObjects(in: deleteArray as! [Any])
            _listTableView.reloadData()
        }
    }
    
    func cleanAllData() -> ()
    {
        print("清除全部")
        _dataArray?.removeAllObjects()
        DataBurialPointManager.shareManager.cleanAllDatas()
        _listTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
