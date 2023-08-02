import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui/screens/landing.dart';
// import 'package:flutter_ui/screens/login.dart';
import 'package:flutter_ui/screens/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool showGetStartedPage = prefs.getBool('showGetStartedPage') ?? true;
  runApp(MyApp(showGetStartedPage: showGetStartedPage));
}

class MyApp extends StatelessWidget {
  final bool showGetStartedPage;
  MyApp({required this.showGetStartedPage});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: showGetStartedPage ? GetStartedPage() : LandingScreen(),
    );
  }
}

class GetStartedPage extends StatelessWidget {
  Future<void> _markGetStartedAsSeen(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('showGetStartedPage', false);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LandingScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue, Colors.indigo],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'lib/images/_211eb5f7-24a8-4ea3-9539-0617ba898d98.jpeg', // Add your image here
                height: 200,
              ),
              const SizedBox(height: 20),
              const Text(
                'Student HelpDesk',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  'The most easiest way to anonymously post your queries and get the administrations reply to it.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () => _markGetStartedAsSeen(context),
                child: Text(
                  'Get Started',
                  style: TextStyle(fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: Colors.indigo,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
