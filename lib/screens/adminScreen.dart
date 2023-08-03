import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui/util/posts.dart';
import 'package:flutter_ui/widgets/admin_post_item.dart';

class AdminScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Screen'),
      ),
      body: _buildAdminPostList(),
    );
  }
}

Widget _buildAdminPostList() {
  return StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance.collection('posts').snapshots(),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        return ListView.builder(
          itemCount: snapshot.data?.docs.length,
          itemBuilder: (context, index) {
            var postDoc = snapshot.data?.docs[index];
            var post = Post(
              title: postDoc!['title'], 
              content: postDoc['content'], 
              postId: postDoc.id, 
              userId: postDoc['userId'],
            );
            return AdminPostItem(post: post);
          },
        );
      } else if (snapshot.hasError) {
        return Center(
          child: Text('Error: ${snapshot.error}'),
        );
      } else {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    },
  );
}