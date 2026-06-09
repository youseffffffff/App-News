import 'package:app_news/core/models/news_api_response.dart';
import 'package:app_news/core/utils/app_constants.dart';
import 'package:app_news/features/search/models/search_body.dart';
import 'package:dio/dio.dart';

class SearchService {
  static final aDio = Dio();

  static Future<NewsApiResponse> search(SearchBody searchBody) async {
    try {
      aDio.options.baseUrl = AppConstants.baseUrl;

      final parameter = {'Authorization': 'Bearer ${AppConstants.apiKey}'};

      final response = await aDio.get(
        AppConstants.everything,
        options: Options(headers: parameter),
        queryParameters: searchBody.toJson(),
      );

      if (response.statusCode == 200) {
        return NewsApiResponse.fromMap(response.data);
      } else {
        throw Exception(
          response.statusMessage ?? 'Failed to load top headlines',
        );
      }
    } catch (e) {
      throw Exception('Failed to load top headlines: $e');
    }
  }
}
