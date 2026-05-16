class TopHeadlinesBody {
  final String country;
  final String? category;
  final String? sources;
  final String? q;
  final int? pageSize;
  final int? page;

  TopHeadlinesBody({
    this.country = 'us',
    this.category,
    this.sources,
    this.q,
    this.pageSize,
    this.page,
  });

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'country': country,
      'category': category,
      'sources': sources,
      'q': q,
      'pageSize': pageSize,
      'page': page,
    };

    map.removeWhere((key, value) => value == null);

    return map;
  }

  factory TopHeadlinesBody.fromMap(Map<String, dynamic> map) {
    return TopHeadlinesBody(
      country: map['country'] ?? 'sa',
      category: map['category'],
      sources: map['sources'],
      q: map['q'],
      pageSize: map['pageSize'],
      page: map['page'],
    );
  }
}
