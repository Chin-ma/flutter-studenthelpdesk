import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui/util/posts.dart';
import 'package:flutter_ui/widgets/post_list.dart';

class PostQueryScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String?> _getCurrentUserId() async {
    final User? user = _auth.currentUser;
    return user?.uid;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Query'),
      ),
      body: FutureBuilder<String?>(
        future: _getCurrentUserId(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return _buildPostList(snapshot.data!);
            } else {
              return Center(
                child: Text('Please log in to view posts'),
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget _buildPostList(String userId) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
        .collection('posts')
        .where('userId', isEqualTo: userId)
        .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (context, index) {
              var postDoc = snapshot.data?.docs[index];
              var post = Post(
                title: postDoc?['title'], 
                content: postDoc?['content'], 
                postId: postDoc!.id,   
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
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}