import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class MyBottomBar extends StatelessWidget {
  final void Function(int)? onTap;
  const MyBottomBar({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      onTap: onTap,
      height: 60,
      animationDuration: const Duration(milliseconds: 300),
      backgroundColor: Theme.of(context).colorScheme.surface,
      color: Theme.of(context).colorScheme.primary,
      items: [
        Icon(
          Icons.file_present_rounded,
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
        Icon(
          Icons.history_rounded,
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
        Icon(
          Icons.favorite_rounded,
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
      ],
    );
  }
}
