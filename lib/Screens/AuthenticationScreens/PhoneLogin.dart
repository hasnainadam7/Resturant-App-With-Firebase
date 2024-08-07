// ignore_for_file: file_names
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:resturantapp/utils/colors.dart';
// import 'package:resturantapp/utils/dimmensions.dart';
// import 'package:resturantapp/widgets/BigText.dart';
// import 'package:resturantapp/widgets/SmallText.dart';
//
// import '../../widgets/Button.dart';
// import '../../widgets/InputField.dart';
// import '../../widgets/SocialMediaIcons.dart';
//
// class PhoneLogin extends StatelessWidget {
//   const PhoneLogin({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       padding: EdgeInsets.only(
//           left: Dimmensions.Width30,
//           right: Dimmensions.Width30,
//           top: Dimmensions.Height10),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         // crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           SizedBox(
//             height: Dimmensions.Height30 * 0.5,
//           ),
//           Container(
//             height: Dimmensions.Height30 * 6,
//             width: Dimmensions.Width30 * 15,
//             decoration: BoxDecoration(
//                 image: DecorationImage(
//                     image: AssetImage("assets/image/logo part 1.png"))),
//           ),
//           Align(
//             child: BigText(
//               text: "Hello",
//               size: Dimmensions.Height10 * 5.5,
//             ),
//             alignment: Alignment.centerLeft,
//           ),
//           Align(
//               child: SmallText(
//                   text: "Sign into your account",
//                   size: Dimmensions.Height10 * 1.5),
//               alignment: Alignment.centerLeft),
//           SizedBox(
//             height: Dimmensions.Height30 * 0.5,
//           ),
//           InputField(
//             labelText: 'Username',
//             hintText: 'Enter your username',
//             icon: Icons.person,
//           ),
//           SizedBox(
//             height: Dimmensions.Height30 * 0.5,
//           ),
//           InputField(
//             labelText: 'Password',
//             hintText: 'Enter your password',
//             icon: Icons.password,
//             obscureText: true,
//           ),
//           SizedBox(
//             height: Dimmensions.Height30 * 0.5,
//           ),
//           Align(
//               child: SmallText(
//                   text: "Sign into your account",
//                   size: Dimmensions.Height10 * 1.5),
//               alignment: Alignment.centerRight),
//           SizedBox(
//             height: Dimmensions.Height30 * 0.5,
//           ),
//           Button(callBack: () {  }, Label: 'PhoneLogin',),
//           SizedBox(
//             height: Dimmensions.Height30 * 0.5,
//           ),
//           Row(
//
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               SocialMediaIcons(imgUrl: 'assets/image/f.png',),
//               SizedBox(width: Dimmensions.Width30,),
//               SocialMediaIcons(imgUrl: 'assets/image/g.png',),
//               SizedBox(width: Dimmensions.Width30,),
//               SocialMediaIcons(imgUrl: 'assets/image/t.png',),
//             ],
//           ),
//           SizedBox(
//             height: Dimmensions.Height30 * 0.5,
//           ),
//           Wrap(
//             children: [SmallText(text: "Don\'t have an account?",size: Dimmensions.Height15*1.5,),SmallText(text: " Create",color: Colors.black,fontweight:FontWeight.w700,size: Dimmensions.Height15*1.5),],
//           )
//         ],
//       ),
//     );
//   }
//
//
// }
