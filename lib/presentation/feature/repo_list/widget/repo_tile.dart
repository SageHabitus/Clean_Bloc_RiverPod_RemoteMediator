import 'package:flutter/material.dart';

import '../bloc/repo_item_state.dart';

class RepoTile extends StatelessWidget {
  final RepoItemState repo;
  final VoidCallback onTap;

  const RepoTile({super.key, required this.repo, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: _getLanguageColor(repo.language),
        child: Text(repo.language.substring(0, 1).toUpperCase()),
      ),
      title: Text(repo.name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(repo.description),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.star, size: 16, color: Colors.yellow),
              const SizedBox(width: 4),
              Text('${repo.starCount}'),
              const SizedBox(width: 16),
              CircleAvatar(
                radius: 5,
                backgroundColor: _getLanguageColor(repo.language),
              ),
              const SizedBox(width: 4),
              Text(repo.language ?? 'Unknown'),
            ],
          ),
        ],
      ),
      onTap: onTap,
    );
  }

  Color _getLanguageColor(String? language) {
    switch (language?.toLowerCase()) {
      case 'java':
        return const Color(0xffb07219);
      case 'kotlin':
        return const Color(0xffA97BFF);
      case 'python':
        return const Color(0xff3572A5);
      case 'javascript':
        return const Color(0xfff1e05a);
      case 'ruby':
        return const Color(0xff701516);
      case 'swift':
        return const Color(0xffffac45);
      case 'c++':
        return const Color(0xfff34b7d);
      case 'c#':
        return const Color(0xff178600);
      case 'typescript':
        return const Color(0xff2b7489);
      case 'go':
        return const Color(0xff00ADD8);
      default:
        return Colors.grey;
    }
  }
}
