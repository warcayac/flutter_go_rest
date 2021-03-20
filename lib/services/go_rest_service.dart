import 'dart:async';

import 'package:get/get.dart';
import 'package:wnetworking/wnetworking.dart';


class GoRestService extends GetxController{
  final _baseUrl = 'https://gorest.co.in/public-api';
  var _data = [].obs;
  var isLoading = false.obs;
  /* ---------------------------------------------------------------------------- */
  int get numOfProducts => _data.length;
  String productImg(int index) => _data[index]['image'];
  String productName(int index) => _data[index]['name'];
  String productDesc(int index) => _data[index]['description'];
  /* ---------------------------------------------------------------------------- */
  FutureOr<void> fetchProducts() async {
    isLoading.value = true;
    _data.clear();

    await NetService.getJson<Map<String, dynamic>>('$_baseUrl/products')
      .then((response) {
        if (response != null && (response['data'] as List).isNotEmpty) 
          _data.addAll(response['data']);
      })
      .whenComplete(() => isLoading.toggle());
  }
}

