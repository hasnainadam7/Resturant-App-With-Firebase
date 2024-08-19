// ignore_for_file: non_constant_identifier_names

import 'package:flutter_dotenv/flutter_dotenv.dart';

class Constants {
  // php artisan serve --host=192.168.100.199 --port=8000
  // App Information Constants
  static final String APP_NAME = dotenv.env['APP_NAME']!;
  static final String APP_VERSION = dotenv.env['APP_VERSION']!;

  // API Constants
  static final String BASE_URL = dotenv.env['BASE_URL']!;
  static final String API_VERSION = dotenv.env['API_VERSION']!;

  static final String POPULAR_PRODUCT_API = dotenv.env['POPULAR_PRODUCT_API']!;
  static final String RECOMMENDED_PRODUCT_API = dotenv.env['RECOMMENDED_PRODUCT_API']!;
  static final String IMG_URL_API = dotenv.env['IMG_URL_API']!;

  // Authentication
  static final String AUTH_REGISTRATION_API = dotenv.env['AUTH_REGISTRATION_API']!;
  static final String AUTH_LOGIN_API = dotenv.env['AUTH_LOGIN_API']!;
  static final String USER_INFO_API = dotenv.env['USER_INFO_API']!;

  static final String GEOCODE_API = dotenv.env['GEOCODE_API']!;
  static final String ZONE_ID_API = dotenv.env['ZONE_ID_API']!;
  static final String AUTO_COMPLETE_PLACE_API = dotenv.env['AUTO_COMPLETE_PLACE_API']!;

  static final String USER_ADDRESS = dotenv.env['USER_ADDRESS']!;
  static final String ADD_USER_ADDRESS_API = dotenv.env['ADD_USER_ADDRESS_API']!;
  static final String GET_USER_ADDRESS_LIST_API = dotenv.env['GET_USER_ADDRESS_LIST_API']!;

  // Local Storages Constants
  static final String UID = dotenv.env['UID']!;
  static final String CARTLIST = dotenv.env['CARTLIST']!;
  static final String CARTHISTORYLIST = dotenv.env['CARTHISTORYLIST']!;
//stripe crendtials
  static final String STRIPE_PK = dotenv.env['STRIPE_PK']!;
  static final String STRIPE_SK = dotenv.env['STRIPE_SK']!;


}
