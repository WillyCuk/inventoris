import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardTile extends StatelessWidget {
  final String route;
  final String imagePath;
  final String menuName;
  const DashboardTile(
      {super.key,
      required this.route,
      required this.imagePath,
      required this.menuName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(route);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.sizeOf(context).width * .28,
            height: MediaQuery.sizeOf(context).width * .28,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(40),
            ),
            padding: const EdgeInsets.all(20.0),
            child: Image.asset(
              imagePath,
              fit: BoxFit.contain,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            menuName,
            style: GoogleFonts.poppins(
                fontSize: MediaQuery.sizeOf(context).width * .025,
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
