import 'package:app_news/core/utils/app_constants.dart';
import 'package:app_news/features/home/models/top_headlines_api_response.dart';
import 'package:app_news/features/home/models/top_headlines_body.dart';
import 'package:dio/dio.dart';

class HomeServices {
  static final aDio = Dio();

  static Future<TopHeadlinesApiResponse> getTopHeadlines(
    TopHeadlinesBody body,
  ) async {
    try {
      aDio.options.baseUrl = AppConstants.baseUrl;

      final parameter = {'Authorization': 'Bearer ${AppConstants.apiKey}'};

      final response = await aDio.get(
        AppConstants.topHeadlines,
        options: Options(headers: parameter),
        queryParameters: body.toMap(),
      );

      if (response.statusCode == 200) {
        return TopHeadlinesApiResponse.fromMap(response.data);
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
