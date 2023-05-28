//  ViewModel.swift
import Foundation
class ViewModel: ObservableObject {
    @Published var allNews: AllNews?
    
    func fetchData() {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "newsapi.org"
        urlComponents.path = "/v2/everything"
        urlComponents.queryItems =
        [
            URLQueryItem(name: "q", value: "apple"),
            URLQueryItem(name: "apiKey", value: "apiKey"), // Here you need an API key from newsapi.org
            URLQueryItem(name: "pageSize", value: "10")
        ]
        
        guard let url = urlComponents.url else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let allNews = try JSONDecoder().decode(AllNews.self, from: data)
                DispatchQueue.main.async {
                    self?.allNews = allNews
                    print(allNews)
                }
            } catch {
                print(error as Any)
            }
        }
        task.resume()
    }
}

















