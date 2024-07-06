

import "package:atk_inventoris/provider/user.dart";
import "package:atk_inventoris/utils/mypagebutton.dart";
import "package:atk_inventoris/utils/textformfield%20copy.dart";
import "package:flutter/material.dart";

import "package:provider/provider.dart";

class ForgotDialog extends StatefulWidget {
  final String otp;
  final String email;

  const ForgotDialog({
    super.key,
    required this.otp,
    required this.email,
  });

  @override
  State<ForgotDialog> createState() => _ForgotDialogState();
}

class _ForgotDialogState extends State<ForgotDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController otpController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  bool toggleHiddenPass = true;

  @override
  Widget build(BuildContext context) {
    debugPrint(MediaQuery.sizeOf(context).toString());
    return Form(
      key: _formKey,
      child: AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.background,
        content: SizedBox(
          height: MediaQuery.sizeOf(context).height * .25,
          width: MediaQuery.sizeOf(context).width * .8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Bagian Form Field <<
              MyTextFormField(
                controller: otpController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'OTP must be filled';
                  } else if (otpController.text != widget.otp) {
                    debugPrint(otpController.text);
                    return "OTP Don't match";
                  }
                  return null;
                },
                labelText: "OTP Code",
                prefixIcon: null,
                suffixIcon: null,
                obscureText: false,
              ),
              MyTextFormField(
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        toggleHiddenPass = !toggleHiddenPass;
                      });
                    },
                    child: Icon(
                      toggleHiddenPass
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.blueGrey,
                    ),
                  ),
                  obscureText: toggleHiddenPass,
                  controller: passController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'password must be filled';
                    } else if (passController.text.length < 8) {
                      return "Password length should not below 8";
                    }
                    return null;
                  },
                  labelText: "Password"),
              // Bagian Form Field >>
              // Bagian Button <<
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MyPageButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    text: "CANCEL",
                    width: MediaQuery.sizeOf(context).width * .3,
                    height: 50,
                  ),
                  MyPageButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        try {
                          Provider.of<User>(context, listen: false)
                              .changePass(widget.email, passController.text);
                          // context.goNamed(RouterName.loginPageName);
                          Navigator.pop(context);
                        } catch (e) {
                          String errorMessage =
                              e.toString().split(':').last.trim();
                          debugPrint(errorMessage);

                          return;
                        }
                      }
                    },
                    text: "SAVE",
                    width: MediaQuery.sizeOf(context).width * .3,
                    height: 50,
                  ),
                ],
              )
              // Bagian Button >>
            ],
          ),
        ),
      ),
    );
  }
}
