//
//  Category.swift
//  simpletest
//
//  Created by 唐紹桓 on 2021/1/21.
//

import Foundation

struct CategoryData: Codable {

    let data: Category
}

struct Category: Codable {

    let shopCategoryList: ShopCategoryList
}

struct ShopCategoryList: Codable {

    let count: Int

    let categoryList: [CategoryList]
}

struct CategoryList: Codable {

    let id: Int

    let name: String
}
