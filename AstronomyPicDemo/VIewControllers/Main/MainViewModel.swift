//
//  MainViewModel.swift
//  AstronomyPicDemo
//
//  Created by Arthur on 2021/3/6.
//

import Foundation
class MainViewModel{
    
    var dataArray: [AstronomyItems] = []
    
    var completed: (() -> Void)?
    
    func fetch(){
        APIManager.sharedInstance.taskWithDecoder(HttpRequest(methodType: .get), type: [AstronomyItems].self) { [weak self](error, response) in
            guard let strongSelf = self, let response = response else {return}
            
            if error != nil{
                strongSelf.dataArray = []
            }else{
                strongSelf.dataArray = response
            }
            DispatchQueue.main.async {
                if let callBack = strongSelf.completed{
                    callBack()
                }
            }
        }
    }
}
