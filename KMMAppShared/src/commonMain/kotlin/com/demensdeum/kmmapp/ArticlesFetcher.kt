package com.demensdeum.kmmapp

import org.openapitools.client.models.ArticlesRoot

class ArticlesFetcher {
    suspend fun fetch(query: String): ArticlesRoot? {
        val api = org.openapitools.client.apis.ArticlesApi()
        val pets = api.articlesList(
            query,
            10,
            "en",
            1,
            "445938e7b4214f4988780151868665cc"
        )
        return pets.body()
    }
}