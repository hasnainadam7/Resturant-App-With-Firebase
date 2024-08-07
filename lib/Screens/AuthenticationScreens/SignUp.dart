import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:resturantapp/utils/colors.dart';

import 'package:resturantapp/utils/dimmensions.dart';
import 'package:resturantapp/widgets/SmallText.dart';
import 'package:resturantapp/widgets/snackbar.dart';

import '../../Routes/routesHelper.dart';
import '../../controller/auth_controller.dart';

import '../../models/registration_models.dart';
import '../../widgets/Button.dart';
import '../../widgets/CustomLoadingBar.dart';
import '../../widgets/InputField.dart';
import '../../widgets/SocialMediaIcons.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passEditingController = TextEditingController();
  TextEditingController userNameEditingController = TextEditingController();
  TextEditingController phoneEditingController = TextEditingController();


  Future<void> registration(AuthRepoController authrepo) async {

    String user = userNameEditingController.text.trim();
    String password = passEditingController.text.trim();
    String email = emailEditingController.text.trim();
    String phone = phoneEditingController.text.trim();

    if (user.isEmpty ||
        phone.isEmpty ||
        email.isEmpty ||
        password.length < 6 ||
        !GetUtils.isEmail(email) ) {
      CustomSnackbar.showSnackbar(description: "Please fill the box Correctly");
    } else {
      CompleteRegistrationModel registrationModel = CompleteRegistrationModel(
        phone: phone,
        f_name: user,
        email: email,
        password: password,
      );
    await  authrepo.registration(registrationModel).then((status) async {
        // if (status.isSuccuess) {
        //   CustomSnackbar.showSnackbar(
        //       description: "Registration Successfully done",
        //       isError: false,
        //       title: "Wellcome $user");
        //
        //   await Get.find<UserRepoController>().getUserInfo();Get.find<UserRepoController>().getUserInfo();
        //   Get.toNamed(Routeshelper.getFoodHomePageRoute(3));
        // } else {
        //   CustomSnackbar.showSnackbar(description: "Registration Failed");
        // }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<AuthRepoController>(builder: (authController) {
        return authController.isLoading ? const Customloadingbar():SingleChildScrollView(
            padding: EdgeInsets.only(
                left: Dimension.Width30,
                right: Dimension.Width30,
                top: Dimension.Height10),
            child: authController.isLoading
                ?const Customloadingbar()
                : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: Dimension.Height30 * 0.5,
                      ),
                      Container(
                        height: Dimension.Height30 * 6,
                        width: Dimension.Width30 * 15,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage("assets/image/logo part 1.png"))),
                      ),
                      InputField(
                        labelText: 'Email',
                        hintText: 'Enter your email address',
                        icon: Icons.email_rounded,
                        textEditingController: emailEditingController,
                      ),
                      SizedBox(
                        height: Dimension.Height30 * 0.5,
                      ),
                      InputField(
                        labelText: 'Password',
                        hintText: 'Enter your password',
                        icon: Icons.password,
                        obscureText: true,
                        textEditingController: passEditingController,
                      ),
                      SizedBox(
                        height: Dimension.Height30 * 0.5,
                      ),
                      InputField(
                        labelText: 'Phone',
                        hintText: 'Enter your phone number',
                        icon: Icons.phone,
                        textEditingController: phoneEditingController,
                      ),
                      SizedBox(
                        height: Dimension.Height30 * 0.5,
                      ),
                      InputField(
                        labelText: 'User',
                        hintText: 'Enter your username',
                        icon: Icons.person,
                        textEditingController: userNameEditingController,
                      ),
                      SizedBox(
                        height: Dimension.Height30 * 0.5,
                      ),
                      Button(
                        callBack: () async {
                          try{
                            UserCredential userCredential =await  FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailEditingController.text.trim(), password:passEditingController.text.trim());
                            print("AUTH RESPOSENE $userCredential");
                          }catch(e){
                            print("Error $e");
                          }
                          // registration(authController);

                        },
                        Label: 'SignUp',
                      ),
                      SizedBox(
                        height: Dimension.Height30 * 0.5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SocialMediaIcons(
                            imgUrl: 'assets/image/f.png',
                          ),
                          SizedBox(
                            width: Dimension.Width30,
                          ),
                          const SocialMediaIcons(
                            imgUrl: 'assets/image/g.png',
                          ),
                          SizedBox(
                            width: Dimension.Width30,
                          ),
                          const SocialMediaIcons(
                            imgUrl: 'assets/image/t.png',
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Dimension.Height30 * 0.5,
                      ),
                      GestureDetector(
                        onTap: (){
                          // Get.offNamed(Routeshelper.getLoginPageRoute());

                          Navigator.pushReplacementNamed(context, Routeshelper.getFoodHomePageRoute(0));
                        },
                        child: Wrap(
      
                          children: [
                            SmallText(
                              text: "Already have an account?",
                              size: Dimension.Height15 * 1.5,
                            ),
                            SmallText(
                                text: " Sign-in",
                                color: AppColors.mainColor,
                                fontweight: FontWeight.w700,
                                size: Dimension.Height15 * 1.5),
                          ],
                        ),
                      )
                    ],
                  ));
      }),
    );
  }
}
