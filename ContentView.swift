//
//  ContentView.swift
//  DeWu
//
//  Created by Ocean Zhang on 2024/4/13.
//

import SwiftUI

struct  ContentView: View {
    var body: some View {
    
        NavigationView{
    
            CustomTabView()
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CustomTabView : View {

    @State var selectedTab = "bag"
    //@State var edge = UIApplication.shared.windows.first?.safeAreaInsets
    var body: some View {
    
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
        
            TabView(selection: $selectedTab) {
            
                Home()
                    .tag("bag")
                PersonalCenter()
                    .tag("person")
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .ignoresSafeArea(.all, edges: .bottom)
        
            HStack(spacing: 0) {
        
                ForEach(tabs,id: \.self){image in
            
                    TabButton(image: image, selectedTab : $selectedTab)
            
                    if image != tabs.last{
                        Spacer(minLength: 0)
                    }
                }
            }
            .padding(.horizontal,25)
            .padding(.vertical,5)
            .background(Color.gray.opacity(0.3))
            .clipShape(Capsule())
            .padding(.horizontal)
            //.padding(.bottom,edge!.bottom == 0 ? 20 : 0)
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .background(Color.black.opacity(0.05)/*.ignoresSafeArea(.all, edges: .all)*/)
    }
}

// 图片名称，标签
var tabs = ["bag","person"]

struct TabButton : View {

    var image : String
    @Binding var selectedTab : String
    var body: some View{

        Button(action: {selectedTab = image}) {
            Image(systemName: image)
                .renderingMode(.original)
                .foregroundColor(selectedTab == image ? Color.teal: Color.black.opacity(0.4))
                .padding()
        }
    }
}

struct Home: View {
    @State var txt = ""
    var filteredProduts: [Product] {
        if txt.isEmpty {
            return products
        }
        else {
            return products.filter{$0.name.localizedCaseInsensitiveContains(txt)}
        }
    }
    //@State var edge = UIApplication.shared.windows.first?.safeAreaInsets
    var body: some View {
        VStack(alignment: .leading, spacing: 10/*尺寸调整*/) {
            Button(action: {}) {
                Image("得物图标") //尺寸调整
                .resizable()
                .renderingMode(.original)
                .frame(width: 50,height: 50)
                .padding()
            }
            
            VStack{

                HStack(spacing: 15) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    TextField("想要什么就告诉我吧宝贝",text: $txt)
                    
                    /*List(products.filter {
                        txt.isEmpty ? true : $0.name.localizedCaseInsensitiveContains(txt)
                    }) { product in
                        NavigationLink(destination: ProductDetail(product: product)) {
                            ProductRow(product: product)
                        }
                    }*/
                }
                .padding(.vertical,12)
                .padding(.horizontal)
                .background(Color.white)
                .clipShape(Capsule())


            ScrollView(.vertical, showsIndicators: false) {


                    HStack{

                        Text("推荐")
                        .font(.title2)
                        .fontWeight(.bold) //之后加入滑动，“分类”功能

                        Spacer(minLength: 0)
                        Button(action: {}) {
                            Text("分类")
                        }
                    }
                    .foregroundColor(.black)
                    .padding(.top,25)

                    
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20),count: 2),spacing :20) {
                        
                        ForEach(filteredProduts) { product in
                                
                            NavigationLink(destination: ProductDetail(product: product)) {
                                        
                                ProductRow(product: product)
                            }
                        }
                    }
                    .padding(.top)
                }
                .padding()
            }
        }
    }
}

struct ProductRow : View {

    var product : Product
 
    var body: some View{

        VStack{
            VStack{
    
                Image(product.imageName) //商品图片
                .resizable()
                .renderingMode(.original)
                .aspectRatio(contentMode: .fit)
                .padding(.top,10)
                .padding(.leading,10)
                .background(Color.white)
    
                HStack{
    
                    VStack(alignment: .leading, spacing : 12) {
    
                        Text(product.name)//尺寸调整
    
                        Text("￥ \(product.price)")
                        .fontWeight(.bold)
                    }
                    .foregroundColor(.black)
    
                    Spacer(minLength: 0)
                }
                .padding()
            }
            .background(Color.white)
            .cornerRadius(15)
    
            Spacer(minLength: 0)
        }
    }
}

var products: [Product] = [
    
    Product(name: "iPhone 15 Pro", price: 6789, imageName: "SP1",offset: 0,isFavorite: false,isBought: false),
    Product(name: "猫与沙发 板鞋", price: 289, imageName: "XP1",offset: 0,isFavorite: false,isBought: false),
    Product(name: "NORTH EDGE智能手表", price: 187, imageName: "BP1",offset: 0,isFavorite: false,isBought: false),
    Product(name: "安慕希酸奶 原味", price: 35, imageName: "YP1",offset: 0,isFavorite: false,isBought: false),
    Product(name: "TALKING TOM帆布鞋", price: 99, imageName: "XP2",offset: 0,isFavorite: false,isBought: false),
    Product(name: "德芙 恋语巧克力礼盒", price: 30, imageName: "YP2",offset: 0,isFavorite: false,isBought: false),
    Product(name: "komery 微单照相机", price: 449, imageName: "SP2",offset: 0,isFavorite: false,isBought: false),
    Product(name: "EMPORIO ARMANI阿玛尼腕表", price: 1329, imageName: "BP2",offset: 0,isFavorite: false,isBought: false),
    Product(name: "贵州茅台酒 53度 200ml", price: 1149, imageName: "YP3",offset: 0,isFavorite: false,isBought: false),
    Product(name: "王者荣耀 荣耀水晶", price: 479, imageName: "SP3",offset: 0,isFavorite: false,isBought: false),
    Product(name: "卡琦拉智能手表", price: 390, imageName: "BP3",offset: 0,isFavorite: false,isBought: false),
    Product(name: "SAINT LAURENT圣罗兰 一字带凉鞋", price: 4286, imageName: "XP3",offset: 0,isFavorite: false,isBought: false),
    Product(name: "三养原味火鸡面", price: 84, imageName: "YP4",offset: 0,isFavorite: false,isBought: false),
    Product(name: "LAZY BONS 时尚板鞋", price: 99, imageName: "XP4",offset: 0,isFavorite: false,isBought: false),
    Product(name: "GUCCI古驰G-Timeles系列", price: 3699, imageName: "BP4",offset: 0,isFavorite: false,isBought: false),
    Product(name: "MacBook Air 2022款", price: 6619, imageName: "SP4",offset: 0,isFavorite: false,isBought: false),
    Product(name: "CASIO卡西欧DRESS系列", price: 259, imageName: "BP5",offset: 0,isFavorite: false,isBought: false),
    Product(name: "TCELLARS 老爹鞋", price: 237, imageName: "XP5",offset: 0,isFavorite: false,isBought: false),
    Product(name: "AirPods 第三代", price: 1179, imageName: "SP5",offset: 0,isFavorite: false,isBought: false),
    Product(name: "汤达人泡面5口味各一袋", price: 22, imageName: "YP5",offset: 0,isFavorite: false,isBought: false),
]

    func getIndex(product: Product) -> Int{
        
        var index = 0
        for i in products {
            if i.name == product.name{
                return index
                index += 1
            }
        }
        return 0
    }
