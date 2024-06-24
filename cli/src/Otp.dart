import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OtpVerificationPage extends StatefulWidget {
  @override
  _OtpVerificationPageState createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  final List<TextEditingController> _controllers =
  List.generate(6, (index) => TextEditingController());

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _moveToNextField(String value, int index) {
    if (value.length == 1 && index < 3) {
      FocusScope.of(context).nextFocus();
    } else if (value.isEmpty && index > 0) {
      FocusScope.of(context).previousFocus();
    }
  }

  Future<void> _verifyOtp() async {
    String otp = _controllers.map((controller) => controller.text).join();
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/verify'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'otp': otp}),
    );

    if (response.statusCode == 200) {
      // Handle successful verification
      print('OTP Verified');
    } else {
      // Handle unsuccessful verification
      print('OTP Verification Failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'OTP Verification',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(height: 10),
              Image.asset('assets/front-banner.png', height: 150.0),
              SizedBox(height: 10),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(4, (index) {
                  return Container(
                    width: 60,
                    child: TextField(
                      controller: _controllers[index],
                      maxLength: 1,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 24, color: Colors.white),
                      decoration: InputDecoration(
                        counterText: '',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white54),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFFFD700)),
                        ),
                      ),
                      onChanged: (value) {
                        _moveToNextField(value, index);
                      },
                    ),
                  );
                }),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  // Resend OTP logic here
                },
                child: Text(
                  "Didn't get the otp? Resend",
                  style: TextStyle(color: Color(0xFFFFD700)),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _verifyOtp,
                child: Text('Verify', style: TextStyle(fontSize: 18, color: Colors.black),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFFD700),
                  padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}