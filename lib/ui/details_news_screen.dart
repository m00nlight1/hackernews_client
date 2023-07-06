import 'package:flutter/material.dart';
import 'package:hackernews_client/domain/news_entity.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DetailsNewsScreen extends StatefulWidget {
  const DetailsNewsScreen({super.key, required this.newsEntity});

  final NewsEntity newsEntity;

  @override
  State<StatefulWidget> createState() => _DetailsNewsScreenState();
}

class _DetailsNewsScreenState extends State<DetailsNewsScreen> {
  late final WebViewController webViewController;

  @override
  void initState() {
    super.initState();
    webViewController = WebViewController()
      ..loadRequest(Uri.parse(widget.newsEntity.url!));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.newsEntity.title!),
        ),
        body: WebViewWidget(
          controller: webViewController,
        ));
  }
}
