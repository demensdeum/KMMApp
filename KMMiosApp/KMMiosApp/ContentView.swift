import SwiftUI
import KMMAppShared
import Combine

struct ContentView: View {
    @ObservedObject private var viewModel: ContentViewModel = .init()
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Search", text: $viewModel.searchText).padding()
                List(viewModel.articles, id: \.self) { item in
                    NavigationLink(destination: ArticleScreen(item)) {
                        Text(item.title ?? "-")
                    }
                }
            }
            .navigationTitle("News")
        }
    }
}

class ContentViewModel: ObservableObject {
    private let articlesFetcher = ArticlesFetcher()
    
    @Published var searchText: String = ""
    @Published var articles: [Article] = []
    
    private var subscriptions = Set<AnyCancellable>()
    private var query: String = "" {
        didSet {
            performSearch()
        }
    }
    
    init() {
        $searchText.debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .sink(receiveValue: { [weak self] newValue in
                self?.query = newValue
            } )
            .store(in: &subscriptions)
    }
    
    private func performSearch() {
        guard query.count > 0 else { return }
        articlesFetcher.fetch(query: query) { [weak self] root, error in
            self?.articles = root?.articles ?? []
        }
    }
}
