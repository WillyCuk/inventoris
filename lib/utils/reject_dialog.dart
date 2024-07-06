
import "package:atk_inventoris/utils/mypagebutton.dart";
import "package:atk_inventoris/utils/textformfield.dart";
import "package:flutter/material.dart";

class RejectDialog extends StatefulWidget {
  const RejectDialog({
    super.key,
  });

  @override
  State<RejectDialog> createState() => _RejectDialogState();
}

class _RejectDialogState extends State<RejectDialog> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _messageController = TextEditingController();

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
                controller: _messageController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Message must be filled';
                  }
                  return null;
                },
                labelText: "Reject Message / Reason",
                prefixIcon: null,
                suffixIcon: null,
                obscureText: false,
              ),

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
                          Navigator.pop(context, _messageController.text);
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
