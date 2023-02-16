import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:peerp_toon/presentation/screens/optScreen/Widget/otp.verification.widget.dart';
import 'package:provider/provider.dart';

import '../../../app/constants/app.colors.dart';
import '../../../core/notifiers/authentication.notifer.dart';
import '../../../core/notifiers/theme.notifier.dart';
import '../../widgets/dimensions.widget.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({Key? key}) : super(key: key);

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  OtpFieldController otpController = OtpFieldController();
  final _formKey = GlobalKey<FormState>();
  var otp = "";

  @override
  // void initState() {
  //   final userTokenVerified = Provider.of<UserNotifier>(context, listen: false);
  //   ReadCache.getString(key: AppKeys.userVerifiedToken).then(
  //         (token) =>
  //     {userTokenVerified.getUserData(context: context, token: token)},
  //   );
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    _confirmOTPPassword({required otp}) {
      if (_formKey.currentState!.validate()) {
        var authNotifier =
            Provider.of<AuthenticationNotifier>(context, listen: false);
        authNotifier.verifyOTP(context: context, otp: otp);
      }
    }

    ThemeNotifier _themeNotifier = Provider.of<ThemeNotifier>(context);
    var themeFlag = _themeNotifier.darkTheme;
    return Scaffold(
      backgroundColor: themeFlag ? AppColors.mirage : AppColors.creamColor,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: <Widget>[
          otpVerificationText(themeFlag: themeFlag),
          vSizedBox2,
          Form(
            key: _formKey,
            child: OTPTextField(
              controller: otpController,
              length: 4,
              width: MediaQuery.of(context).size.width / 1.5,
              textFieldAlignment: MainAxisAlignment.spaceAround,
              fieldWidth: 45,
              fieldStyle: FieldStyle.underline,
              outlineBorderRadius: 20,
              style: TextStyle(fontSize: 17),
              onChanged: (pin) {
                otp = pin;
              },
              onCompleted: (pin) {
                print("Completed: " + pin);
              },
            ),
          ),
          vSizedBox2,
          MaterialButton(
            height: MediaQuery.of(context).size.height * 0.05,
            minWidth: MediaQuery.of(context).size.width * 0.8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            onPressed: () async {
              _confirmOTPPassword(otp: otp,);
            },
            color: AppColors.rawSienna,
            child: const Text(
              'SUBMIT',
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
