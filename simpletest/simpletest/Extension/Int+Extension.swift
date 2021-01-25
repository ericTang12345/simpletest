//
//  Int+Extension.swift
//  simpletest
//
//  Created by 唐紹桓 on 2021/1/24.
//

import Foundation

extension Int {
    
    func transformDataString() -> String {
       
        let timeInterval: TimeInterval = TimeInterval(self)
        
        let date = Date(timeIntervalSince1970: timeInterval/1000)
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy 年 MM 月 dd日 HH: mm: ss"
        
        return dateFormatter.string(from: date)
    }
    
}
