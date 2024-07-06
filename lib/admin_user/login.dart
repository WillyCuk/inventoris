import 'package:atk_inventoris/provider/maintenance.dart';
import 'package:atk_inventoris/provider/user.dart';
import 'package:atk_inventoris/router/routernamed.dart';
import 'package:atk_inventoris/utils/logo.dart';
import 'package:atk_inventoris/utils/mybutton.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../utils/textformfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool toggleHiddenPass = true;
  TextEditingController userController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userProvider = context.read<User>();
    final csProvider = context.read<MaintenanceProvider>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * .1),
            const MyLogo(),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * .125,
                  vertical: 15.0),
              child: const Divider(),
            ),
            Text(
              "Login Account",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                  color: Theme.of(context).colorScheme.primary),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * .1,
                  vertical: 15.0),
              child: const Divider(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * .125),
              child: Column(
                children: [
                  MyTextFormField(
                      prefixIcon: const Icon(Icons.person),
                      suffixIcon: null,
                      obscureText: false,
                      controller: userController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Username must be filled';
                        }
                        return null;
                      },
                      labelText: "Full Name (Username)"),
                  const SizedBox(height: 20),
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
                        }
                        return null;
                      },
                      labelText: "Password"),
                ],
              ),
            ),
            const SizedBox(height: 20),
            MyButton(
                text: "LOGIN",
                onPressed: () {
                  try {
                    userProvider.login(
                        user: userController.text, pwd: passController.text);
                    if (!csProvider.isMaintenance &&
                        userProvider.isLogin &&
                        userProvider.role == "admin") {
                      context.goNamed(RouterName.dashboardAdminPage);
                    } else if (!csProvider.isMaintenance &&
                        userProvider.isLogin &&
                        userProvider.role == "user") {
                      context.goNamed(RouterName.dashboardUserPage);
                    } else if (userProvider.isLogin &&
                        userProvider.role == "cs") {
                      // context.goNamed(RouterName.custServiceFrontPage);
                    } else {
                      context.goNamed(RouterName.maintenancePage);
                    }
                  } catch (e) {
                    String errorMessage = e.toString().split(':').last.trim();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        backgroundColor:
                            Theme.of(context).colorScheme.primaryContainer,
                        content: Text(errorMessage,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).colorScheme.primary,
                            )),
                        duration: const Duration(seconds: 1),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                    return;
                  }
                }),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.12,
                  vertical: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account yet?",
                    style: GoogleFonts.dmSans(
                        fontWeight: FontWeight.w300,
                        letterSpacing: -1,
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      context.goNamed(RouterName.registerPageName);
                    },
                    child: Text(
                      "Register",
                      style: GoogleFonts.dmSans(
                          fontWeight: FontWeight.w400,
                          letterSpacing: -1,
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                context.pushNamed(RouterName.forgotPassPage);
              },
              child: Text(
                "Forgot Password ?",
                style: GoogleFonts.dmSans(
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.primary,
                    letterSpacing: -1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
