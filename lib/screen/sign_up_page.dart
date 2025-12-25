import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocery_app/constants/AppColor.dart';
import 'package:grocery_app/screen/login_page.dart';
import 'package:get/get.dart';
import 'package:grocery_app/services/apis/auth_api.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  final iconColor = 'assets/icons/app_icon_color.svg';

  final _usernanmeController = TextEditingController();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  final double spaceHeight = 24;

  final _keyForm = GlobalKey<FormState>();

  final authApi = Get.put(AuthApi());

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
                'Sign Up',
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
                    Text(
                      'Username',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: grayDark,
                      ),
                    ),
                    TextFormField(
                      style: TextStyle(fontWeight: FontWeight.bold),
                      controller: _usernanmeController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please input username';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter username',
                        hintStyle: TextStyle(fontWeight: FontWeight.normal),
                      ),
                    ),
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
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'By continuing you agree to our ',
                      style: TextStyle(fontSize: 18, color: grayDark),
                    ),
                    TextSpan(
                      text: 'Terms of Service',
                      style: TextStyle(fontSize: 18, color: primaryDark),
                    ),
                    TextSpan(
                      text: ' and ',
                      style: TextStyle(fontSize: 18, color: grayDark),
                    ),
                    TextSpan(
                      text: 'Privacy Policy',
                      style: TextStyle(fontSize: 18, color: primaryDark),
                    ),
                  ],
                ),
              ),
              SizedBox(height: spaceHeight),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_keyForm.currentState!.validate()) {
                      await authApi.register(
                        _usernanmeController.text,
                        _emailController.text,
                        _passwordController.text,
                      );
                      print(_usernanmeController.text);
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
                    'Sign Up',
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
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: Text(
                      'Login',
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
