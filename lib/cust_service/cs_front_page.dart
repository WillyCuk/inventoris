
import 'package:atk_inventoris/router/routernamed.dart';
import 'package:atk_inventoris/utils/logo.dart';
import 'package:atk_inventoris/utils/mybutton.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class CsFrontPage extends StatelessWidget {
  const CsFrontPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * .1),
            const MyLogo(),
            Text(
              "Aplikasi Pendataan",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 26,
              ),
            ),
            Text(
              "Alat Tulis Kantor",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 26,
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(70.0, 15.0, 70.0, 25.0),
              child:  Divider(),
            ),
            MyButton(
              text: "USER PAGE",
              onPressed: () => context.goNamed(RouterName.dashboardUserPage),
            ),
            const SizedBox(height: 30),
            MyButton(
              text: "ADMIN PAGE",
              onPressed: () => context.goNamed(RouterName.dashboardAdminPage),
            ),
            const SizedBox(height: 30),
            MyButton(
              text: "CUSTOMER SERVICE PAGE",
              onPressed: () => context.goNamed(RouterName.dashboardCSPage),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(70.0, 25.0, 70.0, 45.0),
              child: Divider(),
            ),
          ],
        ),
      ),
    );
  }
}
