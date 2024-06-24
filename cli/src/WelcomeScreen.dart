import 'package:flutter/material.dart';
import 'Signup.dart';  // Import
import 'Login.dart';// the Signup page

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Potshots",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'assets/front-banner.png', // Ensure this image is in your assets folder
                      height: 250, // Increased the image size
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Welcome to Potshots",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20, // Increased font size
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Save small, Achieve more",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18, // Increased font size
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Signup()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFFFD700), // Gold color for the button
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 15), // Added padding for vertical spacing
                          ),
                          child: Text(
                            "Register",
                            style: TextStyle(
                              color: Colors.brown, // Brown color for the text
                              fontSize: 18, // Increased font size
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.push(context,
                            MaterialPageRoute(builder: (context)=>Login())
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Color(0xFFFFD700)), // Gold color for the border
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 15), // Added padding for vertical spacing
                          ),
                          child: Text(
                            "Log In",
                            style: TextStyle(
                              color: Color(0xFFFFD700), // Gold color for the text
                              fontSize: 18, // Increased font size
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}