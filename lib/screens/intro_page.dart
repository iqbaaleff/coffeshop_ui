import 'package:flutter/material.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF3E5AB),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo atau Ilustrasi
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset('assets/images/logo.png', height: 250),
              ),

              // Tagline
              Text(
                'Brewing Your Daily Vibe',
                style: TextStyle(fontSize: 18, color: Colors.brown[600]),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 40),

              // Tombol Get Started
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/login');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff6C9A8B),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'Get Started',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
