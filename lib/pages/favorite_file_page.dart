import 'package:flutter/material.dart';
import 'package:pdf_reader/components/my_tile.dart';
import 'package:pdf_reader/models/file_model.dart';
import 'package:pdf_reader/models/pdf_provider.dart';
import 'package:pdf_reader/pages/pdf_view_page.dart';
import 'package:provider/provider.dart';

class FavoriteFilePage extends StatelessWidget {
  const FavoriteFilePage({super.key});

  void openPDF(BuildContext context, FileModel fileModel) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PDFViewPage(
          file: fileModel.file,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final favoriteFiles = context.watch<PDFProvider>().favoriteFiles;

    return favoriteFiles.isEmpty
        ? Center(
            child: Text(
              "You haven't added any favorite files yet.",
              style: TextStyle(
                color: Theme.of(context).colorScheme.inverseSurface,
              ),
            ),
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: favoriteFiles.length,
                  itemBuilder: (context, index) {
                    FileModel favoriteFile = favoriteFiles[index];
                    return MyTile(
                      fileModel: favoriteFile,
                      onTap: (fileModel) => openPDF(context, fileModel),
                      onFavoriteToggle: (fileModel) {
                        Provider.of<PDFProvider>(context, listen: false).toggleFavorite(fileModel); // Cập nhật trạng thái yêu thích
                      },
                    );
                  },
                ),
              ),
            ],
          );
  }
}
