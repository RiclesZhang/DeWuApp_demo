//
//  ProductDetail.swift
//  DeWu
//
//  Created by 楚门 on 2024/4/14.
//

//
//  ProductDetail.swift
//  DeWu
//
//  Created by Ocean Zhang on 2024/4/13.
//

import SwiftUI

struct ProductDetail: View {
    
    var product : Product
    var body: some View {
        VStack {
            Image(product.imageName) //商品图片
            .resizable()
            .renderingMode(.original)
            .aspectRatio(contentMode: .fit)
            .padding(.top,10)
            .padding(.leading,10)
            .background(Color.white)
    
            Text("￥ \(product.price)")
            .fontWeight(.bold)
            
            Text(product.name)//尺寸调整
            
            Spacer()
            
            HStack(spacing: 20) {
                
                Button(action: {/*
                    if isFavorite {
                        WantingItemsData.deleteProduct(product: product)
                    }
                    else {
                        WantingItemsData.addProduct(product: product)
                    }
                    */
                    products[getIndex(product: product)].isFavorite.toggle()
                }) {
                    Image(systemName: products[getIndex(product: product)].isFavorite ? "heart.fill" : "heart")
                        .foregroundColor(product.isFavorite ? .teal : .gray)
                        .font(.title)
                }
                
                Button(action: {products[getIndex(product: product)].isBought = true}) {
                    NavigationLink(destination: PurchaseSuccessful()) {
                        
                        Text("立即购买")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.teal)
                            .cornerRadius(10)
                    }
                }
            }
            .padding(.bottom, 20)
        }
        .background(Color.white)
        .navigationTitle("商品详情")
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

//"购买成功"界面
struct PurchaseSuccessful: View{
    
    var body: some View{
        
        VStack(alignment: .center){
            
            /*Button(action: {}) {
                    
                Image(systemName: "chevron.left")
                    .font(.system(size: 26,weight: .heavy))
                    .foregroundColor(.black)
            }*/
            
            Image(systemName: "checkmark.circle")
                .resizable()
                .foregroundColor(.green)
                .frame(width: 80,height: 80)
            
            Text("购买成功！")
                .font(.title)
                .fontWeight(.bold)
        }
    }
}
