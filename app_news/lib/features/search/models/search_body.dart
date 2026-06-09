class SearchBody {
  final String q;
  final String searchIn;
  final int page;
  final int pageSize;

  SearchBody({
    required this.q,
    this.searchIn = 'title',
    this.page = 3,
    this.pageSize = 15,
  });

  Map<String, dynamic> toJson() {
    return {
      'q': q,
      'searchIn': searchIn,
      'page': page,
      'pageSize': pageSize,
    };
  }

  factory SearchBody.fromJson(Map<String, dynamic> json) {
    return SearchBody(
      q: json['q'],
      searchIn: json['searchIn'] ?? 'title',
      page: json['page'] ?? 3,
      pageSize: json['pageSize'] ?? 15,
    );
  }
}
