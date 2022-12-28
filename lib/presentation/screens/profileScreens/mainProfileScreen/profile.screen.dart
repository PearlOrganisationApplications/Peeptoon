import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cache_manager/cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../../app/constants/app.colors.dart';
import '../../../../app/constants/app.keys.dart';
import '../../../../app/routes/app.routes.dart';
import '../../../../core/notifiers/theme.notifier.dart';
import '../../../../core/notifiers/user.notifier.dart';
import '../../../../core/utils/snackbar.util.dart';
import '../../../widgets/custom.back.btn.dart';
import '../../../widgets/custom.text.style.dart';
import '../../../widgets/dimensions.widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? image;

  String img = '';
  final _picker = ImagePicker();

  Future pickImage() async {
    final pickedImage = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxHeight: 500.0,
      maxWidth: 500.0,
    );

    if (pickedImage != null) {
      setState(() {
        image = File(pickedImage.path);
        Uint8List byts = File(pickedImage.path).readAsBytesSync();
        img = base64Encode(byts);
        print(img);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeNotifier _themeNotifier = Provider.of<ThemeNotifier>(context);
    var themeFlag = _themeNotifier.darkTheme;
    return SafeArea(
      child: Scaffold(
        backgroundColor: themeFlag ? AppColors.mirage : AppColors.creamColor,
        body: Column(
          children: [
            Row(
              children: [
                CustomBackButton(
                  route: AppRouter.homeRoute,
                  themeFlag: themeFlag,
                ),
                Text(
                  'Profile',
                  style: CustomTextWidget.bodyTextB2(
                    color: themeFlag ? AppColors.creamColor : AppColors.mirage,
                  ),
                ),
              ],
            ),
            vSizedBox1,
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _createAccountInformation(
                    context: context,
                    themeFlag: themeFlag,
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(AppRouter.editProfileRoute);
                    },
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(0, 18, 0, 18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Update Info',
                            style: TextStyle(
                              fontSize: 15,
                              color: themeFlag
                                  ? AppColors.creamColor
                                  : AppColors.mirage,
                            ),
                          ),
                          Icon(
                            Icons.chevron_right,
                            size: 20,
                            color: themeFlag
                                ? AppColors.creamColor
                                : AppColors.mirage,
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(AppRouter.changePassRoute);
                    },
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(0, 18, 0, 18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Change Password',
                            style: TextStyle(
                              fontSize: 15,
                              color: themeFlag
                                  ? AppColors.creamColor
                                  : AppColors.mirage,
                            ),
                          ),
                          Icon(
                            Icons.chevron_right,
                            size: 20,
                            color: themeFlag
                                ? AppColors.creamColor
                                : AppColors.mirage,
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(AppRouter.appSettingsRoute);
                    },
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(0, 18, 0, 18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Settings',
                            style: TextStyle(
                              fontSize: 15,
                              color: themeFlag
                                  ? AppColors.creamColor
                                  : AppColors.mirage,
                            ),
                          ),
                          Icon(
                            Icons.chevron_right,
                            size: 20,
                            color: themeFlag
                                ? AppColors.creamColor
                                : AppColors.mirage,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 18, 0, 0),
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        DeleteCache.deleteKey(AppKeys.userData)
                            .whenComplete(() {
                          Navigator.of(context)
                              .pushReplacementNamed(AppRouter.loginRoute);
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.power_settings_new,
                            size: 20,
                            color: themeFlag
                                ? AppColors.creamColor
                                : AppColors.mirage,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Sign Out',
                            style: TextStyle(
                              fontSize: 15,
                              color: themeFlag
                                  ? AppColors.creamColor
                                  : AppColors.mirage,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _createAccountInformation({
    required BuildContext context,
    required bool themeFlag,
  }) {
    final userNotifier = Provider.of<UserNotifier>(context, listen: false);
    var userName = userNotifier.getUserName ?? 'Wait';
    final double profilePictureSize = MediaQuery.of(context).size.width / 4;
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: profilePictureSize,
            height: profilePictureSize,
            child: GestureDetector(
              onTap: () {
                pickImage();
              },
              child: CircleAvatar(
                backgroundColor:
                    themeFlag ? AppColors.creamColor : AppColors.mirage,
                radius: profilePictureSize - 4,
                child: Hero(
                  tag: 'profilePicture',
                  child: ClipOval(
                      child: image == null
                          ? SvgPicture.network(
                              'https://avatars.dicebear.com/api/big-smile/$userName.svg',
                              semanticsLabel: 'A shark?!',
                              alignment: Alignment.center,
                            )
                          : Image.file(File(image!.path).absolute)),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userName,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: themeFlag ? AppColors.creamColor : AppColors.mirage,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                GestureDetector(
                  onTap: () {
                    if (userName == 'Wait') {
                      SnackUtil.stylishSnackBar(
                          text: 'Session Timeout', context: context);
                      Navigator.of(context)
                          .pushReplacementNamed(AppRouter.loginRoute);
                      DeleteCache.deleteKey(AppKeys.userData);
                    } else {
                      Navigator.of(context).pushNamed(AppRouter.accountInfo);
                    }
                  },
                  child: Row(
                    children: [
                      Text(
                        'Account Information',
                        style: TextStyle(
                          fontSize: 14,
                          color: themeFlag
                              ? AppColors.creamColor
                              : AppColors.mirage,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Icon(
                        Icons.chevron_right,
                        size: 20,
                        color:
                            themeFlag ? AppColors.creamColor : AppColors.mirage,
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
