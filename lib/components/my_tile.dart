import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';
import 'package:pdf_reader/models/file_model.dart';

class MyTile extends StatelessWidget {
  final FileModel fileModel;
  final void Function(FileModel) onTap;
  final void Function(FileModel) onFavoriteToggle;

  const MyTile({
    super.key,
    required this.fileModel,
    required this.onTap,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(fileModel);
      },
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
                size: 60.0,
                color: Colors.red,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fileModel.file.path.split('/').last,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Text(
                  'Created: ${DateFormat('MMM dd, yyyy HH:mm:ss').format(
                    fileModel.file.statSync().modified.toLocal(),
                  )}',
                  style: const TextStyle(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
            const Spacer(),
            IconButton(
              onPressed: () => onFavoriteToggle(fileModel),
              icon: Icon(
                fileModel.isFavorite ? Icons.star_rounded : Icons.star_outline_rounded,
                color: fileModel.isFavorite ? Colors.yellow : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
