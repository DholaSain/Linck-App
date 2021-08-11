import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:linkhead/Controller/authController.dart';
import 'package:linkhead/Screens/HomeScreen.dart';
import 'package:linkhead/Services/DatabaseService.dart';

class EditProfileScreen extends GetWidget<AuthController> {
  final TextEditingController linkController = TextEditingController();
  final TextEditingController linkNameController = TextEditingController();
  final TextEditingController facebookController = TextEditingController();
  final TextEditingController instagramController = TextEditingController();
  final TextEditingController linkedinController = TextEditingController();
  final TextEditingController pinterestController = TextEditingController();
  final TextEditingController playstoreController = TextEditingController();
  final TextEditingController snapchatController = TextEditingController();
  final TextEditingController tiktokController = TextEditingController();
  final TextEditingController twichController = TextEditingController();
  final TextEditingController twitterController = TextEditingController();
  final TextEditingController youtubeController = TextEditingController();
  final String userName =
      Get.find<AuthController>().userGetter!.email!.split("@")[0];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildAddSocialLink('Facebook', facebookController),
                  SizedBox(height: 10),
                  buildAddSocialLink('Instagram', instagramController),
                  SizedBox(height: 10),
                  buildAddSocialLink('Linkedin', linkedinController),
                  SizedBox(height: 10),
                  buildAddSocialLink('Pinterest', pinterestController),
                  SizedBox(height: 10),
                  buildAddSocialLink('Playstore', playstoreController),
                  SizedBox(height: 10),
                  buildAddSocialLink('Snapchat', snapchatController),
                  SizedBox(height: 10),
                  buildAddSocialLink('TikTok', tiktokController),
                  SizedBox(height: 10),
                  buildAddSocialLink('Twitch', twichController),
                  SizedBox(height: 10),
                  buildAddSocialLink('Twitter', twitterController),
                  SizedBox(height: 10),
                  buildAddSocialLink('YouTube', youtubeController),
                  SizedBox(height: 25),
                  Text(
                    'Add Custom Link',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.amber,
                    ),
                    padding: EdgeInsets.only(left: 20, right: 8),
                    child: TextField(
                      controller: linkNameController,
                      decoration: InputDecoration(
                        fillColor: Colors.black,
                        border: InputBorder.none,
                        icon: Icon(
                          Icons.title,
                          color: Colors.green,
                        ),
                        hintText: 'Enter Title',
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.amber,
                    ),
                    padding: EdgeInsets.only(left: 20, right: 8),
                    child: TextField(
                      controller: linkController,
                      decoration: InputDecoration(
                        fillColor: Colors.black,
                        border: InputBorder.none,
                        icon: Icon(
                          Icons.add_link,
                          color: Colors.green,
                        ),
                        hintText: 'Enter Link',
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  MaterialButton(
                    color: Colors.orange,
                    onPressed: () async {
                      if (linkController.text != '') {
                        await DataBase().addCustomLink(linkNameController.text,
                            linkController.text, userName);
                        linkNameController.clear();
                        linkController.clear();
                      }
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  SizedBox(height: 20),
                  MaterialButton(
                    color: Colors.amber,
                    onPressed: () async {
                      Get.offAll(HomeScreen());
                    },
                    child: Text('Goto Home'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildAddSocialLink(
    String title,
    TextEditingController textController,
  ) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.amber,
      ),
      padding: EdgeInsets.only(left: 20, right: 8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: textController,
              decoration: InputDecoration(
                fillColor: Colors.black,
                border: InputBorder.none,
                icon: SvgPicture.asset(
                  'assets/SVG/$title.svg',
                  width: 30,
                ),
                hintText: title,
              ),
            ),
          ),
          MaterialButton(
            color: Colors.orange,
            onPressed: () async {
              if (textController.text != '') {
                await DataBase()
                    .addSocialLink(title, textController.text, userName);
                Get.snackbar("Link Added", textController.text,
                    snackPosition: SnackPosition.BOTTOM);
                textController.clear();
              }
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.add,
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}
