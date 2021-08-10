import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:linkhead/Controller/authController.dart';
import 'package:linkhead/Screens/signupScreen.dart';

class SigninScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                textFieldWidget(emailController, Icons.email, 'Enter Email'),
                SizedBox(height: 15),
                textFieldWidget(
                    passwordController, Icons.password, 'Enter Password'),
                SizedBox(height: 30),
                Container(
                  width: 200,
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    color: Colors.green,
                    onPressed: () async {
                      await Get.find<AuthController>()
                          .logIn(emailController.text, passwordController.text);
                    },
                    child: Text('SIGNIN'),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Don\'t have an Account?  '),
                    InkWell(
                      onTap: () {
                        Get.off(SignupScreen());
                      },
                      child: Text(
                        'Signup',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.green),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 30),
                Container(
                  width: 230,
                  child: MaterialButton(
                    color: Colors.white,
                    onPressed: () async {
                      await Get.find<AuthController>().logInWithGoogle();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/SVG/google.svg',
                            width: 30,
                          ),
                          SizedBox(width: 8),
                          Text('Signin with Google')
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget textFieldWidget(
      TextEditingController textController, IconData icon, String title) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.amber,
      ),
      padding: EdgeInsets.only(left: 20, right: 8),
      child: TextField(
        controller: textController,
        decoration: InputDecoration(
          fillColor: Colors.black,
          border: InputBorder.none,
          icon: Icon(
            icon,
            color: Colors.green,
          ),
          hintText: title,
        ),
      ),
    );
  }
}
