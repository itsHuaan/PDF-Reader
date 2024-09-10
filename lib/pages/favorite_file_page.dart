import 'package:flutter/material.dart';
import 'package:pdf_reader/components/my_tile.dart';
import 'package:pdf_reader/models/file_model.dart';
import 'package:pdf_reader/models/pdf_provider.dart';
import 'package:pdf_reader/pages/pdf_view_page.dart';
import 'package:provider/provider.dart';

class FavoriteFilePage extends StatelessWidget {
  const FavoriteFilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteFiles = context.watch<PDFProvider>().favoriteFiles;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: favoriteFiles.length,
              itemBuilder: (context, index) {
                FileModel pdfFileModel = favoriteFiles[index];
                return MyTile(
                  fileModel: pdfFileModel,
                  onTap: (fileModel) => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PDFViewPage(
                        file: fileModel.file,
                      ),
                    ),
                  ),
                  onFavoriteToggle: (fileModel) {
                    context.read<PDFProvider>().toggleFavorite(fileModel);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
