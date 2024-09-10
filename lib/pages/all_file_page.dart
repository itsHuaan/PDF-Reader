import 'package:flutter/material.dart';
import 'package:pdf_reader/components/my_text_field.dart';
import 'package:pdf_reader/components/my_tile.dart';

class AllFilePage extends StatelessWidget {
  const AllFilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: MyTextField(
              hintText: 'Search',
              borderRadius: 50.0,
              suffixIcon: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.search_rounded,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return const MyTile();
              },
            ),
          ),
          const SizedBox(height: 15.0),
        ],
      ),
    );
  }
}
