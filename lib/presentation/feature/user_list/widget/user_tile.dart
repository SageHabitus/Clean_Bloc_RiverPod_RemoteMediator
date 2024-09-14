import 'package:flutter/material.dart';

import '../bloc/user_item_state.dart';

class UserTile extends StatelessWidget {
  final UserItemState user;
  final VoidCallback onTap;

  const UserTile({super.key, required this.user, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(user.profileUrl),
      ),
      title: Text(user.name),
      onTap: onTap,
    );
  }
}
