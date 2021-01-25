//
//  ProductManager.swift
//  simpletest
//
//  Created by 唐紹桓 on 2021/1/24.
//

import Foundation

class ProductManager {
    
    var sortType: ProductSortType = .heighToLowPrice
    
    var isSoldOut: Bool = false
    
    var isComingSoon: Bool = false
    
    func sortBy(data: [SalePageList]) -> [SalePageList] {
        
        let sortData = sortByType(sortType, data: data)
        
        return filter(data: sortData, comingSoon: isComingSoon, soldOut: isSoldOut)
    }

    // MARK: - Sort Data
    
    private func sortByType(_ type: ProductSortType, data: [SalePageList]) -> [SalePageList] {
        
        switch type {

        case .heighToLowPrice:
            
            return sortByPrice(heighToLow: true, data: data)
            
        case .lowToHeighPrice:
            
            return sortByPrice(heighToLow: false, data: data)
            
        case .newToOldTime:
            
            return sortByTime(newToOld: true, data: data)
            
        case .oldToNewTime:
            
            return sortByTime(newToOld: false, data: data)
        }
    }
    
    private func sortByPrice(heighToLow: Bool, data: [SalePageList]) -> [SalePageList] {
        
        return data.sorted(by: { (first, second) -> Bool in
            
            if heighToLow {
                
                return first.price ?? 0 > second.price ?? 0
                
            } else {
                
                return first.price ?? 0 < second.price ?? 0
            }
        })
    }
    
    private func sortByTime(newToOld: Bool, data: [SalePageList]) -> [SalePageList] {
        
        return data.sorted(by: { (first, second) -> Bool in
            
            if newToOld {
                 
                return first.sellingStartDateTime ?? 0 > second.sellingStartDateTime ?? 0
                
            } else {
                
                return first.sellingStartDateTime ?? 0 < second.sellingStartDateTime ?? 0
            }
        })
    }
    
    // MARK: Filter Data
    
    private func filter(data: [SalePageList], comingSoon: Bool, soldOut: Bool) -> [SalePageList] {
        
        var filterData = data
        
        if comingSoon {
            
            filterData = filterComingSoon(to: comingSoon, data: filterData)
            
        }
        
        if soldOut {
            
            filterData = filterSoldOut(to: soldOut, data: filterData)
        }
        
        return filterData
    }
    
    private func filterComingSoon(to bool: Bool, data: [SalePageList]) -> [SalePageList] {
        
        return data.filter({ (data) -> Bool in
            
            return data.isSoldOut == bool
        })
    }
    
    private func filterSoldOut(to bool: Bool, data: [SalePageList]) -> [SalePageList] {
        
        return data.filter({ (data) -> Bool in
            
            return data.isComingSoon == bool
        })
    }
}
