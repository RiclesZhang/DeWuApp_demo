//
//  PersonalCenter.swift
//  DeWu
//
//  Created by 楚门 on 2024/4/14.
//

//
//  PersonalCenter.swift
//  DeWu
//
//  Created by Ocean Zhang on 2024/4/13.
//

import SwiftUI

struct PersonalCenter : View {

    var body: some View{

        VStack(alignment: .leading){
            
            HStack{
                Button(action: {}) {
                    Image("头像") //尺寸调整
                        .resizable()
                        .renderingMode(.original)
                        .frame(width: 50,height: 50)
                        .padding()
                    Text("用户114514号")
                        .foregroundColor(.black.opacity(0.5))//尺寸调整
                }
                
            }
            
            Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
            
            HStack{
                Button(action: {}) {
                    NavigationLink(destination: WantingItems()) {
                        HStack {
                            Image(systemName: "heart")
                            
                            Text("想要")
                        }
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(8)
                    }
                }
                
                Button(action: {}) {
                    NavigationLink(destination: HavingItems()) {
                    
                        HStack {
                            Image(systemName: "checkmark.circle")
                            
                            Text("我有")
                        }
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(8)
                    }
                }
            }
            
            Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
        }
                
    }
}

struct WantingItems : View {
    
    var filteredProduts: [Product] = products.filter{$0.isFavorite == true}
    
    var body: some View{
    
        VStack{
            
            HStack(spacing: 20){
                
                Button(action: {}) {
                    
                    Image(systemName: "chevron.left")
                        .font(.system(size: 26,weight: .heavy))
                        .foregroundColor(.black)
                }
                
                Text("我想要的")
                    .font(.title)
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
                
                Spacer()
            }
            .padding()
            
            ScrollView(.vertical, showsIndicators: false) {
            
                if filteredProduts.isEmpty {
                    
                    Text("您还没有收藏商品") //尺寸调整
                    
                }
            
                else {
                    LazyVStack(spacing: 0) {
                        
                        ForEach(filteredProduts) {product in
                        
                            //"想要"中的商品信息
                            WantingProductView(product: product)
                        }
                    }
                }
    
            }
        
        }
        .background(Color.white)
    }
}


struct WantingProductView: View {
    
    var product: Product
    var body: some View {
        
        ZStack{
            
            LinearGradient(gradient: .init(colors: [Color.orange,Color.red]),startPoint: .leading, endPoint: .trailing)
            
            //实现"删除"功能的按钮
            
            HStack{
            
                Spacer()
                
                Button(action: {products[getIndex(product: product)].isFavorite.toggle()}) {
                    
                    Image(systemName: "trash")
                        .font(.title)
                        .foregroundColor(.white)
                        .frame(width: 90,height: 50)
                }
            }
                
            HStack(spacing: 15) {
                
                Image(product.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 130,height: 130)
                    .cornerRadius(15)
                    
                VStack(alignment: .leading, spacing: 10) {
                    
                    Text(product.name)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                    
                    HStack(spacing: 15) {
                        
                        Text("\(product.price)")
                        .font(.title2)
                        .fontWeight(.heavy)
                        .foregroundColor(.black)
                        
                        Spacer(minLength: 0)
                    }
                }
            }
            .padding()
            .background(Color.white)
            .contentShape(Rectangle())
            .offset(x: product.offset)
            .gesture(DragGesture().onChanged(onChanged(value:)).onEnded(onEnd(value:)))
        }
    }
    
    func onChanged(value: DragGesture.Value) {
        if value.translation.width < 0{
            
            if product.isFavorite{
                products[getIndex(product: product)].offset = value.translation.width - 90
            }
            else {
                products[getIndex(product: product)].offset = value.translation.width
            }
        }
    }
    
    func onEnd(value: DragGesture.Value) {
        
        withAnimation(.easeOut) {
            
            if value.translation.width < 0{
                
               /*if -value.translation.width > UIScreen.main.bounds.width / 2 {
                    
                    product.offset = -1000
                }*/
                if -product.offset > 50 {
                    //product.isFavorite = true
                    products[getIndex(product: product)].offset = -90
                }
                else {
                    //product.isFavorite = false
                    products[getIndex(product: product)].offset = 0
                }
            }
            else{
                    //product.isFavorite = false
                products[getIndex(product: product)].offset = 0
            }
        }
    }
}

struct HavingItems : View {
    
    var filteredProduts: [Product] = products.filter{$0.isBought == true}
    var body: some View{
    
        VStack{
            
            HStack(spacing: 20){
                
                Button(action: {}) {
                    
                    Image(systemName: "chevron.left")
                        .font(.system(size: 26,weight: .heavy))
                        .foregroundColor(.black)
                }
                
                Text("我拥有的")
                    .font(.title)
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
                
                Spacer()
            }
            .padding()
            
            ScrollView(/*.vertiacl, showsIndicators: false*/) {
                
                if filteredProduts.isEmpty {
                    
                    Text("暂无拥有") //尺寸调整
                    
                }
                
                else {
                    
                    LazyVStack(spacing: 0) {
                        
                        ForEach(filteredProduts) {product in
                        
                            //"我有"中的商品信息
                            HavingProductView(product: product)
                        }
                    }
                }
            }
        
        }
        .background(Color.white)
    }
    
}


struct HavingProductView: View {
    
    var product: Product
    var body: some View {
        
        HStack(spacing: 15) {
            
            Image(product.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 130,height: 130)
                .cornerRadius(15)
                
            VStack(alignment: .leading, spacing: 10) {
                
                Text(product.name)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                
                HStack(spacing: 15) {
                    
                    Text("\(product.price)")
                        .font(.title2)
                        .fontWeight(.heavy)
                        .foregroundColor(.black)
                    
                    Spacer(minLength: 0)

                }
            }
        }
        .padding()
    }
}
