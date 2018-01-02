//
//  DataBurialPointManager.swift
//  DataBurialPoint_Swift
//
//  Created by Darsky on 2017/12/23.
//  Copyright © 2017年 Darsky. All rights reserved.
//

import UIKit

class DataBurialPointManager: NSObject
{
    static let shareManager = DataBurialPointManager.init()
    let filePath:String = NSHomeDirectory() + "/Documents/DataBurialPoint.plist"
    
    func insetDataWithModel(model:DataBurialPointModel) -> ()
    {
        let dataBurialPoints:NSMutableArray? = self.loadDataBurialPointFromSandBox()
        let insertDic:NSDictionary = ["name":model.name,"page":model.page,"startTime":model.startTime,"endTime":model.endTime,"duration":model.duration]
        dataBurialPoints?.add(insertDic)
        let plistUrl:URL = URL(fileURLWithPath:filePath)
        if dataBurialPoints!.write(to: plistUrl, atomically: true)
        {
            print("保存成功")
        }
    }
    
    func loadDataBurialPointFromSandBox() -> NSMutableArray?
    {
        if FileManager.default.fileExists(atPath: filePath) == false
        {
            FileManager.default.createFile(atPath: filePath, contents: nil, attributes: nil)
        }
        let plistUrl:URL = URL(fileURLWithPath:filePath)
        let originArray:NSArray? = NSArray(contentsOf:plistUrl)
        let dataBurialPoints:NSMutableArray? = NSMutableArray()
        if originArray != nil
        {
            dataBurialPoints?.addObjects(from: originArray as! [Any])
        }
        
        return dataBurialPoints
    }
}
