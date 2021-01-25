//
//  UIViewController+Extension.swift
//  simpletest
//
//  Created by 唐紹桓 on 2021/1/24.
//

import UIKit

extension UIViewController {
    
    static func alertToNoData() -> UIAlertController {
        
        let alert = UIAlertController(title: "目前沒有任何符合的資料", message: nil, preferredStyle: .actionSheet)
        
        alert.view.tintColor = .lightGray
        
        let cancel = UIAlertAction(title: "確認", style: .cancel, handler: nil)
        
        alert.addAction(cancel)
        
        return alert
    }
}
