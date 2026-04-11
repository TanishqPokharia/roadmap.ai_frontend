import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:roadmap_ai/core/extensions/theme_extensions.dart';
import 'package:roadmap_ai/features/community/presentation/providers/author_posts/author_posts.notifier.dart';
import 'package:roadmap_ai/features/community/presentation/widgets/post_tile.dart';

class AuthorPostsPage extends ConsumerStatefulWidget {
  final String authorId;
  const AuthorPostsPage({super.key, required this.authorId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AuthorPostsPageState();
}

class _AuthorPostsPageState extends ConsumerState<AuthorPostsPage> {
  late ScrollController _scrollController;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        final notifier = ref.read(
          authorPostsProvider(widget.authorId).notifier,
        );
        if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent) {
          notifier.getNextPage();
        }
      });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final posts = ref.watch(authorPostsProvider(widget.authorId));
    final colorScheme = context.colorScheme;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => context.pop(),
        ),
        title: posts.maybeWhen(
          data: (data) => Text("More by ${data.author?.username}"),
          orElse: () => null,
        ),
      ),
      body: Consumer(
        builder: (context, WidgetRef ref, child) {
          return posts.when(
            skipLoadingOnRefresh: false,
            loading: () => Center(
              child: LoadingAnimationWidget.threeRotatingDots(
                color: colorScheme.primary,
                size: 30,
              ),
            ),
            data: (data) => ListView.separated(
              controller: _scrollController,
              padding: EdgeInsets.all(20),
              itemCount: data.posts.length,
              separatorBuilder: (context, index) => SizedBox(height: 10),
              itemBuilder: (context, index) => PostTile(
                animate: false,
                index: index,
                post: data.posts[index],
              ),
            ),
            error: (error, stackTrace) => Center(child: Text(error.toString())),
          );
        },
      ),
    );
  }
}
