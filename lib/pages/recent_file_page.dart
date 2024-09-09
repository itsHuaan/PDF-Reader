import 'package:flutter/material.dart';

class RecentFilePage extends StatelessWidget {
  const RecentFilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Recent files"),
        ],
      ),
    );
  }
}