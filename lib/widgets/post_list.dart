import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui/util/postDetails.dart';
import 'package:flutter_ui/util/posts.dart';

class PostList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('posts').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (context, index) {
              var postDoc = snapshot.data?.docs[index];
              var post = Post(
                postId: postDoc!.id,
                title: postDoc['title'],
                content: postDoc['content'], 
                userId: postDoc['userId'],
              );
              return PostItem(post: post);
            },
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class PostItem extends StatelessWidget {
  final Post post;
  PostItem({required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        title: Text(post.title),
        subtitle: Text(post.content),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PostDetails(post: post))
          );
        },
      ),
    );
  }
}