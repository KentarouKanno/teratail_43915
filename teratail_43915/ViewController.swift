//
//  ViewController.swift
//  teratail_43915
//
//  Created by Kentarou on 2016/08/10.
//  Copyright © 2016年 Kentarou. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !NSUserDefaults.standardUserDefaults().boolForKey("CSVReadFlg") {
            
            // Create Table
            DataBaseManager.sharedInstance.createPersonalDataBase()
            
            // Bundle CSV → DataBase
            if let personalData = CSVManager.readBundleCSVData() {
                for  data in personalData {
                    NSUserDefaults.standardUserDefaults().setBool(true, forKey: "CSVReadFlg")
                    DataBaseManager.sharedInstance.insertPersonalData(data)
                }
            }
        }
        
        // DataBase → TableView Data
        dataArray = DataBaseManager.sharedInstance.selectPersonalAllData()
        
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 20
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    // Data Array
    var dataArray: [PersonalData] = []
    
    // MARK: - TableView Delegate & DataSource
    
    // Row Count
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    // Generate Cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! CustomCell
        cell.personal = dataArray[indexPath.row]
        return cell
    }
    
    // Select Cell
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        print("Cell Tap - ",indexPath.row)
    }
}