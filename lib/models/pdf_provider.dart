import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:pdf_reader/models/file_model.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';

class PDFProvider with ChangeNotifier {
  List<FileModel> _pdfFiles = [];
  final List<FileModel> _favoriteFiles = [];
  final Set<String> _filePaths = {}; // Set để theo dõi các đường dẫn đã gặp
  final String fixedDirectoryPath = '/storage/emulated/0/'; // Đường dẫn cố định
  bool _isLoaded = false; // Đánh dấu nếu đã load file

  List<FileModel> get pdfFiles => _pdfFiles;
  List<FileModel> get favoriteFiles => _favoriteFiles;

  // Thay đổi: kiểm tra nếu file đã load thì không cần load lại
  Future<void> loadPDFFiles() async {
    if (_isLoaded) {
      return;
    }
    _pdfFiles.clear(); // Xóa danh sách file trước khi tải mới
    _filePaths.clear(); // Xóa set các đường dẫn file
    await baseDirectory();
    _isLoaded = true; // Đánh dấu đã load file
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
            }
          }
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  // Thay đổi trạng thái yêu thích của file
  void toggleFavorite(FileModel fileModel) {
    fileModel.isFavorite = !fileModel.isFavorite; // Đổi trạng thái isFavorite
    if (fileModel.isFavorite) {
      _favoriteFiles.add(fileModel); // Thêm file vào danh sách yêu thích
    } else {
      _favoriteFiles.remove(fileModel); // Xóa file khỏi danh sách yêu thích
    }
    notifyListeners(); // Thông báo để cập nhật UI
  }
}
