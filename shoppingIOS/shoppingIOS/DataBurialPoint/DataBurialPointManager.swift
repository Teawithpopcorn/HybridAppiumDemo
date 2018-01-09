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
    
    func insetDatasWithDics(datas:NSArray) -> ()
    {

        let dataBurialPoints:NSMutableArray? = self.loadDataBurialPointFromSandBox()
        if datas.count > 0
        {
            dataBurialPoints?.insert(datas as! [Any], at:IndexSet.init(integer: 0))
        }
        let plistUrl:URL = URL(fileURLWithPath:filePath)
        if dataBurialPoints!.write(to: plistUrl, atomically: true)
        {
            print("保存成功")
        }
    }
    
    func cleanAllDatas() -> ()
    {
        let dataBurialPoints:NSMutableArray? = self.loadDataBurialPointFromSandBox()
        if dataBurialPoints?.count != 0
        {
            dataBurialPoints?.removeAllObjects()
        }
        let plistUrl:URL = URL(fileURLWithPath:filePath)
        if dataBurialPoints!.write(to: plistUrl, atomically: true)
        {
            print("保存成功")
        }
    }
    
    func insetDataWithModel(model:DataBurialPointModel) -> ()
    {
        let insertDic:NSDictionary = ["name":model.name,"page":model.page,"startTime":model.startTime,"endTime":model.endTime,"duration":model.duration]
        DispatchQueue.global().async{
            self.insetDatasWithDics(datas: [insertDic])
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
