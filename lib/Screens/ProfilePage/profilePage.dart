// ignore_for_file: non_constant_identifier_names, file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resturantapp/Routes/routesHelper.dart';
import 'package:resturantapp/controller/auth_controller.dart';
import 'package:resturantapp/controller/cart_repo_controller.dart';
import 'package:resturantapp/controller/location_repo_controller.dart';
import 'package:resturantapp/controller/product_repo_controller.dart';
import 'package:resturantapp/utils/colors.dart';
import 'package:resturantapp/utils/dimmensions.dart';
import 'package:resturantapp/widgets/AppIcons.dart';
import 'package:resturantapp/widgets/BigText.dart';
import '../../models/user_model.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          return GetBuilder<AuthRepoController>(builder: (authRepoController) {
            if(authRepoController.userModel !=null){
              return _ProfileSection( authRepoController.userModel!);
            }else{
              return const Center(child: CircularProgressIndicator());
            }


          });

          // User is signed in
        } else {
          return _LogoutScreen(context); // User is not signed in
        }
      },
    );
  }

  Scaffold _LogoutScreen(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Color(
                    0xFFE5E7EB), // using the light gray color from your color scheme
                image: DecorationImage(
                  image: AssetImage("assets/images/signintocontinue.png"),
                  fit: BoxFit.cover, // ensures the image covers the container
                ),
              ),
              height: 200, // setting a height for the container
              width: double.infinity, // making the container full width
            ),
            SizedBox(
                height: Dimension.Height10 *
                    2), // adding space between the image and the text
            GestureDetector(
              onTap: () {
                // Get.toNamed(Routeshelper.getLoginPageRoute());
                Navigator.pushNamed(
                  context,
                  Routeshelper.getLoginPageRoute(),
                );
              },
              child: const BigText(
                color: Color(0xFF120c78),
                text: 'Sign Up to continue',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Scaffold _ProfileSection(UserModel user, {bool Check = true}) {
    return Scaffold(
        appBar: AppBar(
            title: const BigText(
              text: "Profile",
              color: Colors.white,
            ),
            centerTitle: true,
            backgroundColor: AppColors.mainColor),
        body: SafeArea(
          child: Container(
            color: const Color.fromRGBO(239, 239, 239, 1.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: Dimension.Height10 * 8,
                    child: Appicons(
                      IconSize: Dimension.Height10 * 16,
                      size: Dimension.Height10 * 10,
                      icon: Icons.person,
                      colr: Colors.white,
                      backclor: AppColors.mainColor,
                    ),
                  ),
                ),
                Expanded(
                    child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: Dimension.Width30,
                      ),
                      _Container(
                          icon: Icons.person,
                          txt: user.displayName!,
                          clr: AppColors.mainColor),
                      SizedBox(
                        height: Dimension.Width30,
                      ),
                      _Container(icon: Icons.phone, txt: user.phoneNumber!),
                      SizedBox(
                        height: Dimension.Width30,
                      ),
                      _Container(icon: Icons.email_rounded, txt: user.email!),
                      SizedBox(
                        height: Dimension.Width30,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(Routeshelper.addressRoute);
                        },
                        child: _Container(
                          icon: Icons.location_on,
                          // txt:
                          txt: Get.find<LocationRepoController>()
                                  .addressList.isNotEmpty ? Get.find<LocationRepoController>()
                              .addressList.last.addressDescription
                                  :
                              "Press to add address",
                        ),
                      ),
                      SizedBox(
                        height: Dimension.Width30,
                      ),
                      _Container(
                          icon: Icons.message,
                          txt: 'none',
                          clr: Colors.redAccent),
                      SizedBox(
                        height: Dimension.Width30,
                      ),
                      GestureDetector(
                          onTap: () {
                            if (Check) {
                              Get.find<AuthRepoController>().signOut();
                              Get.find<CartRepoController>().clearCart();
                              Get.find<CartRepoController>().clearCartHistory();
                              //   Get.toNamed(
                              //       Routeshelper.getInitialRoute());
                            }
                          },
                          child: _Container(
                              icon: Icons.logout,
                              txt: 'logout',
                              clr: Colors.redAccent)),
                    ],
                  ),
                ))
              ],
            ),
          ),
        ));
  }

  Container _Container(
      {required IconData icon,
      required String txt,
      Color clr = Colors.amberAccent}) {
    return Container(
      height: Dimension.Height30 * 2.5,
      width: Dimension.Width30 * 20,
      padding: EdgeInsets.only(
          left: Dimension.Height10,
          top: Dimension.Height10,
          bottom: Dimension.Height10,
          right: Dimension.Height10),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            offset: const Offset(0, 2),
            blurRadius: 1,
            color: Colors.grey.withOpacity(0.2)),
        BoxShadow(
            offset: const Offset(2, 0),
            blurRadius: 1,
            color: Colors.grey.withOpacity(0.2))
      ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Appicons(
            size: Dimension.Height30,
            IconSize: Dimension.Height10 * 7,
            icon: icon,
            backclor: clr,
            colr: Colors.white,
          ),
          SizedBox(
            width: Dimension.Width30,
          ),
          Expanded(
            child: BigText(
              text: txt,
            ),
          )
        ],
      ),
    );
  }
}
