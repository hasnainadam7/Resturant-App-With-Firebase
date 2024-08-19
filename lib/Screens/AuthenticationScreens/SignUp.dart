import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resturantapp/models/response_model.dart';

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

  Future<void> registration(AuthRepoController authrepo, context) async {
    String user = userNameEditingController.text.trim();
    String password = passEditingController.text.trim();
    String email = emailEditingController.text.trim();
    String phone = phoneEditingController.text.trim();
    String message;
    bool status=false;

    ResponseModel? res;
    if (user.isEmpty ||
        phone.isEmpty ||
        email.isEmpty ||
        password.length < 6 ||
        !GetUtils.isEmail(email)) {
      message = "Please fill the box Correctly";
    } else {
      RegistrationModel registrationModel = RegistrationModel(
        phone: phone,
        f_name: user,
        email: email,
        password: password,
      );
      try {
        res = await authrepo.registration(registrationModel);
        if (res.isSuccuess) {
          Navigator.pop(
              context, Routeshelper.getFoodHomePageRoute(0));
          message = res.message;
          status = res.isSuccuess;
          CustomSnackbar.showSnackbar(isError: false,description: message, duration: 2);
        } else {
          message = res.message;
          CustomSnackbar.showSnackbar(isError: true,description: message, duration: 2);
        }
      } catch (e) {
        message = e.toString();
        CustomSnackbar.showSnackbar(isError: true,description: message, duration: 2);
      }
    }


  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: GetBuilder<AuthRepoController>(builder: (authController) {
        return SingleChildScrollView(
            padding: EdgeInsets.only(
                left: Dimension.Width30,
                right: Dimension.Width30,
                top: Dimension.Height10),
            child: Column(
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
                          image: AssetImage("assets/images/logo part 1.png"))),
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
                Center(
                  child: authController.isLoading
                      ? const Customloadingbar()
                      : Button(
                          callBack: () async {
                            await registration(authController, context);
                          },
                          Label: 'SignUp',
                        ),
                ),
                SizedBox(
                  height: Dimension.Height30 * 0.5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SocialMediaIcons(
                      imgUrl: 'assets/images/f.png',
                    ),
                    SizedBox(
                      width: Dimension.Width30,
                    ),
                    const SocialMediaIcons(
                      imgUrl: 'assets/images/g.png',
                    ),
                    SizedBox(
                      width: Dimension.Width30,
                    ),
                    const SocialMediaIcons(
                      imgUrl: 'assets/images/t.png',
                    ),
                  ],
                ),
                SizedBox(
                  height: Dimension.Height30 * 0.5,
                ),
                GestureDetector(
                  onTap: () {
                    // Get.offNamed(Routeshelper.getLoginPageRoute());

                    Navigator.pushReplacementNamed(
                      context,
                      Routeshelper.getLoginPageRoute()
                    );},
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
