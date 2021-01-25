//
//  UITableView+Extension.swift
//  simpletest
//
//  Created by 唐紹桓 on 2021/1/21.
//

import UIKit

extension UITableView {
    
    func registerNib(cell: UITableViewCell.Type) {
        
        let nib = UINib(nibName: String(describing: cell), bundle: nil)
        
        register(nib, forCellReuseIdentifier: cell.identifier)
    }
    
    func registerRefresher() {
        
        let refreshControl = UIRefreshControl()
        
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        
        refreshControl.attributedTitle = NSAttributedString(string: "重新讀取資料", attributes: attributes)
        
        refreshControl.tintColor = .black
        
        refreshControl.backgroundColor = .white
        
        self.refreshControl = refreshControl
    }
}

