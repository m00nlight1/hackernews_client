import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackernews_client/domain/news_entity.dart';
import 'package:hackernews_client/main.dart';
import 'package:hackernews_client/ui/details_news_screen.dart';

class NewsListScreen extends ConsumerWidget {
  const NewsListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final api = ref.watch(newsApiProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hacker News'),
      ),
      body: FutureBuilder<List<int>>(
        future: api.fetchAllNews(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final items = snapshot.data!;
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: FutureBuilder<NewsEntity>(
                    future: api.fetchNews(items[index]),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        final story = snapshot.data!;
                        return InkWell(
                          onTap: () =>
                              _navigateToNewsDetailsScreen(context, story),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(story.title!),
                          ),
                        );
                      }
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  void _navigateToNewsDetailsScreen(BuildContext context, NewsEntity story) {
    if (story.url != null && story.url!.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailsNewsScreen(newsEntity: story),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid URL'),
        ),
      );
    }
  }
}
