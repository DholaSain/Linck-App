import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linkhead/Controller/authController.dart';
import 'package:linkhead/Screens/signinScreen.dart';

class SignupScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  // final TextEditingController userNameController = TextEditingController();
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
                textFieldWidget(nameController, Icons.person, 'Enter Name'),
                SizedBox(height: 15),
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
                      await Get.find<AuthController>().createUser(
                          nameController.text,
                          emailController.text,
                          passwordController.text);
                    },
                    child: Text('SIGNUP'),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an Account?  '),
                    InkWell(
                      onTap: () {
                        Get.off(SigninScreen());
                      },
                      child: Text(
                        'Signin',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.green),
                      ),
                    )
                  ],
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
