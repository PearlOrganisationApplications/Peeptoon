import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';

import 'package:provider/provider.dart';

import '../../../app/constants/app.colors.dart';
import '../../../app/routes/app.routes.dart';
import '../../../core/notifiers/authentication.notifer.dart';
import '../../../core/notifiers/theme.notifier.dart';
import '../../widgets/custom.animated.container.dart';
import '../../widgets/custom.text.field.dart';
import '../../widgets/dimensions.widget.dart';

import '../signUpScreen/widget/welcome.signup.widget.dart';

class SellerScreen extends StatefulWidget {
  const SellerScreen({Key? key}) : super(key: key);

  @override
  State<SellerScreen> createState() => _SellerScreenState();
}

TextEditingController _companyName = TextEditingController();

class _SellerScreenState extends State<SellerScreen> {
  OtpFieldController otpController = OtpFieldController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ThemeNotifier _themeNotifier = Provider.of<ThemeNotifier>(context);
    var themeFlag = _themeNotifier.darkTheme;

    return SafeArea(
      child: Scaffold(
        backgroundColor: themeFlag ? AppColors.mirage : AppColors.creamColor,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              welcomeSellerText(themeFlag: themeFlag),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                                35.0, 10.0, 35.0, 2.0),
                            child: CustomTextField.customTextField(
                                textEditingController: _companyName,
                                hintText: 'Enter Business Name',
                                validator: (val) => val!.isEmpty
                                    ? 'Enter Business Name'
                                    : null),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                                35.0, 10.0, 35.0, 2.0),
                            child: CustomTextField.customTextField(
                              textEditingController: _companyName,
                              hintText: 'Product Name',
                              validator: (val) =>
                                  val!.isEmpty ? 'Enter an product name' : null,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                                35.0, 10.0, 35.0, 2.0),
                            child: CustomTextField.customTextField(
                                // onChanged: (val) {
                                //   authNotifier(false)
                                //       .checkPasswordStrength(password: val);
                                // },
                                textEditingController: _companyName,
                                hintText: 'Enter a Phone number',
                                maxLength: 10,
                                validator: (value) {
                                  String patttern =
                                      r'(^(?:[+0]9)?[0-9]{10,12}$)';
                                  RegExp regExp = new RegExp(patttern);
                                  if (value?.length == 0) {
                                    return 'Please enter mobile number';
                                  } else if (!regExp.hasMatch(value!)) {
                                    return 'Please enter valid mobile number';
                                  }
                                  return null;
                                }

                                // validateMobile(val!);
                                // val!.isEmpty ? 'Enter a phone number' : null,
                                ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                                35.0, 10.0, 35.0, 2.0),
                            child: CustomTextField.customTextField(
                              // onChanged: (val) {
                              //   authNotifier(false)
                              //       .checkPasswordStrength(password: val);
                              // },
                              textEditingController: _companyName,
                              hintText: 'Product Price',
                              validator: (val) => val!.isEmpty
                                  ? 'Enter your poduct price'
                                  : null,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                                35.0, 10.0, 35.0, 2.0),
                            child: CustomTextField.customTextField(
                              // onChanged: (val) {
                              //   authNotifier(false)
                              //       .checkPasswordStrength(password: val);
                              // },
                              textEditingController: _companyName,
                              hintText: 'About Product',
                              validator: (val) =>
                                  val!.isEmpty ? 'About Product' : null,
                            ),
                          ),
                        ],
                      ),
                    ),
                    vSizedBox1,
                    MaterialButton(
                      height: MediaQuery.of(context).size.height * 0.05,
                      minWidth: MediaQuery.of(context).size.width * 0.8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      onPressed: () async {
                        print("Seller Screen");
                      },
                      color: AppColors.rawSienna,
                      child: const Text(
                        'Submit',
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
      ),
    );
  }
}
