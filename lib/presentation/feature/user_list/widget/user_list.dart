import 'package:flutter/material.dart';
import '../../../resource/app_route.dart';
import '../bloc/ad_item_state.dart';
import '../bloc/user_item_state.dart';
import 'ad_banner.dart';
import 'user_tile.dart';

class UserList extends StatelessWidget {
  final List<UserItemState> users;
  final AdItemState ad;
  final ScrollController scrollController;

  const UserList({
    super.key,
    required this.users,
    required this.ad,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      itemCount: _calculateItemCount(),
      itemBuilder: (context, index) {
        if (_isAdPosition(index)) {
          return AdBanner(ads: ad);
        } else {
          final userIndex = _getUserIndex(index);
          final user = users[userIndex];
          return UserTile(
            user: user,
            onTap: () {
              Navigator.pushNamed(
                context,
                AppRoute.repolist,
                arguments: user.name,
              );
            },
          );
        }
      },
    );
  }

  int _calculateItemCount() {
    final adCount = users.length ~/ 10;
    return users.length + adCount;
  }

  bool _isAdPosition(int index) {
    return (index + 1) % 11 == 0;
  }

  int _getUserIndex(int index) {
    return index - (index ~/ 11);
  }
}
