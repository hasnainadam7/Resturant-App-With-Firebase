// ignore_for_file: non_constant_identifier_names

import 'package:get/get.dart';

class Dimension {
  //Pixel 4 is reference height and width while development

  static double MobileHeight = Get.context!.height; //781.0909090909091
  static double MobileWidth = Get.context!.width;   //392.72727272727275

//Main Home Screens
  //Home Screen Slider Container
  static double HomeSliderContainerHeight = MobileHeight / 3;
  static double homeImageContainerHeight = HomeSliderContainerHeight / 1.5;
  static double homeTextContainerHeight = HomeSliderContainerHeight / 1.9;
  static double homeTextContainerWidth = MobileWidth / 1.5;

  //Home Screen ListView Container
  static double HomeListViewContainerHeight = MobileHeight /2.5 ;

  static double HomeListViewImageHeight = HomeListViewContainerHeight /2.65 ;
  static double HomeListViewImageWidth = MobileWidth /3.3 ;

  static double HomeListViewTextHeight = HomeListViewContainerHeight /2.2 ;
  static double HomeListViewTextWidth = MobileWidth /1.665 ;

//Popular Screens

  static double PopularImageContainer = MobileHeight / 2.41;
  static double PopularDecriptionContainer = MobileHeight / 1.85;
  static double PopularButtonContainer = MobileHeight / 9.50;

  //Dynamic values use for margin padding and sizedboxes
  static double Width3 = MobileWidth / (84*3);
  static double Width5 = MobileWidth / 168;

  static double Height10 = MobileHeight / 84;
  static double Width10 = MobileWidth / 84;

  static double Height15 = MobileHeight / 57.27;
  static double Width15 = MobileWidth / 57.27;

  static double Height30 = MobileHeight / 21;
  static double Width30 = MobileWidth / 21;


  //dynamic values use for different Texts
  static double BigTexts =   MobileWidth/20;

  static double SmallTexts = MobileWidth/30;

//IconSizes
  static double IconSize =   MobileWidth/20;



  //dynamic values use for border radius
  static double BorderRadius5= MobileHeight / 168;
//Appcloumn
  static double AppColumnHeight= MobileHeight /6.525;


  //History Page
  static double HistoryIMGSHeight=  Dimension.Height10*8;
  static double HistoryIMGSWidth=  Dimension.Width10 * 17;


  static double PaymentBtnHeight= Dimension.MobileHeight /15.7;
  static double PaymentBtnWidth=  Dimension.MobileWidth/2.3;

  //No Data Page
  static double noDataImgWidth=  Dimension.Width30*15;
  static double noDataImgHeight= Dimension.Height30*5;

}
