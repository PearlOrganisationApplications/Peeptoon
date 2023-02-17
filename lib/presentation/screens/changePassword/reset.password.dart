import 'package:cache_manager/cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:peerp_toon/app/constants/app.keys.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app/constants/app.colors.dart';
import '../../../core/notifiers/authentication.notifer.dart';
import '../../../core/notifiers/theme.notifier.dart';
import '../../widgets/custom.text.field.dart';
import '../../widgets/dimensions.widget.dart';
import 'Widgets/reset.password.widget.dart';

// bool isEmail(String input) => EmailValidator.validate(input);
//
// bool isPhone(String input) =>
//     RegExp(r'^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$')
//         .hasMatch(input);

class ResetPasswordScreen extends StatefulWidget {
  ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  // final TextEditingController userPhoneController = TextEditingController();
  final TextEditingController userEmailPhoneController =
      TextEditingController();

  final TextEditingController changePassController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  // @override
  // void initState() {
  //   final userTokenVerified = Provider.of<UserNotifier>( context,listen: false);
  //   ReadCache.getString(key: AppKeys.userVerifiedToken).then(
  //         (token) =>
  //     {userTokenVerified.getUserData(context: context, token: token)},
  //   );
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {
    _resetPassword() async{
      SharedPreferences preferences = await SharedPreferences.getInstance();
    var  token= preferences.getString(AppKeys.userVerifiedToken).toString();
      print(token);

      // print(userPassUpdate);
      if (_formKey.currentState!.validate()) {
        var authNotifier =
            Provider.of<AuthenticationNotifier>(context, listen: false);
        authNotifier.passwordChange(
          context: context,
          password: changePassController.text,
          token: preferences.getString(AppKeys.userVerifiedToken).toString(),

        );
        // print($)
      }
    }

    ThemeNotifier _themeNotifier = Provider.of<ThemeNotifier>(context);
    var themeFlag = _themeNotifier.darkTheme;
    return SafeArea(
      child: Scaffold(
        backgroundColor: themeFlag ? AppColors.mirage : AppColors.creamColor,
        resizeToAvoidBottomInset: false,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            changePasswordTextField(themeFlag: themeFlag),
            vSizedBox2,
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // Padding(
                        //   padding:
                        //   const EdgeInsets.fromLTRB(35.0, 0.0, 35.0, 2.0),
                        //   child: CustomTextField.customTextField(
                        //     textEditingController: userEmailPhoneController,
                        //     hintText: 'Enter an email/number',
                        //     validator: (val) =>
                        //     !RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                        //         .hasMatch(val!)
                        //         ? 'Enter an email/number'
                        //         : null,
                        //   ),
                        // ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(35.0, 0.0, 35.0, 2.0),
                          child: CustomTextField.customTextField(
                            textEditingController: changePassController,
                            hintText: 'Enter a password',
                            validator: (val) =>
                                val!.isEmpty ? 'Enter a password' : null,
                          ),
                        ),
                        vSizedBox1,
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(35.0, 0.0, 35.0, 2.0),
                          child: CustomTextField.customTextField(
                            textEditingController: changePassController,
                            hintText: 'Re-Enter a password',
                            validator: (val) =>
                                val!.isEmpty ? 'Re-Enter a password' : null,
                          ),
                        ),
                      ],
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
                      _resetPassword();
                      // widget.key;
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => HomeScreen()));
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
            ),
          ],
        ),
      ),
    );
  }
}
