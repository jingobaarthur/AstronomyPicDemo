//
//  DisplayViewModel.swift
//  AstronomyPicDemo
//
//  Created by Arthur on 2021/3/6.
//

import Foundation
class DisplayViewModel{
    
    var dataArray: [AstronomyItems] = []
    
    var disPlayDataArray: [AstronomyItems] = []
    
    var completed: (() -> Void)?
    
    var prePage: Int = 50
    
    func clipDataArrayToDisplay(){
        if dataArray.isEmpty{
            return
        }else{
            if dataArray.count < prePage{
                for i in 0..<dataArray.count{
                    let astronomyItems = dataArray[i]
                    configDisplayData(astronomyItems: astronomyItems)
                }
            }else{
                for i in 0..<prePage{
                    let astronomyItems = dataArray[i]
                    configDisplayData(astronomyItems: astronomyItems)
                }
            }
            if let callBack = self.completed{
                callBack()
            }
        }
    }
    
    func configDisplayData(astronomyItems: AstronomyItems){
        disPlayDataArray.append(astronomyItems)
        for (index, item) in dataArray.enumerated(){
            if item.url == astronomyItems.url{
                dataArray.remove(at: index)
            }
        }
    }
}
