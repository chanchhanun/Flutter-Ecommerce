import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grocery_app/controllers/auth_controller.dart';
import 'package:grocery_app/screen/sign_up_page.dart';

import '../constants/AppColor.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final iconColor = 'assets/icons/app_icon_color.svg';

  final _usernanmeController = TextEditingController();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  final double spaceHeight = 24;

  final _keyForm = GlobalKey<FormState>();

  final authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 100),
              Center(child: SvgPicture.asset(iconColor, height: 60)),
              Text(
                'Login',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'Enter your incidentals to continue',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: grayDark,
                ),
              ),
              SizedBox(height: spaceHeight),
              Form(
                key: _keyForm,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: spaceHeight),
                    Text(
                      'Email',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: grayDark,
                      ),
                    ),
                    TextFormField(
                      style: TextStyle(fontWeight: FontWeight.bold),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please input email';
                        }
                        return null;
                      },
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: 'Enter email',
                        suffixIcon: Icon(Icons.check, color: Colors.green),
                        hintStyle: TextStyle(fontWeight: FontWeight.normal),
                      ),
                    ),
                    SizedBox(height: spaceHeight),
                    Text(
                      'Password',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: grayDark,
                      ),
                    ),
                    TextFormField(
                      obscureText: true,
                      style: TextStyle(fontWeight: FontWeight.bold),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please input password';
                        }
                        return null;
                      },
                      controller: _passwordController,
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.visibility_off_outlined),
                        hintText: 'Enter password',
                        hintStyle: TextStyle(fontWeight: FontWeight.normal),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: spaceHeight),
              Align(
                alignment: Alignment.centerRight,
                child: Text('Forgot password?', style: TextStyle(fontSize: 16)),
              ),
              SizedBox(height: spaceHeight),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_keyForm.currentState!.validate()) {
                      await authController.login(
                        _emailController.text,
                        _passwordController.text,
                      );
                      print(_emailController.text);
                      print(_passwordController.text);
                    } else {
                      return;
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(12.0),
                    backgroundColor: primary,
                    foregroundColor: white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Login',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account? ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpPage()),
                      );
                    },
                    child: Text(
                      'SignUP',
                      style: TextStyle(
                        color: primaryDark,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
