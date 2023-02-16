import 'package:flutter/material.dart';

import '../../../../app/constants/app.colors.dart';
import '../../../../app/constants/app.fonts.dart';
import '../../../widgets/dimensions.widget.dart';

Widget changePasswordTextField({required bool themeFlag}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      vSizedBox5,
      vSizedBox1,
      Padding(
        padding: const EdgeInsets.fromLTRB(35.0, 10.0, 35.0, 2.0),
        child: RichText(
          text: TextSpan(
            text: 'Please Create ',
            style: TextStyle(
              color: themeFlag ? AppColors.creamColor : AppColors.mirage,
              fontWeight: FontWeight.w900,
              fontFamily: AppFonts.contax,
              fontSize: 40.0,
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(35.0, 0.0, 35.0, 2.0),
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                children: [
                  TextSpan(
                    text: 'New Password ',
                    style: TextStyle(
                      color:
                      themeFlag ? AppColors.creamColor : AppColors.mirage,
                      fontWeight: FontWeight.w300,
                      fontSize: 28.0,
                      fontFamily: AppFonts.contax,
                    ),
                  ),
                  TextSpan(
                    text: 'That ',
                    style: TextStyle(
                      color:
                      themeFlag ? AppColors.creamColor : AppColors.mirage,
                      fontSize: 28.0,
                      fontFamily: AppFonts.contax,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  TextSpan(
                    text: 'You Can Remember!🤫',
                    style: TextStyle(
                      color:
                      themeFlag ? AppColors.creamColor : AppColors.mirage,
                      fontSize: 28.0,
                      fontFamily: AppFonts.contax,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      vSizedBox2,
      // Padding(
      //   padding: const EdgeInsets.fromLTRB(35.0, 0.0, 35.0, 2.0),
      //   child: RichText(
      //     text: TextSpan(
      //       children: [
      //         TextSpan(
      //           children: [
      //             TextSpan(
      //               text: 'Log In To ',
      //               style: TextStyle(
      //                 color:
      //                 themeFlag ? AppColors.creamColor : AppColors.mirage,
      //                 fontWeight: FontWeight.w500,
      //                 fontSize: 12.0,
      //               ),
      //             ),
      //             TextSpan(
      //               text: 'Your ',
      //               style: TextStyle(
      //                 color:
      //                 themeFlag ? AppColors.creamColor : AppColors.mirage,
      //                 fontSize: 12.0,
      //                 fontWeight: FontWeight.w500,
      //               ),
      //             ),
      //             TextSpan(
      //               text: 'Account Right Now ! ',
      //               style: TextStyle(
      //                 color:
      //                 themeFlag ? AppColors.creamColor : AppColors.mirage,
      //                 fontSize: 12.0,
      //                 fontWeight: FontWeight.w500,
      //               ),
      //             ),
      //           ],
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    ],
  );
}
