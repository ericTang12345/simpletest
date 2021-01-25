//
//  ProductProvider.swift
//  simpletest
//
//  Created by 唐紹桓 on 2021/1/21.
//

import Foundation

class ProductProvider {
    
    static let group = DispatchGroup()
    
    static let client = HTTPClient()
    
    static func fetchCategory(completion: @escaping ([SalePageList]) -> Void) {
        
        client.request(api: .category) { (result) in
            
            switch result {
            
            case .success(let data):
                
                do {
                    
                    let categoryData = try JSONDecoder().decode(CategoryData.self, from: data)
                    
                    for category in categoryData.data.shopCategoryList.categoryList {
                        
                        // Detail
                        
                        var detail: ProductData?
                        
                        self.group.enter()
                        
                        self.fetchProductDetail(id: category.id) { result in
                            
                            detail = result
                            
                            self.group.leave()
                        }
                        
                        // Sale
                        
                        var sale: ProductData?
                        
                        self.group.enter()
                        
                        self.fetchProductSale(id: category.id) { (result) in
                            
//                            print("sale", result)
                            
                            sale = result
                            
                            self.group.leave()
                        }
                        
                        self.group.notify(queue: .global(qos: .default)) {
                            
                            print("網路作業都完成了")
                            
                            guard let detail = detail, let sale = sale else { return }
                            
                            let salePageList = self.mixData(details: detail.data.shopCategory.salePageList.salePageList,
                                    sales: sale.data.shopCategory.salePageList.salePageList)
                            
                            completion(salePageList)
                        }
                    }
                    
                } catch {
                    
                    print("Category Decode Fail", error)
                }
                
            case .failure(let error):
            
                print("Fetch Category Error", error)
            }
        }
    }
    
    private static func fetchProductDetail(id: Int, completion: @escaping (ProductData) -> Void) {
        
        client.request(api: .product(id)) { (result) in
            
            switch result {
            
            case .success(let data):
                
                do {
                    
                    let data = try JSONDecoder().decode(ProductData.self, from: data)
                    
                    completion(data)
                    
                } catch {
                    
                    print("Decode Product Detail", error)
                }
                
            case .failure(let error):
            
                print("Fetch Product Detail", error)
            }
        }
    }
    
    private static func fetchProductSale(id: Int, completion: @escaping (ProductData) -> Void) {
        
        client.request(api: .sale(id)) { (result) in
            
            switch result {
            
            case .success(let data):
            
                do {
                    
                    let data = try JSONDecoder().decode(ProductData.self, from: data)
                    
                    completion(data)
                    
                } catch {
                    
                    print("Decode Product Sale", error)
                }
                
            case .failure(let error):
            
                print("Fetch Product Sale", error)
            }
        }
    }
    
    private static func mixData(details: [SalePageList] ,sales: [SalePageList]) -> [SalePageList] {
        
        var newSalePageList: [SalePageList] = []
        
        for (index, detail) in details.enumerated() {
            
            let newData = SalePageList(detail: detail, sale: sales[index])
            
            newSalePageList.append(newData)
        }
        
        return newSalePageList
    }
}
