import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../util/posts.dart';

class AdminReplyScreen extends StatefulWidget {
  final Post post;
  AdminReplyScreen({required this.post});

  @override
  _AdminReplyScreenState createState() => _AdminReplyScreenState();
}

class _AdminReplyScreenState extends State<AdminReplyScreen> {
  final TextEditingController _replyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.post.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.post.content,
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _replyController,
              decoration: InputDecoration(labelText: 'Reply'),
              maxLines: null,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _sendReply(context),
              child: Text('Send Reply'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _sendReply(BuildContext context) async {
    String reply = _replyController.text;

    if (reply.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Please enter a reply'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        }
      );
    } else {
      try {
        await FirebaseFirestore.instance.collection('posts').doc(widget.post.postId).update({
          'reply': reply,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Reply sent successfully'),
            duration: Duration(seconds: 2),
          )
        );
        Navigator.pop(context);
      } catch (e) {
        print('Error: $e');
      }
    }
  }
}