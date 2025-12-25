import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:grocery_app/constants/AppColor.dart';
import 'package:grocery_app/screen/selected_location_page.dart';
import 'package:grocery_app/services/google_sign_in_service.dart';
import 'package:grocery_app/widgets/custom_button_widget.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final spacing = 24.0;
  final imageFacebookPath = 'assets/icons/icons8-facebook-f-96.png';
  final imageGooglePath = 'assets/icons/icons8-google-96.png';
  final GoogleSignInService _googleSignInService = GoogleSignInService();
  Widget build(BuildContext context) {
    final loginSlide = 'assets/images/login-slide.png';
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(loginSlide),
          Padding(
            padding: EdgeInsets.all(14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Get your groceries\nwith nectar',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: spacing),
                TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 15),
                    prefixIcon: CountryCodePicker(onChanged: (value) {}),
                    hintText: 'Enter your phone number',
                  ),
                ),
                SizedBox(height: spacing),
                CustomButtonWidget(
                  title: 'Login with phone',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SelectedLocationPage(),
                      ),
                    );
                  },
                ),
                SizedBox(height: spacing),
                Center(child: Text('Or Connect with social media')),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    children: [
                      SizedBox(height: spacing),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                            foregroundColor: Colors.white,
                            backgroundColor: Color(0xff5583ec),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(
                                imageGooglePath,
                                height: 46,
                                color: Colors.white,
                              ),
                              SizedBox(width: 30),
                              Text(
                                'Continue with Google',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: spacing),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              horizontal: 22,
                              vertical: 12,
                            ),
                            foregroundColor: Colors.white,
                            backgroundColor: Color(0xff4a65ac),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(
                                imageFacebookPath,
                                height: 46,
                                color: Colors.white,
                              ),
                              SizedBox(width: 30),
                              Text(
                                'Continue with Facebook',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
