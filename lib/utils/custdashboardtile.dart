import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustDashboardTile extends StatelessWidget {
  final String route;
  final String menuName;
  final Icon menuIcon;
  const CustDashboardTile({super.key
      , required this.route
      , required this.menuName
      , required this.menuIcon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: () {
          context.pushNamed(route);
        },
        child: Container(
          width: double.infinity,
          height: 60,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(
                menuIcon.icon,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              const SizedBox(width: 8),
              Text(
                menuName,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontSize: 18,
                ),
              ),
              const SizedBox(width: 8),
              Icon(Icons.arrow_forward_ios,
                  color: Theme.of(context).colorScheme.inversePrimary),
            ],
          ),
        ),
      ),
    );
  }
}
