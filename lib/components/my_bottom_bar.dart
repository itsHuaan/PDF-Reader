import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class MyBottomBar extends StatelessWidget {
  final void Function(int)? onTap;
  const MyBottomBar({super.key, this.onTap,});

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      onTap: onTap,
      height: 60,
      animationDuration: const Duration(milliseconds: 300),
      backgroundColor: Theme.of(context).colorScheme.surface,
      color: Theme.of(context).colorScheme.primary,
      items: const [
        Icon(Icons.file_present_rounded),
        Icon(Icons.history_rounded),
        Icon(Icons.favorite_rounded),
      ],
    );
  }
}
