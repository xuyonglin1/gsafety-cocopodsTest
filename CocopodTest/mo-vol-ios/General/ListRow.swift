//
//  ListRow.swift
//  mo-vol-ios
//
//  Created by Gsafety on 2020/7/30.
//  Copyright © 2020 Gsafety. All rights reserved.
//

import SwiftUI

struct ListRow: View {
    var symbol: String
    var body: some View {
        NavigationLink(destination: ListDetail(symbol: symbol)) {

            HStack {
                //图片
                Image(systemName: symbol)
                    .resizable()
                    .frame(width: 60, height: 60)
                    .foregroundColor(Colors.randomElement())
                //分割
                Divider()
                Spacer()
                //文字
                Text(symbol)
                Spacer()
            }
        }
    }
}

struct ListRow_Previews: PreviewProvider {
    static var previews: some View {
        ListRow(symbol: "chevron.up")
    }
}
