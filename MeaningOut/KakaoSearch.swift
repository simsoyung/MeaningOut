//
//  KakaoSearch.swift
//  MeaningOut
//
//  Created by 심소영 on 6/17/24.
//

import UIKit

struct KakaoSearch: Decodable {
    let lastBuildDate: String
    let total, start, display: Int
    let items: [Item]
}

struct Item: Decodable{
    let title: String
    let link: String
    let image: String
    let lprice, hprice, mallName, productID: String
    let productType, brand, maker: String
}
