import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DataManager {
  static const instance = FlutterSecureStorage();

  static Future<Map<String, String>> getPasswordList({
    AndroidOptions? androidOptions,
    IOSOptions? iosOptions,
  }) async {
    final data = await instance.readAll(
      iOptions: iosOptions,
      aOptions: androidOptions,
    );
    return data;
  }

  static Future<void> saveNewPassword(
    String id,
    String data, {
    AndroidOptions? androidOptions,
    IOSOptions? iosOptions,
  }) async {
    await instance.write(
      key: id,
      value: data,
      iOptions: iosOptions,
      aOptions: androidOptions,
    );
  }

  //this actually same as saveNewPassword, todo later review
  static Future<void> editPassword(
    String id,
    String data, {
    AndroidOptions? androidOptions,
    IOSOptions? iosOptions,
  }) async {
    await instance.write(
      key: id,
      value: data,
      iOptions: iosOptions,
      aOptions: androidOptions,
    );
  }

  static Future<void> delete(
    String id, {
    AndroidOptions? androidOptions,
    IOSOptions? iosOptions,
  }) async {
    await instance.delete(
      key: id,
      iOptions: iosOptions,
      aOptions: androidOptions,
    );
  }
}
