// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resturantapp/controller/user_repo_controller.dart';
import 'package:resturantapp/utils/colors.dart';
import 'package:resturantapp/utils/dimmensions.dart';
import 'package:resturantapp/widgets/BigText.dart';
import 'package:resturantapp/widgets/CustomLoadingBar.dart';
import 'package:resturantapp/widgets/SmallText.dart';

import '../../Routes/routesHelper.dart';
import '../../controller/auth_controller.dart';
import '../../widgets/Button.dart';
import '../../widgets/InputField.dart';
import '../../widgets/SocialMediaIcons.dart';
import '../../widgets/snackbar.dart';

class Login extends StatelessWidget {
  Login({super.key});
  TextEditingController emailEditingController = TextEditingController();

  TextEditingController  passwordEditingController = TextEditingController();

  Future<void> _login(AuthRepoController authrepo,context) async {
    String password = passwordEditingController.text.trim();
    String email = emailEditingController.text.trim();

    if (email.isEmpty || password.length < 6 || !GetUtils.isEmail(email)) {
      CustomSnackbar.showSnackbar(description: "Please fill the box Correctly");
    } else {
      await authrepo.login(email, password).then((status) async {
        if (status.isSuccuess) {
          CustomSnackbar.showSnackbar(
              description: "Registration Successfully done",
              isError: false,
              title: "Wellcome");
          await Get.find<UserRepoController>().getUserInfo();


          Navigator.pushReplacementNamed(context, Routeshelper.getFoodHomePageRoute(0));
        } else {
          CustomSnackbar.showSnackbar(description: status.message.toString());
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<AuthRepoController>(builder: (authRepoController) {
        return authRepoController.isLoading
            ? const Customloadingbar()
            : SingleChildScrollView(
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
                              image:
                                  AssetImage("assets/image/logo part 1.png"))),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: BigText(
                        text: "Hello",
                        color: AppColors.mainColor,
                        size: Dimension.Height10 * 5.5,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: SmallText(
                          text: "Sign into your account",
                          size: Dimension.Height10 * 1.5),
                    ),
                    SizedBox(
                      height: Dimension.Height30 * 0.5,
                    ),
                    InputField(
                      labelText: 'Email',
                      hintText: 'Enter your email address',
                      icon: Icons.person,
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
                      textEditingController: passwordEditingController,
                    ),
                    SizedBox(
                      height: Dimension.Height30 * 0.5,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: SmallText(
                          text: "Sign into your account",
                          size: Dimension.Height10 * 1.5),
                    ),
                    SizedBox(
                      height: Dimension.Height30 * 0.5,
                    ),
                    Button(
                      callBack: () {
                        _login(authRepoController,context);
                      },
                      Label: 'Login',
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
                      onTap: () {
                        Get.offNamed(Routeshelper.getRegisrationPageRoute());
                      },
                      child: Wrap(
                        children: [
                          SmallText(
                            text: "Don't have an account?",
                            size: Dimension.Height15 * 1.5,
                          ),
                          SmallText(
                              text: " Create",
                              color: AppColors.mainColor,
                              fontweight: FontWeight.w700,
                              size: Dimension.Height15 * 1.5),
                        ],
                      ),
                    )
                  ],
                ),
              );
      }),
    );
  }
}
