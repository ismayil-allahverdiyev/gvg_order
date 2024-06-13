import 'dart:io';
import 'dart:math';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../src/ui/theme/app_colors.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../constants/endpoints.dart';
import '../../constants/local_storage.dart';
import '../../controllers/local_storage/local_storage_controller.dart';
import '../provider/api_client.dart';

class Repository {
  final ApiClient apiClient;
  final client = HttpClient();

  Repository({required this.apiClient});
  var headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': '',
    'Accept-Language': '',
    'Cookie':
        '.AspNetCore.Identity.Application=CfDJ8IgJzIx6tadPvRZU0EAJrBPmj00xbgraQJs86mdXTFbbP0hEKlGCxvjeRbtmRzNsgfdRl1130EXCP13T6meSRhXHfi7k7xz_OxY4HW6I6LFByScJ0etGd7JQvVv6VVzGAO0gx6-B_BBZcwpZKkm26qno2kMzsxz-DoNsOPKR5L2esiUkENaipC3Pf8FUqQvwXuakDsXBOvJe_vsfXPPhW4pWCaB3GA1m0cuoHiT28NPH4oj1MJeMQwnkzvznlYcVOb3eW-_M6yEmQT5X0uIAeqJ0KaTW-onaMsUoAVwUNDYp_RnwLjtytt9rKREQD9L8c3I96v4gv7Z_1LJ9nU8ePAwbjoUqwO6q36PQVNRKddbAKM6RIdPcwjIQGkCReT-udP6WorddqFAjr8GoaCDVukP3JH1SyZ4wFI66iWNd6lTFCcmZ5mdZ-HZweCMmQqbwRx8LG7d4oKk-AA8zPJ1bCTZVCVILgiiM7_N3JHIkN5ozNPlTp9ugr8hA3tA___QoXBoReKriiS7BlovG-6joXKICVG9EiTOjRAx_AwEoBnBHgQDp-CGPaPcHfJkKVGUI1R0IPSpaxT7QfV5J2aW7JXfMWwxS2Rt5L1gG-tL2gUxC5Pt5NrVzUZ0ETulIktI6mnZCoeprXoBOKcC-LOk21n26jRmfGd5v7fLpTOvrUjWpKjQoLVYmckt-cDmLe-5xmzKsiOmnjeURcIsd390uiYEXCO2863OjBiGuN3uW14-tHi7wWOHgmLFOd_Ni_T0dGNGrEiy2FeBxrNwoN1JAFXU3r0YCaiKKzgGwBP6fCSAHv_kiPMUA4Fqr2mUjPnr_EnIjL0DlzRFLQ_--VdsL5zJBZhBm1tuEDH82IfWRaHdMYWfNsXuBjMWiPc-qa_vHzOlztTGpH-W_cQhvDBAJP3k'
  };

  var refreshToken = "";
  var authorization = "";

  getHeaders() {
    LocalStorageController localStorageController = Get.put(
        LocalStorageController(repository: Repository(apiClient: ApiClient())));
    headers['Authorization'] = "Bearer " +
        localStorageController.getStringFromLocal(LocalStorageConst.jwtToken);
    // var language = localStorageController
    //             .getStringFromLocal(LocalStorageConst.language) ==
    //         ""
    //     ? "en-US"
    //     : localStorageController.getStringFromLocal(LocalStorageConst.language);
    // headers['Accept-Language'] = language;
    return headers;
  }

  Future<XFile?> getImage({required int index}) async {
    final ImagePicker picker = ImagePicker();
    var status1 = await Permission.photos.status;
    var status2 = await Permission.camera.status;
    var status3 = await Permission.storage.status;

    if (status1.isDenied) {
      await Permission.photos.request();
    } else if (status2.isDenied) {
      await Permission.camera.request();
    } else if (status3.isDenied) {
      await Permission.storage.request();
    }
    return await picker.pickImage(
      source: index == 0 ? ImageSource.camera : ImageSource.gallery,
      imageQuality: 20,
      preferredCameraDevice: CameraDevice.rear,
    );
  }

  getNotificationToken() async {
    return (await FirebaseMessaging.instance.getToken()).toString();
  }

  getData({
    required String endpoint,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
  }) async {
    return await apiClient.getData(
      endpoint: endpoint,
      headers: getHeaders(),
      query: query,
      data: data,
    );
  }

  postData({
    required String endpoint,
    Map<String, dynamic>? query,
    Map<String, dynamic>? object,
    List<Map<String, dynamic>>? list,
  }) async {
    return await apiClient.post(
      endpoint: endpoint,
      headers: getHeaders(),
      query: query,
      object: object ?? list,
    );
  }

  putData(
    String endpoint,
    Map<String, dynamic>? object,
  ) async {
    return await apiClient.put(
      endpoint,
      object,
    );
  }

  postMultiPartData(
    String endpoint,
    Map<String, dynamic>? query,
    Map<String, String> object,
    String fileName,
    String? path,
  ) async {
    var newHeaders = getHeaders();
    newHeaders['Content-Type'] = "multipart/form-data";
    print(newHeaders);
    return await apiClient.postMultiform(
      endpoint: endpoint,
      headers: newHeaders,
      query: query,
      object: object,
      path: path,
      fileName: fileName,
    );
  }

  selectImage({required bool isFromGallery}) async {
    final ImagePicker picker = ImagePicker();
    var status1 = await Permission.photos.status;
    var status2 = await Permission.camera.status;
    var status3 = await Permission.storage.status;

    if (status1.isDenied) {
      await Permission.photos.request();
    } else if (status2.isDenied) {
      await Permission.camera.request();
    } else if (status3.isDenied) {
      await Permission.storage.request();
    }
    var image = (await picker.pickImage(
      source: isFromGallery ? ImageSource.gallery : ImageSource.camera,
      imageQuality: 20,
      preferredCameraDevice: CameraDevice.rear,
    ));

    if (image != null) {
      return File(image.path);
    }
    return null;
  }

  errorHandler({required List<dynamic> errors, required String message}) {
    if (errors.isNotEmpty) {
      Get.snackbar(
        errors[0]["propertyName"].toString(),
        errors[0]["message"].toString(),
        duration: Duration(seconds: 2),
        backgroundColor: primaryColor,
        colorText: Colors.white,
      );
    } else {
      Get.snackbar(
        "",
        message.toString(),
        duration: const Duration(seconds: 2),
        backgroundColor: greyColor,
        colorText: Colors.white,
      );
    }
  }

  showMessage({required String? title, required String message}) async {
    await Get.snackbar(
      title ?? "",
      message,
      duration: Duration(seconds: 2),
      backgroundColor: greyColor,
      colorText: Colors.white,
    );
  }
}
