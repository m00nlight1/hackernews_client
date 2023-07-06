import 'package:dio/dio.dart';
import 'package:hackernews_client/domain/news_entity.dart';

class DioAppApi {
  final Dio dio;

  DioAppApi({required this.dio});

  Future<List<int>> fetchAllNews() async {
    try {
      final response = await dio
          .get('https://hacker-news.firebaseio.com/v0/topstories.json');
      if (response.statusCode == 200) {
        return response.data.cast<int>() as List<int>;
      } else {
        throw DioException(
          error: 'Failed to fetch Hacker News',
          response: response,
          requestOptions: RequestOptions(
              path: 'https://hacker-news.firebaseio.com/v0/topstories.json'),
        );
      }
    } catch (error) {
      throw DioException(
        error: 'Failed to fetch Hacker News: $error',
        requestOptions: RequestOptions(
            path: 'https://hacker-news.firebaseio.com/v0/topstories.json'),
      );
    }
  }

  Future<NewsEntity> fetchNews(int newsId) async {
    try {
      final response = await dio
          .get('https://hacker-news.firebaseio.com/v0/item/$newsId.json');
      if (response.statusCode == 200) {
        return NewsEntity.fromJson(response.data);
      } else {
        throw DioException(
          error: 'Failed to fetch Hacker News',
          response: response,
          requestOptions: RequestOptions(
              path: 'https://hacker-news.firebaseio.com/v0/item/$newsId.json'),
        );
      }
    } catch (error) {
      throw DioException(
        error: 'Failed to fetch Hacker News: $error',
        requestOptions: RequestOptions(
            path: 'https://hacker-news.firebaseio.com/v0/item/$newsId.json'),
      );
    }
  }
}
