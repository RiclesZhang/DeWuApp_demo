//
//  Product.swift
//  DeWu
//
//  Created by 楚门 on 2024/4/14.
//

import SwiftUI

struct Product: Identifiable {
        var id = UUID().uuidString
        var name: String
        var price: Int
        var imageName: String
        var offset: CGFloat
        var isFavorite: Bool
    var isBought: Bool
}
