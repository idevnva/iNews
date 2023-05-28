////  ContentView.swift
import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                if let allNews = viewModel.allNews {
                    List(allNews.articles, id: \.title) { article in
                        VStack(alignment: .leading) {
                            if let urlToImage = article.urlToImage, let url = URL(string: urlToImage) {
                                AsyncImage(url: url) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 350, height: 200)
                                    
                                } placeholder: {
                                    ProgressView()
                                }
                            }
                            Text(article.title ?? "")
                                .font(.headline)
                                .lineLimit(2)
                            Text(article.description ?? "")
                                .font(.subheadline)
                                .lineLimit(4)
                        }
                    }
                    .listStyle(.grouped)
                }
            }
            .navigationTitle("Top News")
        }
        .refreshable {
            viewModel.fetchData()
        }
        .task {
            viewModel.fetchData()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
