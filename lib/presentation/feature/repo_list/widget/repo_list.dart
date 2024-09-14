import 'package:flutter/material.dart';
import '../bloc/repo_item_state.dart';
import 'repo_tile.dart';

class RepoList extends StatelessWidget {
  final List<RepoItemState> repos;
  final ScrollController scrollController;

  const RepoList({
    super.key,
    required this.repos,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      itemCount: repos.length,
      itemBuilder: (context, index) {
        final repo = repos[index];
        return RepoTile(
          repo: repo,
          onTap: () {},
        );
      },
    );
  }
}
