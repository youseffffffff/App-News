import 'package:app_news/features/search/models/search_body.dart';

class NewsApiResponse {
  final String status;
  final int totalResults;
  final List<Article>? articles;

  NewsApiResponse({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  factory NewsApiResponse.fromMap(Map<String, dynamic> map) {
    return NewsApiResponse(
      status: map['status'],
      totalResults: map['totalResults'],
      articles: map['articles'] != null
          ? List<Article>.from(map['articles'].map((x) => Article.fromMap(x)))
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'totalResults': totalResults,
      'articles': articles != null
          ? List<dynamic>.from(articles!.map((x) => x.toMap()))
          : null,
    };
  }

  static Future<Object?> fetchArticlesByQuery(SearchBody searchBody) async {}
}

class Article {
  final Source? source;
  final String? author;
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final DateTime? publishedAt;
  final String? content;

  const Article({
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  factory Article.fromMap(Map<String, dynamic> map) {
    return Article(
      source: map['source'] != null ? Source.fromMap(map['source']) : null,
      author: map['author'],
      title: map['title'],
      description: map['description'],
      url: map['url'],
      urlToImage: map['urlToImage'],
      publishedAt: map['publishedAt'] != null
          ? DateTime.parse(map['publishedAt'])
          : null,
      content: map['content'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'source': source?.toMap(),
      'author': author,
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt?.toIso8601String(),
      'content': content,
    };
  }
}

class Source {
  final String? id;
  final String? name;

  const Source({this.id, this.name});

  factory Source.fromMap(Map<String, dynamic> map) {
    return Source(id: map['id'], name: map['name']);
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name};
  }
}
