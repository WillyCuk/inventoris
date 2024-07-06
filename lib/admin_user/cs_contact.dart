import 'package:atk_inventoris/provider/complaints.dart';
import 'package:atk_inventoris/provider/user.dart';
import 'package:atk_inventoris/utils/mybutton.dart';
import 'package:atk_inventoris/utils/success_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CSContact extends StatefulWidget {
  const CSContact({super.key});

  @override
  State<CSContact> createState() => _CSContactState();
}

class _CSContactState extends State<CSContact> {
  @override
  Widget build(BuildContext context) {
    final complaintProvider = Provider.of<CustomerComplaint>(context);
    final user = Provider.of<User>(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(title: const Text("CS Contact")),
        body: Container(
          padding: const EdgeInsets.all(20.0),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Text(
                            "Contact Person",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(children: [
                            const Icon(Icons.phone),
                            Text(
                              ' 08123456789 - Cecilia',
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  color: Theme.of(context).colorScheme.primary),
                            )
                          ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(children: [
                            const Icon(Icons.phone),
                            Text(
                              ' 0824572190 - Jason Wilbert',
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  color: Theme.of(context).colorScheme.primary),
                            )
                          ]),
                        ),
                        const Divider(),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: Text(
                                  "Complain Section",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                ),
                              ),
                              // make an input field for complain
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: TextField(
                                  controller:
                                      complaintProvider.complaintController,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 7,
                                  minLines: 4,
                                  decoration: InputDecoration(
                                    labelText: 'What\'s your problem?',
                                    labelStyle: GoogleFonts.poppins(
                                        fontSize: 16,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'This complain message will be processed by our customer service, please rest assured',
                                      style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'For your information, you can contact our Customer Service',
                                      style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                MyButton(
                  text: 'Submit',
                  onPressed: () {
                    complaintProvider.setUserEmail(user.user, user.email);
                    complaintProvider.addComplaint();
                    showSuccessDialog(
                        context: context,
                        msg:
                            'Your complaint has been submitted successfully. Please wait for our response and we will get back to you.');
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
