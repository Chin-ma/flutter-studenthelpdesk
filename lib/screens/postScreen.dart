import 'package:flutter/material.dart';
import 'package:flutter_ui/widgets/post_list.dart';

class PostQueryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Query'),
      ),
      body: PostList(),
    );
  }
}