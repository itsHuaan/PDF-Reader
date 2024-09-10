import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PDFViewPage extends StatelessWidget {
  final File file;
  const PDFViewPage({
    super.key,
    required this.file,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(file.path.split('/').last.replaceAll('.pdf', '')),
      ),
      body: PDFView(
        filePath: file.path,
      ),
    );
  }
}
