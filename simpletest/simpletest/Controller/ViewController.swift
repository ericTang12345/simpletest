//
//  ViewController.swift
//  simpletest
//
//  Created by Michael Chang on 2021/1/15.
//

import UIKit

enum ProductSortType: Int {
    
    case heighToLowPrice = 0
    
    case lowToHeighPrice
    
    case newToOldTime
    
    case oldToNewTime
}

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView! {
        
        didSet {
    
            tableView.registerNib(cell: ProductTableViewCell.self)
            
            tableView.registerRefresher()
            
            tableView.refreshControl?.addTarget(self, action: #selector(fetchData), for: .valueChanged)
        }
    }
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var soldOutSwitch: UISwitch!
    
    @IBOutlet weak var comingSoonSwitch: UISwitch!
    
    var cacheData: [SalePageList] = []
    
    var data: [SalePageList] = [] {
        
        didSet {
            
            DispatchQueue.main.async {

                self.tableView.reloadData()
                
                self.tableView.refreshControl?.endRefreshing()
                
                if self.data.isEmpty {
                    
                    self.present(.alertToNoData(), animated: true, completion: nil)
                }
            }
        }
    }
    
    var productManager = ProductManager()

    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.refreshControl?.beginRefreshing()
        
        fetchData()
    }
    
    @objc func fetchData() {
        
        ProductProvider.fetchCategory { [weak self] (result) in
            
            guard let strongSelf = self else { return }
            
            strongSelf.data = strongSelf.productManager.sortBy(data: result)
            
            strongSelf.cacheData = result
        }
    }
    
    @IBAction func switchSort(_ sender: UISegmentedControl) {
        
        guard let type = ProductSortType.init(rawValue: sender.selectedSegmentIndex) else { return }
        
        productManager.sortType = type
        
        data = productManager.sortBy(data: data)
        
    }
    
    @IBAction func toggleFilterSoldOut(_ sender: UISwitch) {
        
        productManager.isSoldOut = sender.isOn
        
        data = productManager.sortBy(data: cacheData)
    }
    
    @IBAction func toggleFilterComingSoon(_ sender: UISwitch) {
        
        productManager.isComingSoon = sender.isOn
        
        data = productManager.sortBy(data: cacheData)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.identifier, for: indexPath) as! ProductTableViewCell
        
        cell.setupData(data: data[indexPath.row])
        
        return cell
    }
}
