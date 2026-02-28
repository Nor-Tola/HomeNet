import 'package:flutter/material.dart';
import 'package:homecontrol/features/Auth/presentation/widgets/auth_text_field.dart';
import 'package:homecontrol/features/Auth/presentation/widgets/login_button.dart';
import 'package:homecontrol/features/Home/Presentation/Screen/Homepage.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Text('🏠', style: TextStyle(fontSize: 50)),
                    SizedBox(height: 20),
                    Text(
                      'Welcome to Signup NetHome',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                    ),
                    Text(
                      'Smart Living, Connected',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              Text('Email'),
              SizedBox(height: 10),
              authTextField(
                keyboardType: TextInputType.emailAddress,
                icon: Icons.email,
                hint: 'Email',
              ),
              SizedBox(height: 20),
              Text('Password'),
              SizedBox(height: 10),
              authTextField(
                keyboardType: TextInputType.visiblePassword,
                icon: Icons.lock,
                hint: 'Password',
              ),
              SizedBox(height: 20),
              Text('Confirm Password'),
              SizedBox(height: 20),
              authTextField(
                keyboardType: TextInputType.visiblePassword,
                icon: Icons.lock,
                hint: 'Conform Password',
              ),
              SizedBox(height: 20),
              loginButton(context, 'Sign Up', Colors.blue, Colors.white, Homepage()),
              
            ],
          ),
        ),
      ),
    );
  }
}