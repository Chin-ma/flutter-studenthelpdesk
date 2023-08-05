// admin_landing_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_ui/screens/adminScreen.dart';
import 'package:flutter_ui/screens/postEditScreen.dart';
import 'package:flutter_ui/screens/postScreen.dart';

class AdminLandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Landing Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Image.asset(
            //   'assets/logo.png', // Replace with your app logo image
            //   width: 150,
            //   height: 150,
            // ),
            // SizedBox(height: 40),
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => PostQueryScreen()),
            //     );
            //   },
            //   style: ElevatedButton.styleFrom(
            //     primary: Colors.blue,
            //     onPrimary: Colors.white,
            //     padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(30.0),
            //     ),
            //   ),
            //   child: Text('Display Posts', style: TextStyle(fontSize: 18)),
            // ),
            // SizedBox(height: 20),
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => PostEditScreen()),
            //     );
            //   },
            //   style: ElevatedButton.styleFrom(
            //     primary: Colors.green,
            //     onPrimary: Colors.white,
            //     padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(30.0),
            //     ),
            //   ),
            //   child: Text('Add Post', style: TextStyle(fontSize: 18)),
            // ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdminScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.purple,
                onPrimary: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: Text('Admin Screen', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
