import 'package:flutter/material.dart';
import 'package:homecontrol/features/Auth/presentation/Screen/signup_screen.dart';
import 'package:homecontrol/features/Auth/presentation/widgets/auth_text_field.dart';
import 'package:homecontrol/features/Auth/presentation/widgets/login_button.dart';
import 'package:homecontrol/features/Home/Presentation/Screen/MainScreen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                      'NetHome',
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
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
              loginButton(context, 'Login', Colors.blue, Colors.white, MainScreen()),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(child: Divider(thickness: 1, color: Colors.grey[400])),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "or",
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Expanded(child: Divider(thickness: 1, color: Colors.grey[400])),
                ],
              ),
              SizedBox(height: 20),
              loginButton(context , 'Create an account', Colors.blueGrey, Colors.white, SignupScreen()),
              SizedBox(height: 20),
              Center(
                child: TextButton(
                  onPressed: () {},
                  child: Text('Forgot password?'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}