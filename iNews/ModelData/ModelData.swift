//  ModelData.swift
import Foundation

struct AllNews: Decodable {
    let totalResults: Int
    let articles: [Article]
}

struct Article: Decodable {
    let author: String?
    let title: String?
    let description: String?
    let urlToImage: String?
}
