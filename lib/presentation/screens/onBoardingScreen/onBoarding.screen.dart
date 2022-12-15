import 'package:concentric_transition/concentric_transition.dart';
import 'package:flutter/material.dart';
import 'package:peerp_toon/presentation/screens/onBoardingScreen/widget/onBoarding.widget.dart';

import '../../../app/constants/app.assets.dart';
import '../../../app/constants/app.colors.dart';
import '../../../app/routes/app.routes.dart';
import '../../../core/models/onBoarding.model.dart';

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({Key? key}) : super(key: key);

  final List<OnBoardingModel> cards = [
    OnBoardingModel(
      image: AppAssets.onBoardingOne,
      title: "Artist ho kya?",
      textColor: Colors.white,
      bgColor: AppColors.mirage,
    ),
    OnBoardingModel(
      image: AppAssets.onBoardingTwo,
      title: "So, We Are Here To Support Your Skills.",
      bgColor: AppColors.creamColor,
      textColor: AppColors.mirage,
    ),
    OnBoardingModel(
      image: AppAssets.onBoardingThree,
      title: "Pay Us Through UPI Payment.",
      bgColor: AppColors.rawSienna,
      textColor: Colors.white,
    ),
  ];

  List<Color> get colors => cards.map((p) => p.bgColor).toList();

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConcentricPageView(
        colors: widget.colors,
        radius: 30,
        itemCount: 3,
        curve: Curves.ease,
        duration: const Duration(seconds: 2),
        itemBuilder: (int) {
          OnBoardingModel card = widget.cards[int % widget.cards.length];
          return PageCard(card: card);
        },
        onFinish: () {
          Navigator.of(context).pushReplacementNamed(AppRouter.splashRoute);
        },
      ),
    );
  }
}
