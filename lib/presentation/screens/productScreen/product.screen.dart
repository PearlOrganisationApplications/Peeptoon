import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:peerp_toon/presentation/screens/cartScreen/cart.screen.dart';
import 'package:peerp_toon/presentation/screens/productScreen/widgets/brands.widget.dart';
import 'package:peerp_toon/presentation/screens/productScreen/widgets/recommended.widget.dart';
import 'package:provider/provider.dart';

import '../../../app/constants/app.assets.dart';
import '../../../app/constants/app.colors.dart';
import '../../../core/notifiers/product.notifier.dart';
import '../../../core/notifiers/theme.notifier.dart';
import '../../../core/notifiers/user.notifier.dart';
import '../../widgets/custom.text.style.dart';
import '../../widgets/dimensions.widget.dart';
import '../../widgets/shimmer.effects.dart';
import '../profileScreens/mainProfileScreen/profile.screen.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeNotifier _themeNotifier = Provider.of<ThemeNotifier>(context);
    var themeFlag = _themeNotifier.darkTheme;

    UserNotifier _userData = Provider.of<UserNotifier>(context);
    var userName = _userData.getUserName ?? ' ';
    return SafeArea(
      child: Scaffold(
        backgroundColor: themeFlag ? AppColors.mirage : AppColors.creamColor,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: themeFlag ? AppColors.mirage : AppColors.creamColor,
          iconTheme: IconThemeData(
              color: themeFlag ? AppColors.creamColor : AppColors.mirage),
        ),
        drawer: Drawer(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20))),
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const DrawerHeader(
                decoration: BoxDecoration(color: Colors.black38),
                child: Text("Peeptoon"),
              ),
              ListTile(
                leading: const Icon(Icons.account_circle_rounded),
                title: const Text('Profile '),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfileScreen()));
                },
              ),
              ListTile(
                leading: const Icon(
                  EvaIcons.shoppingCart,
                ),
                title: const Text('Cart'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CartScreen()));
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.monetization_on,
                ),
                title: const Text('Pricing'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.note_alt_rounded,
                ),
                title: const Text('Blog'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.telegram,
                ),
                title: const Text('Contact Us'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Column(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hi , $userName',
                      style: CustomTextWidget.bodyTextB1(
                        color:
                            themeFlag ? AppColors.creamColor : AppColors.mirage,
                      ),
                    ),
                    vSizedBox1,
                    Text(
                      'What Would You Like To Draw Today ??',
                      style: CustomTextWidget.bodyText3(
                        color:
                            themeFlag ? AppColors.creamColor : AppColors.mirage,
                      ),
                    ),
                    vSizedBox2,
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            AppColors.rawSienna,
                            AppColors.mediumPurple,
                            AppColors.fuchsiaPink,
                          ],
                        ),
                      ),
                      height: MediaQuery.of(context).size.height * 0.20,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 10, 5, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'A great deal of art is created ',
                              style: CustomTextWidget.bodyTextB2(
                                  color: AppColors.creamColor),
                            ),
                            Text(
                              'With our products',
                              style: CustomTextWidget.bodyTextB3(
                                  color: AppColors.creamColor),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.creamColor,
                                    enableFeedback: true,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 2,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: Text(
                                    'Check',
                                    style: CustomTextWidget.bodyText3(
                                      color: AppColors.mirage,
                                    ),
                                  ),
                                ),
                                hSizedBox2,
                                SizedBox(
                                  height: 80,
                                  width: 110,
                                  child: Image.asset(AppAssets.homeJordan),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    vSizedBox2,
                    const BrandWidget(),
                    vSizedBox2,
                    Text(
                      'Exclusive Product',
                      style: CustomTextWidget.bodyTextB2(
                        color:
                            themeFlag ? AppColors.creamColor : AppColors.mirage,
                      ),
                    ),
                    vSizedBox1,
                    SizedBox(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      child: Consumer<ProductNotifier>(
                        builder: (context, notifier, _) {
                          return FutureBuilder(
                            future: notifier.fetchProducts(context: context),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return ShimmerEffects.loadShimmer(
                                    context: context);
                              } else if (!snapshot.hasData) {
                                return Center(
                                  child: Text(
                                    'Some Error Occurred...',
                                    style: CustomTextWidget.bodyTextUltra(
                                      color: themeFlag
                                          ? AppColors.creamColor
                                          : AppColors.mirage,
                                    ),
                                  ),
                                );
                              } else {
                                var _snapshot = snapshot.data as List;
                                return productForYou(
                                  snapshot: _snapshot,
                                  themeFlag: themeFlag,
                                  context: context,
                                );
                              }
                            },
                          );
                        },
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
