import 'dart:io';

import 'package:path_provider/path_provider.dart';

class CacheUtils {
  /// 获取缓存
  /// path_provider中获取文件夹的方法：

  /// 1、getTemporaryDirectory() ///< 在iOS上，对应NSTemporaryDirectory()；在Android上，对应getCacheDir。
  /// 2、getApplicationDocumentsDirectory() ///< 在iOS上，对应NSDocumentsDirectory；在Android上，对应AppData目录。
  /// 3、getExternalStorageDirectory() ///< 在iOS上，抛出异常，在Android上，对应getExternalStorageDirectory。

  static Future<double> loadApplicationCache() async {
    /// 获取文件夹 在Android上，对应getCacheDir
    Directory directory = await getTemporaryDirectory();

    /// 获取缓存大小
    double value = await getTotalSizeOfFilesInDir(directory);
    return value;
  }

  /// 循环计算文件的大小（递归）
  static Future<double> getTotalSizeOfFilesInDir(
      final FileSystemEntity file) async {
    if (file is File) {
      int length = await file.length();
      return double.parse(length.toString());
    }
    if (file is Directory) {
      final List<FileSystemEntity> children = file.listSync();
      double total = 0;
      for (final FileSystemEntity child in children) {
        total += await getTotalSizeOfFilesInDir(child);
      }
      return total;
    }
    return 0;
  }

  /// 缓存大小格式转换
  static String formatSize(double value) {
    if (value == null) {
      return '0';
    }
    List<String> unitArr = ['B', 'K', 'M', 'G'];
    int index = 0;
    while (value > 1024) {
      index++;
      value = value / 1024;
    }
    String size = value.toStringAsFixed(2);
    return size + unitArr[index];
  }

  /// 删除缓存
  static void clearApplicationCache() async {
    Directory directory = await getTemporaryDirectory();
    //删除缓存目录
    await _deleteDirectory(directory);
  }

  /// 递归方式删除目录
  static Future _deleteDirectory(FileSystemEntity file) async {
    if (file is Directory) {
      final List<FileSystemEntity> children = file.listSync();
      for (final FileSystemEntity child in children) {
        await _deleteDirectory(child);
      }
    }
    await file.delete();
  }
}
