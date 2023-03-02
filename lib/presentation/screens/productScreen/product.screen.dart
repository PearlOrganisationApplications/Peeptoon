import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:peerp_toon/core/models/userDetails.model.dart';
import 'package:peerp_toon/presentation/screens/cartScreen/cart.screen.dart';
import 'package:peerp_toon/presentation/screens/productScreen/widgets/brands.widget.dart';
import 'package:peerp_toon/presentation/screens/productScreen/widgets/recommended.widget.dart';
import 'package:peerp_toon/presentation/screens/sellerScreen/seller.screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app/constants/app.assets.dart';
import '../../../app/constants/app.colors.dart';
import '../../../app/constants/app.keys.dart';
import '../../../core/api/user.api.dart';
import '../../../core/notifiers/product.notifier.dart';
import '../../../core/notifiers/theme.notifier.dart';
import '../../widgets/custom.text.style.dart';
import '../../widgets/dimensions.widget.dart';
import '../../widgets/shimmer.effects.dart';
import '../profileScreens/mainProfileScreen/profile.screen.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  String token = AppKeys.userData;

  void getInfo() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      token = pref.getString(AppKeys.userData)!;
    });
  }

  void initState() {
    getInfo();
    UserAPI.getUserUpdateDetaile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeNotifier _themeNotifier = Provider.of<ThemeNotifier>(context);
    var themeFlag = _themeNotifier.darkTheme;

    return SafeArea(
        child: Scaffold(
            backgroundColor:
                themeFlag ? AppColors.mirage : AppColors.creamColor,
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor:
                  themeFlag ? AppColors.mirage : AppColors.creamColor,
              iconTheme: IconThemeData(
                  color: themeFlag ? AppColors.creamColor : AppColors.mirage),
            ),
            drawer: Drawer(
              backgroundColor:
                  themeFlag ? AppColors.mirage : AppColors.creamColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    decoration: BoxDecoration(
                        color: themeFlag
                            ? AppColors.mirage
                            : AppColors.creamColor),
                    child: Text("Peeptoon"),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.account_circle_rounded,
                      color:
                          themeFlag ? AppColors.creamColor : AppColors.mirage,
                    ),
                    title: const Text('Profile '),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ProfileScreen()));
                    },
                  ),
                  ListTile(
                    leading: Icon(EvaIcons.shoppingCart,
                        color: themeFlag
                            ? AppColors.creamColor
                            : AppColors.mirage),
                    title: Text(
                      'Cart',
                      style: TextStyle(
                          color: themeFlag
                              ? AppColors.creamColor
                              : AppColors.mirage),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CartScreen()));
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.note_alt_rounded,
                      color:
                          themeFlag ? AppColors.creamColor : AppColors.mirage,
                    ),
                    title: Text('Blog',
                        style: TextStyle(
                            color: themeFlag
                                ? AppColors.creamColor
                                : AppColors.mirage)),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.sell,
                      color:
                          themeFlag ? AppColors.creamColor : AppColors.mirage,
                    ),
                    title: Text('Become Seller',
                        style: TextStyle(
                            color: themeFlag
                                ? AppColors.creamColor
                                : AppColors.mirage)),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SellerScreen()));
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.telegram,
                      color:
                          themeFlag ? AppColors.creamColor : AppColors.mirage,
                    ),
                    title: Text('Contact Us',
                        style: TextStyle(
                            color: themeFlag
                                ? AppColors.creamColor
                                : AppColors.mirage)),
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
                          "Hello!",
                          // 'Hi , ${snapshot.data!.name}',
                          style: CustomTextWidget.bodyTextB1(
                            color: themeFlag
                                ? AppColors.creamColor
                                : AppColors.mirage,
                          ),
                        ),
                        vSizedBox1,
                        Text(
                          'What Would You Like To Draw Today ??',
                          style: CustomTextWidget.bodyText3(
                            color: themeFlag
                                ? AppColors.creamColor
                                : AppColors.mirage,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                          borderRadius:
                                              BorderRadius.circular(5.0),
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
                            color: themeFlag
                                ? AppColors.creamColor
                                : AppColors.mirage,
                          ),
                        ),
                        vSizedBox1,
                        SizedBox(
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          child: Consumer<ProductNotifier>(
                            builder: (context, notifier, _) {
                              return FutureBuilder(
                                future:
                                    notifier.fetchProducts(context: context),
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
            )));
  }
}
