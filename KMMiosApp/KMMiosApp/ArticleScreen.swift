//
//  ArticleScreen.swift
//  KMMiosApp
//
//  Created by ILIYA on 24.01.2022.
//  Copyright © 2022 orgName. All rights reserved.
//

import Foundation
import KMMAppShared
import SwiftUI

struct ArticleScreen: View {
    @ObservedObject private var viewModel: ArticleScreenViewModel
    
    init(
        _ article: Article
    ) {
        viewModel = ArticleScreenViewModel(article)
    }
    
    var body: some View {
        ScrollView {
            Text(viewModel.article.content ?? "-")
                .padding()
                .navigationViewStyle(StackNavigationViewStyle())
        }
        .navigationTitle(viewModel.article.title ?? "-")
    }
}

class ArticleScreenViewModel: ObservableObject {
    let article: Article
    
    init(
        _ article: Article
    )
    {
        self.article = article
    }
}
