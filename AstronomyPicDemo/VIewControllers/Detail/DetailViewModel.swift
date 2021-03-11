//
//  DetailViewModel.swift
//  AstronomyPicDemo
//
//  Created by Arthur on 2021/3/6.
//

import Foundation
class DetailViewModel{
    
    var dateString: String = ""
    var hdUrl: String = ""
    var title: String = ""
    var des: String = ""
    var copyRight: String = ""
    var dateFormatterString: String = ""
    
    var completed: (() -> Void)?
    
    func trainsfromDate(){
        self.dateFormatterString = self.dateString.formatterDateString(currentFormat: .Date, to: .Month)
        if let callBack = self.completed{
            callBack()
        }
    }
    
}
