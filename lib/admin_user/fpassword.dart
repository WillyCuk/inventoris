
import 'package:atk_inventoris/notification/notif_service.dart';
import 'package:atk_inventoris/provider/user.dart';
import 'package:atk_inventoris/router/routernamed.dart';
import 'package:atk_inventoris/utils/forgot_pass_dialog.dart';
import 'package:atk_inventoris/utils/logo.dart';
import 'package:atk_inventoris/utils/mybutton.dart';
import 'package:atk_inventoris/utils/mysnackbar.dart';
import 'package:atk_inventoris/utils/mytextfield.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ForgotPage extends StatefulWidget {
  const ForgotPage({super.key});

  @override
  State<ForgotPage> createState() => _ForgotPageState();
}

class _ForgotPageState extends State<ForgotPage> {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    debugPrint(MediaQuery.sizeOf(context).toString());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * .1),
            const MyLogo(),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 70.0, vertical: 15.0),
              child: Divider(),
            ),
            Text(
              "Forgot Password",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold, fontSize: 26),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 15.0),
              child: Divider(),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 15, 0, 30),
              child: MyTextField(
                text: "Email",
                controller: _emailController,
                obscure: false,
              ),
            ),
            MyButton(
              text: "SUBMIT",
              onPressed: () async {
                String email = _emailController.text;
                FocusScope.of(context).unfocus();
                try {
                  int otp = await Provider.of<User>(context, listen: false)
                      .requestOTP(email);
                  NotificationService.showNotif("OTP", otp.toString());
                  if (context.mounted) {
                    await showDialog(
                        context: context,
                        builder: (context) {
                          return ForgotDialog(
                            otp: otp.toString(),
                            email: _emailController.text,
                          );
                        });
                    if (context.mounted) {
                      context.goNamed(RouterName.loginPageName);
                    }
                  }
                } catch (e) {
                  if (context.mounted) {
                    showSnackBar(context, e.toString());
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
