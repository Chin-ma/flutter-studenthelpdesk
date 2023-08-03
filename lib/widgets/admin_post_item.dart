import 'package:flutter/material.dart';
import 'package:flutter_ui/screens/adminReplyScreen.dart';

import '../util/posts.dart';

class AdminPostItem extends StatelessWidget {
  final Post post;
  AdminPostItem({required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        title: Text(post!.title),
        subtitle: Text(post!.content),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AdminReplyScreen(post: post))
          );
        },
      ),
    );
  }
}