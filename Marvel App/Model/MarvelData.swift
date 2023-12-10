//
//  MarvelData.swift
//  Marvel App
//
//  Created by Jad Ghoson on 08/12/2023.
//

import Foundation
struct MarvelData: Codable{
    let code: Int
    let data: data
}
struct data:Codable{
     let count: Int
    let results: [results]
}
struct results: Codable{
    let name : String
    let id : Int
    let description: String
    let thumbnail : thumbnail
    let comics: comics
    let series: series
    let stories: stories
    let events: events

}
struct thumbnail: Codable{
    let path: String
}
struct comics: Codable{
    let items: [items]
}
struct series: Codable{
    let items: [items]
}
struct stories: Codable{
    let items: [items]
}
struct events : Codable{
    let items: [items]
}

struct items : Codable{
    let name: String
}
