import 'package:atk_inventoris/utils/mybutton.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../provider/user.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _isEditName = false;
  bool _isEditEmail = false;

  @override
  void initState() {
    super.initState();
    final user = Provider.of<User>(context, listen: false);
    _nameController.text = user.user;
    _emailController.text = user.email;
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 50,
                  child: Icon(
                    Icons.person_2,
                    size: 48,
                  ),
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      _nameController.text,
                      style: GoogleFonts.quicksand(
                          fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                    Text(
                      _emailController.text,
                      style: GoogleFonts.quicksand(fontSize: 14),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 30),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        borderRadius: BorderRadius.circular(15)),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Name',
                              style: GoogleFonts.quicksand(),
                            ),
                            SizedBox(
                              width: 350,
                              child: TextFormField(
                                enabled: _isEditName,
                                controller: _nameController,
                                style: GoogleFonts.quicksand(fontSize: 18),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  isDense: true,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your name';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        TextButton(
                            onPressed: () {
                              setState(() {
                                _isEditName = !_isEditName;
                              });
                            },
                            child: Text(
                              "Edit",
                              style: GoogleFonts.poppins(fontSize: 18),
                            ))
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        borderRadius: BorderRadius.circular(15)),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Email',
                              style: GoogleFonts.quicksand(),
                            ),
                            SizedBox(
                              width: 350,
                              child: TextFormField(
                                enabled: _isEditEmail,
                                controller: _emailController,
                                style: GoogleFonts.quicksand(fontSize: 18),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  isDense: true,
                                ),
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
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        TextButton(
                            onPressed: () {
                              setState(() {
                                _isEditEmail = !_isEditEmail;
                              });
                            },
                            child: Text(
                              "Edit",
                              style: GoogleFonts.poppins(fontSize: 18),
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            _isEditEmail || _isEditName
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyButton(
                        text: "CONFIRM",
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            user.changeUserEmail(
                                id: user.id,
                                name: _nameController.text,
                                email: _emailController.text);
                            _isEditEmail = false;
                            _isEditName = false;
                          }
                        },
                      ),
                      const SizedBox(width: 10),
                      MyButton(
                        text: "BACK",
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                    ],
                  )
                : SizedBox(
                    width: double.infinity,
                    child: MyButton(
                      text: "BACK",
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
