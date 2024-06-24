import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _emailError = '';
  String _serverError = '';

  Future<void> _login() async {
    final String email = _emailController.text;
    final String password = _passwordController.text;

    // Validate email
    final emailRegExp = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    if (!emailRegExp.hasMatch(email)) {
      setState(() {
        _emailError = 'Invalid email';
      });
      return;
    } else {
      setState(() {
        _emailError = '';
      });
    }

    // Send login request
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      // Successfully logged in
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('Login successful!'),
          );
        },
      );
    } else {
      // Failed to log in
      final responseData = jsonDecode(response.body);
      setState(() {
        _serverError = responseData['error'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 50.0), // Added to center content initially
              Text(
                'Login',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Enter your credentials to continue.',
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 24.0),
              Image.asset('assets/front-banner.png', height: 150.0),
              SizedBox(height: 24.0),
              _buildInputField(_emailController, 'Email', context, errorText: _emailError),
              _buildInputField(_passwordController, 'Password', context, obscureText: true),
              if (_serverError.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    _serverError,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFFD700), // Button color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 16.0), minimumSize: Size(double.infinity, 50)
                ),
                child: Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Don\'t have an account? Sign Up',
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 14.0,
                ),
              ),
              SizedBox(height: 50.0), // Added to push content up initially
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(TextEditingController controller, String hintText, BuildContext context, {bool obscureText = false, String errorText = ''}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          obscureText: obscureText,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.white54),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white54), // Default border color
              borderRadius: BorderRadius.circular(8.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFFFD700)), // Border color on focus
              borderRadius: BorderRadius.circular(8.0),
            ),
            filled: true,
            fillColor: Colors.black54,
          ),
          onChanged: (value) {
            setState(() {
              _emailError = '';
              _serverError = '';
            });
          },
        ),
        if (errorText.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              errorText,
              style: TextStyle(color: Colors.red),
            ),
          ),
        SizedBox(height: 16.0),
      ],
    );
  }
}