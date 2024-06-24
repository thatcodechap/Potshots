import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'Otp.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  String _emailError = '';
  String _passwordError = '';
  String _serverError = '';

  Future<void> _signUp() async {
    final String name = _nameController.text;
    final String email = _emailController.text;
    final String password = _passwordController.text;
    final String confirmPassword = _confirmPasswordController.text;

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

    // Validate password match
    if (password != confirmPassword) {
      setState(() {
        _passwordError = "Password doesn't match";
      });
      return;
    } else {
      setState(() {
        _passwordError = '';
      });
    }

    Navigator.push(context,
        MaterialPageRoute(builder: (context)=>OtpVerificationPage()));
    // Send sign up request
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/signup'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      // Successfully signed up
      Navigator.push(context,
          MaterialPageRoute(builder: (context)=>OtpVerificationPage()));
    } else {
      Navigator.push(context,
          MaterialPageRoute(builder: (context)=>OtpVerificationPage()));
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
                'Sign Up',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Fill details to continue.',
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 24.0),
              Image.asset('assets/front-banner.png', height: 150.0),
              SizedBox(height: 24.0),
              _buildInputField(_nameController, 'Name', context),
              _buildInputField(_emailController, 'Email', context, errorText: _emailError),
              _buildInputField(_passwordController, 'Password', context, obscureText: true),
              _buildInputField(_confirmPasswordController, 'Confirm Password', context, obscureText: true, errorText: _passwordError),
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
                onPressed: _signUp,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFFD700), // Button color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 16.0),
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Already have an account? Login',
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
              _passwordError = '';
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