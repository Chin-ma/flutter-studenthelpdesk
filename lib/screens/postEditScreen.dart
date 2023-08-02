import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../util/posts.dart';

class PostEditScreen extends StatefulWidget {
  final Post? postToEdit;
  PostEditScreen({this.postToEdit});

  @override
  _PostEditScreenState createState() => _PostEditScreenState();
}

class _PostEditScreenState extends State<PostEditScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.postToEdit != null) {
      _titleController.text = widget.postToEdit!.title;
      _contentController.text = widget.postToEdit!.content;
    }
  }

  Future<String?> _getCurrentUserId() async {
    final User? user = _auth.currentUser;
    return user?.uid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.postToEdit == null ? 'New Post' : 'Edit Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(labelText: 'Content'),
              maxLines: null,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _savePost(context),
              child: Text('Save Post'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _savePost(BuildContext context) async {
    String title = _titleController.text;
    String content = _contentController.text;
    String? userId = await _getCurrentUserId();
    if (title.isEmpty || content.isEmpty || userId == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Please fill all fields'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      try {
        CollectionReference postsRef = FirebaseFirestore.instance.collection('posts');
        if (widget.postToEdit == null) {
          await postsRef.add({
            'title': title,
            'content': content,
            'userId': userId,
          });
        } else {
          await postsRef.doc(widget.postToEdit!.postId).update({
            'title': title,
            'content': content
          });
        }

        Navigator.pop(context);
      } catch (e) {
        print('Error saving post: $e');
      }
    }
  }
}