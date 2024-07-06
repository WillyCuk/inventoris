import 'package:atk_inventoris/provider/user.dart';
import 'package:atk_inventoris/router/routernamed.dart';
import 'package:atk_inventoris/utils/logo.dart';
import 'package:atk_inventoris/utils/mybutton.dart';
import 'package:atk_inventoris/utils/textformfield.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  bool toggleHiddenPass = true;
  bool toggleHiddenCPass = true;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController cPassController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * .1),
              const MyLogo(),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * .125,
                    vertical: 5.0),
                child: const Divider(),
              ),
              Text(
                "Register Account",
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold, fontSize: 26),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * .1,
                    vertical: 5.0),
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
                        controller: nameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Username must be filled';
                          }
                          return null;
                        },
                        labelText: "Full Name (Username)"),
                    const SizedBox(height: 20),
                    MyTextFormField(
                        prefixIcon: const Icon(Icons.mail),
                        suffixIcon: null,
                        obscureText: false,
                        controller: emailController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Email must be filled';
                          }
                          bool emailValid = RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value);
                          if (!emailValid) {
                            return 'Enter Valid Email';
                          }
                          return null;
                        },
                        labelText: "Email"),
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
                          } else if (passController.text.length < 8) {
                            return "Password length should not below 8";
                          }
                          return null;
                        },
                        labelText: "Password"),
                    const SizedBox(height: 20),
                    MyTextFormField(
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              toggleHiddenCPass = !toggleHiddenCPass;
                            });
                          },
                          child: Icon(
                            toggleHiddenCPass
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.blueGrey,
                          ),
                        ),
                        obscureText: toggleHiddenCPass,
                        controller: cPassController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'password must be filled';
                          } else if (passController.text !=
                              cPassController.text) {
                            return "Your password and confirm password must match";
                          }
                          return null;
                        },
                        labelText: "Re-Password"),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              MyButton(
                text: "Register",
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    try {
                      Provider.of<User>(context, listen: false).addUser(
                        username: nameController.text,
                        password: passController.text,
                        email: emailController.text,
                      );
                      context.goNamed(RouterName.loginPageName);
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
                  }
                },
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 60.0, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: GoogleFonts.dmSans(
                          fontWeight: FontWeight.w300,
                          letterSpacing: -1,
                          fontSize: 20,
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    const SizedBox(width: 20),
                    GestureDetector(
                      onTap: () {
                        context.pushNamed(RouterName.loginPageName);
                      },
                      child: Text(
                        "Login",
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
            ],
          ),
        ),
      ),
    );
  }
}
