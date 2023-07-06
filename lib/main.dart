import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackernews_client/data/dio_app_api.dart';
import 'package:hackernews_client/ui/news_list_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_web/webview_flutter_web.dart';

void main() {
  WebViewPlatform.instance = WebWebViewPlatform();
  runApp(const ProviderScope(child: MyApp()));
}

final dioProvider = Provider<Dio>((_) => Dio());

final newsApiProvider = Provider<DioAppApi>((ref) {
  final dio = ref.read(dioProvider);
  return DioAppApi(dio: dio);
});

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hacker News',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const NewsListScreen(),
    );
  }
}
