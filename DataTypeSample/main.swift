//
//  main.swift
//  DataTypeSample
//
//  Created by 川崎隆介 on 2017/09/05.
//  Copyright © 2017年 codable. All rights reserved.
//

import Foundation

//バイナリデータから特定箇所のデータを抽出
//target data
let str = "abcde\nfghijk"
//string to data
var buffer:Data = str.data(using: .utf8)!
//delimiter
let delimstr = "\n"
//string to data
let delimData:Data = delimstr.data(using:.utf8)!

//target dataのうちdelimiterまでの範囲を取得
if let range = buffer.range(of: delimData) {
    print(range)
    //target dataからdelimiterまでのデータを抽出
    let line = String(data: buffer.subdata(in: 0..<range.lowerBound), encoding: .utf8)
    print(line!)
    //target dataから抽出したデータを削除
    buffer.removeSubrange(0..<range.upperBound)
}

//Array To Data
var arr: [UInt32] = [32, 4, UInt32.max]
let data = Data(buffer: UnsafeBufferPointer(start: &arr, count: arr.count))
print(data) // <20000000 04000000 ffffffff>

//Data To Array
let arr2 = data.withUnsafeBytes {
    Array(UnsafeBufferPointer<UInt32>(start: $0, count: data.count/MemoryLayout<UInt32>.size))
}
print(arr2) // [32, 4, 4294967295]
