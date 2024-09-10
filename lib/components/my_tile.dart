import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class MyTile extends StatelessWidget {
  const MyTile({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(15.0),
        ),
        padding: const EdgeInsets.all(15.0),
        margin: const EdgeInsets.only(
          top: 15.0,
          left: 15.0,
          right: 15.0,
        ),
        child: Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Icon(
                AntDesign.file_pdf_fill,
                size: 40.0,
              ),
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("File name"),
                Text("File created"),
              ],
            ),
            const Spacer(),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.star_outline_rounded),
            )
          ],
        ),
      ),
    );
  }
}
