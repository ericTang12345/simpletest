//
//  Product.swift
//  simpletest
//
//  Created by 唐紹桓 on 2021/1/21.
//

import Foundation

struct ProductData: Codable {
    
    let data: Product
}

struct Product: Codable {

    let shopCategory: ShopCategory
}

struct ShopCategory: Codable {
    
    let salePageList: PageList
}

struct PageList: Codable {

    let salePageList: [SalePageList]
}

struct SalePageList: Codable {

    var title: String?

    var price: Int?

    var suggestPrice: Int?

    var salePageId: Int
    
    var sellingQty: Int?

    var isSoldOut: Bool?

    var isComingSoon: Bool?

    var sellingStartDateTime: Int?
}

extension SalePageList {
    
    init(detail: SalePageList, sale: SalePageList) {
        
        self.title = detail.title
        
        self.price = detail.price
        
        self.suggestPrice = detail.suggestPrice
        
        self.salePageId = sale.salePageId
        
        self.sellingQty = sale.sellingQty
        
        self.isSoldOut = sale.isSoldOut
        
        self.isComingSoon = sale.isComingSoon
        
        self.sellingStartDateTime = sale.sellingStartDateTime
    }
}
