import 'package:get/get.dart';
import 'package:navega_app/Feature/auth/views/forget_screen.dart';

import 'package:navega_app/Feature/auth/views/login_screen.dart';
import 'package:navega_app/Feature/auth/views/sign_up.dart';

import 'package:navega_app/Feature/auth/views/splash_screen.dart';
import 'package:navega_app/Feature/client_mood/views/about_license_screen.dart';
import 'package:navega_app/Feature/client_mood/views/boat_detail_screen.dart';
import 'package:navega_app/Feature/client_mood/views/chat_detail_screen.dart';
import 'package:navega_app/Feature/client_mood/views/chat_screen.dart';
import 'package:navega_app/Feature/client_mood/views/favourite_list_screen.dart';
import 'package:navega_app/Feature/client_mood/views/filter_screen.dart';
import 'package:navega_app/Feature/client_mood/views/favorite_screen.dart';
import 'package:navega_app/Feature/client_mood/views/create_favorite_list_screen.dart';
import 'package:navega_app/Feature/client_mood/views/home_screen.dart';
import 'package:navega_app/Feature/client_mood/views/payment_method_screen.dart';
import 'package:navega_app/Feature/client_mood/views/payment_successful_screen.dart';
import 'package:navega_app/Feature/client_mood/views/review_pay_screen.dart';
import 'package:navega_app/Feature/client_mood/views/travel_dates.dart';
import 'package:navega_app/Feature/client_mood/views/trip_screen.dart';

import 'app_routes.dart';

class AppPages {
  AppPages._();

  static const String initial = Routes.splash;

  static final List<GetPage> routes = [
    GetPage(
      name: Routes.splash,
      page: () => const SplashScreen(),
    ),

    GetPage(
      name: Routes.login,
      page: () => const LoginScreen(),
    ),
    GetPage(
      name: Routes.signUp,
      page: () => const SignUpScreen(),
    ),
    GetPage(
      name: Routes.forget,
      page: () => const ForgetPasswordScreen(),
    ),
   GetPage(
      name: Routes.home,
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: Routes.favorites,
      page: () => const FavoriteScreen(),
    ),
    GetPage(
      name: Routes.createFavoriteList,
      page: () => const CreateFavoriteListScreen(),
    ),
    GetPage(
      name: Routes.filter,
      page: () => const FilterScreen(),
    ),
    GetPage(
      name: Routes.boatDetails,
      page: () => const BoatDetailScreen(),
    ),
    GetPage(
      name: Routes.travelDates,
      page: () => const TravelDates(),

    ),
    GetPage(
      name: Routes.reviewPay,
      page: () => const ReviewPayScreen(),
    ),
    GetPage(name: Routes.aboutlicense, 
    page:()=>const AboutLicenseScreen(), 
    ),
    GetPage(name: Routes.aboutTrip, 
    page: ()=>const AboutTripScreen(),
    ),
    GetPage(name: Routes.paymentMethod,
     page: ()=>const PaymentMethodScreen(),
     ),
     GetPage(name: Routes.favouriteList,
      page: ()=>const FavoriteListScreen()),
      GetPage(name: Routes.paymentsuccessfull,
       page: ()=>const PaymentSuccessfulScreen(),
       ),
        GetPage(name: Routes.chat,
       page: ()=>const  ChatScreen(),
       ),
      GetPage(
  name: Routes.chatdetail,
  page: () {
    final args = Get.arguments as Map<String, dynamic>? ?? {};
    return ChatDetailScreen(
      name: args['name'] as String? ?? '',
      status: args['status'] as String? ?? 'Active now',
      avatarPath: args['avatarPath'] as String?,
    );
  },
),
  ];
}