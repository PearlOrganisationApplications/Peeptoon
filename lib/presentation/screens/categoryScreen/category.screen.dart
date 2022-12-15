import 'package:flutter/material.dart';
import 'package:peerp_toon/presentation/screens/categoryScreen/widgets/category.widget.dart';
import 'package:provider/provider.dart';

import '../../../app/constants/app.assets.dart';
import '../../../app/constants/app.colors.dart';
import '../../../app/routes/app.routes.dart';
import '../../../core/notifiers/product.notifier.dart';
import '../../../core/notifiers/theme.notifier.dart';
import '../../widgets/custom.back.btn.dart';
import '../../widgets/custom.loader.dart';
import '../../widgets/custom.text.style.dart';
import '../../widgets/dimensions.widget.dart';
import '../../widgets/shimmer.effects.dart';

class CategoryScreen extends StatelessWidget {
  final CategoryScreenArgs categoryScreenArgs;

  const CategoryScreen({Key? key, required this.categoryScreenArgs})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeNotifier _themeNotifier = Provider.of<ThemeNotifier>(context);
    var themeFlag = _themeNotifier.darkTheme;
    return SafeArea(
      child: Scaffold(
        backgroundColor: themeFlag ? AppColors.mirage : AppColors.creamColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
              child: Row(
                children: [
                  CustomBackButton(
                    route: AppRouter.homeRoute,
                    themeFlag: themeFlag,
                  ),
                  Center(
                    child: Text(
                      categoryScreenArgs.categoryName,
                      style: CustomTextWidget.bodyTextB2(
                        color:
                            themeFlag ? AppColors.creamColor : AppColors.mirage,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            vSizedBox2,
            Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.85,
                  width: MediaQuery.of(context).size.width,
                  child: Consumer<ProductNotifier>(
                    builder: (context, notifier, _) {
                      return FutureBuilder(
                        future: notifier.fetchProductCategory(
                          context: context,
                          categoryName: categoryScreenArgs.categoryName,
                        ),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return ShimmerEffects.buildCategoryShimmer(
                                context: context);
                          } else if (!snapshot.hasData) {
                            return customLoader(
                              context: context,
                              themeFlag: themeFlag,
                              text: 'No Stock Available',
                              lottieAsset: AppAssets.error,
                            );
                          } else {
                            var _snapshot = snapshot.data as List;
                            return showDataInGrid(
                                height:
                                    MediaQuery.of(context).size.height * 0.20,
                                snapshot: _snapshot,
                                themeFlag: themeFlag,
                                context: context);
                          }
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryScreenArgs {
  final dynamic categoryName;
  const CategoryScreenArgs({required this.categoryName});
}
