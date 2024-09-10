import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:pdf_reader/models/file_model.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';

class PDFProvider with ChangeNotifier {
  final List<FileModel> _pdfFiles = [];
  final List<FileModel> _favoriteFiles = [];
  final Set<String> _filePaths = {}; // Set để theo dõi các đường dẫn đã gặp
  final String fixedDirectoryPath = '/storage/emulated/0/'; // Đường dẫn cố định

  List<FileModel> get pdfFiles => _pdfFiles;
  List<FileModel> get favoriteFiles => _favoriteFiles;

  Future<void> loadPDFFiles() async {
    _pdfFiles.clear(); // Xóa danh sách file trước khi tải mới
    _filePaths.clear(); // Xóa set các đường dẫn file
    await baseDirectory();
    notifyListeners(); // Cập nhật UI sau khi load xong file
  }

  Future<void> baseDirectory() async {
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    AndroidDeviceInfo androidDeviceInfo = await deviceInfoPlugin.androidInfo;

    if (androidDeviceInfo.version.sdkInt < 30) {
      PermissionStatus permissionStatus = await Permission.storage.request();
      if (permissionStatus.isGranted) {
        await getFiles(fixedDirectoryPath); // Sử dụng đường dẫn cố định
      } else {
        if (kDebugMode) {
          print("Permission denied");
        }
      }
    } else {
      PermissionStatus permissionStatus = await Permission.manageExternalStorage.request();
      if (permissionStatus.isGranted) {
        await getFiles(fixedDirectoryPath); // Sử dụng đường dẫn cố định
      } else {
        if (kDebugMode) {
          print("Permission denied");
        }
      }
    }
  }

  Future<void> getFiles(String directoryPath) async {
    try {
      var rootDirectory = Directory(directoryPath);
      var directories = rootDirectory.list(recursive: true, followLinks: false);

      await for (var entity in directories) {
        if (entity is File) {
          if (entity.path.split(".").last == "pdf") {
            if (!_filePaths.contains(entity.path)) {
              var fileModel = FileModel(file: entity);
              _pdfFiles.add(fileModel);
              _filePaths.add(entity.path); // Thêm đường dẫn vào set
              if (kDebugMode) {
                print("PDF File Name : ${entity.path.split("/").last}");
              }
            }
          }
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error scanning directory: $e");
      }
    }
  }

  void toggleFavorite(FileModel fileModel) {
    fileModel.isFavorite = !fileModel.isFavorite;
    if (fileModel.isFavorite) {
      if (!_favoriteFiles.contains(fileModel)) {
        _favoriteFiles.add(fileModel);
      }
    } else {
      _favoriteFiles.remove(fileModel);
    }

    // Cập nhật danh sách tất cả các file để đảm bảo không có trùng lặp
    int index = _pdfFiles.indexWhere((f) => f.file.path == fileModel.file.path);
    if (index != -1) {
      _pdfFiles[index] = fileModel;
    }

    notifyListeners(); // Cập nhật UI sau khi toggle xong
  }
}
