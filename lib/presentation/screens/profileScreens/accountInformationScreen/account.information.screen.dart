import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:peerp_toon/app/constants/app.keys.dart';
import 'package:peerp_toon/core/api/user.api.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../app/constants/app.colors.dart';
import '../../../../core/models/userDetails.model.dart';
import '../../../../core/notifiers/theme.notifier.dart';
import '../../../../core/notifiers/user.notifier.dart';
import '../../../widgets/custom.back.btn.dart';
import '../../../widgets/custom.text.style.dart';

class AccountInformationScreen extends StatefulWidget {
  const AccountInformationScreen({Key? key}) : super(key: key);

  @override
  State<AccountInformationScreen> createState() =>
      _AccountInformationScreenState();
}

class _AccountInformationScreenState extends State<AccountInformationScreen> {
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
    final double profilePictureSize = MediaQuery.of(context).size.width / 3;

    return SafeArea(
      child: Scaffold(
        backgroundColor: themeFlag ? AppColors.mirage : AppColors.creamColor,
        body: Container(
          margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: SingleChildScrollView(
            child: Consumer<UserNotifier>(
              builder: (context, notifier, _) {
                return FutureBuilder<GetUserUpdateDetaile?>(
                  future: UserAPI.getUserUpdateDetaile(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CustomBackPop(themeFlag: themeFlag),
                              Text(
                                'User Profile',
                                style: CustomTextWidget.bodyTextB2(
                                  color: themeFlag
                                      ? AppColors.creamColor
                                      : AppColors.mirage,
                                ),
                              ),
                            ],
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              margin: const EdgeInsets.only(top: 40),
                              width: profilePictureSize,
                              height: profilePictureSize,
                              child: CircleAvatar(
                                backgroundColor: themeFlag
                                    ? AppColors.creamColor
                                    : AppColors.mirage,
                                radius: (profilePictureSize),
                                child: Hero(
                                  tag: 'profilePicture',
                                  child: ClipOval(
                                    child: SvgPicture.network(
                                      'https://avatars.dicebear.com/api/big-smile/${snapshot.data!.name}.svg',
                                      semanticsLabel: 'A shark?!',
                                      alignment: Alignment.center,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 40),
                          Text(
                            "Name",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            snapshot.data!.name,
                            style: TextStyle(
                              color: themeFlag
                                  ? AppColors.creamColor
                                  : AppColors.mirage,
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Text(
                            "Email",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            snapshot.data!.email,
                            style: TextStyle(
                              color: themeFlag
                                  ? AppColors.creamColor
                                  : AppColors.mirage,
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Text(
                            "Address",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            snapshot.data!.address,
                            style: TextStyle(
                              color: themeFlag
                                  ? AppColors.creamColor
                                  : AppColors.mirage,
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          const Text(
                            'Phone',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            snapshot.data!.contactNo,
                            style: TextStyle(
                              color: themeFlag
                                  ? AppColors.creamColor
                                  : AppColors.mirage,
                            ),
                          ),
                        ],
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
