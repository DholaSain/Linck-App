import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:linkhead/Controller/authController.dart';
import 'package:linkhead/Controller/linkController.dart';
import 'package:linkhead/Controller/userController.dart';
import 'package:linkhead/Screens/editProfileScreen.dart';

class HomeScreen extends GetWidget<AuthController> {
  final TextEditingController linkController = TextEditingController();
  final TextEditingController linkNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                width: 60,
                child: MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: Colors.green,
                    onPressed: () {
                      Get.to(EditProfileScreen());
                    },
                    child: Icon(
                      Icons.add,
                      color: Colors.amber,
                    )),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: Colors.amber[300],
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: -2,
                          blurRadius: 6,
                        )
                      ]),
                  child: GetX<UserController>(
                    init: Get.put(UserController()),
                    builder: (UserController userController) {
                      if (userController != null &&
                          userController.userGetter != null) {
                        print(userController.userGetter!.name);
                        return Column(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 50,
                              foregroundImage: NetworkImage(
                                userController.userGetter!.imageUrl!,
                              ),
                              backgroundImage: AssetImage('assets/dp.png'),
                            ),
                            SizedBox(height: 20),
                            Text(
                              userController.userGetter!.name!,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                            ),
                            Container(),
                            SizedBox(height: 10),
                            if (userController.userGetter!.description! != '')
                              Text(
                                userController.userGetter!.description!,
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                          ],
                        );
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ),
                SizedBox(height: 20),
                GetX<LinksController>(
                  init: Get.put(LinksController()),
                  builder: (LinksController linksController) {
                    if (linksController != null &&
                        linksController.customLinks != null) {
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: linksController.customLinks!.length,
                          itemBuilder: (_, index) {
                            return Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.amber),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 6),
                              child: Column(
                                children: [
                                  Text(
                                    linksController
                                        .customLinks![index].linkName!,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  SizedBox(height: 3),
                                  Text(
                                    linksController.customLinks![index].link!,
                                  ),
                                ],
                              ),
                            );
                          });
                    } else {
                      return LinearProgressIndicator();
                    }
                  },
                ),
                SizedBox(height: 20),
                GetX<LinksController>(
                  init: Get.put(LinksController()),
                  builder: (LinksController linksController) {
                    if (linksController != null &&
                        linksController.socialLinks != null) {
                      return GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                            crossAxisCount: 3,
                            childAspectRatio: 3 / 3,
                          ),
                          itemCount: linksController.socialLinks!.length,
                          itemBuilder: (_, index) {
                            return Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(15)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'assets/SVG/${linksController.socialLinks![index].linkName!}.svg',
                                    width: 50,
                                  ),
                                  SizedBox(height: 6),
                                  Text(
                                    linksController
                                        .socialLinks![index].linkName!,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            );
                          });
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
                SizedBox(height: 20),
                MaterialButton(
                  color: Colors.red,
                  onPressed: () async {
                    await controller.signOut();
                  },
                  child: Text('Logout'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
