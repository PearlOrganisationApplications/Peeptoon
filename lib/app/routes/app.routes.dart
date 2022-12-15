import 'package:concentric_transition/concentric_transition.dart';
import 'package:flutter/material.dart';

import '../../presentation/screens/cartScreen/cart.screen.dart';
import '../../presentation/screens/categoryScreen/category.screen.dart';
import '../../presentation/screens/homeScreen/home.screen.dart';
import '../../presentation/screens/loginScreen/login.view.dart';
import '../../presentation/screens/onBoardingScreen/onBoarding.screen.dart';
import '../../presentation/screens/productDetailScreen/product.detail.screen.dart';
import '../../presentation/screens/productScreen/product.screen.dart';
import '../../presentation/screens/profileScreens/accountInformationScreen/account.information.screen.dart';
import '../../presentation/screens/profileScreens/appSettingsScreen/app.setting.screen.dart';
import '../../presentation/screens/profileScreens/changePasswordScreen/change.password.screen.dart';
import '../../presentation/screens/profileScreens/editProfileScreen/edit.profile.screen.dart';
import '../../presentation/screens/profileScreens/mainProfileScreen/profile.screen.dart';
import '../../presentation/screens/searchScreen/search.screen.dart';
import '../../presentation/screens/signUpScreen/signup.screen.dart';
import '../../presentation/screens/splashScreen/splash.screen.dart';

class AppRouter {
  static const String splashRoute = "/splash";
  static const String onBoardRoute = "/onBoard";
  static const String productRoute = "/product";
  static const String loginRoute = "/login";
  static const String signUpRoute = "/signup";
  static const String appSettingsRoute = "/appSettings";
  static const String homeRoute = "/home";
  static const String cartRoute = "/cart";
  static const String searchRoute = "/search";
  static const String profileRoute = "/profile";
  static const String accountInfo = "/accountInfo";
  static const String categoryRoute = "/category";
  static const String prodDetailRoute = "/productDetail";
  static const String editProfileRoute = "/editProfile";
  static const String changePassRoute = "/changePassword";

  static Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case editProfileRoute:
        {
          return MaterialPageRoute(
            builder: (_) => EditProfileScreen(),
          );
        }
      case appSettingsRoute:
        {
          return MaterialPageRoute(
            builder: (_) => const AppSettings(),
          );
        }
      case homeRoute:
        {
          return MaterialPageRoute(
            builder: (_) => const HomeScreen(),
          );
        }
      case splashRoute:
        {
          return ConcentricPageRoute(
            fullscreenDialog: true,
            builder: (_) => const SplashScreen(),
          );
        }
      case onBoardRoute:
        {
          return MaterialPageRoute(
            builder: (_) => OnBoardingScreen(),
          );
        }
      case productRoute:
        {
          return MaterialPageRoute(
            builder: (_) => const ProductScreen(),
          );
        }
      case loginRoute:
        {
          return MaterialPageRoute(
            builder: (_) => LoginScreen(),
          );
        }
      case signUpRoute:
        {
          return MaterialPageRoute(
            builder: (_) => SignUpScreen(),
          );
        }
      case prodDetailRoute:
        {
          return MaterialPageRoute(
            builder: (context) => ProductDetail(
              productDetailsArguements: ModalRoute.of(context)!
                  .settings
                  .arguments as ProductDetailsArgs,
            ),
            settings: settings,
          );
        }
      case cartRoute:
        {
          return MaterialPageRoute(
            builder: (_) => const CartScreen(),
          );
        }
      case searchRoute:
        {
          return MaterialPageRoute(
            builder: (_) => const SearchScreen(),
          );
        }
      case profileRoute:
        {
          return MaterialPageRoute(
            builder: (_) => const ProfileScreen(),
          );
        }
      case categoryRoute:
        {
          return MaterialPageRoute(
            builder: (context) => CategoryScreen(
              categoryScreenArgs: ModalRoute.of(context)!.settings.arguments
                  as CategoryScreenArgs,
            ),
            settings: settings,
          );
        }
      case accountInfo:
        {
          return MaterialPageRoute(
            builder: (_) => const AccountInformationScreen(),
          );
        }
      case changePassRoute:
        {
          return MaterialPageRoute(
            builder: (_) => ChangePasswordScreen(),
          );
        }
    }
  }
}
