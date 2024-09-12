import 'package:azan/AppManager/ApiServices/api_service.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController{
  final _api = ApiService();
  final nameC = TextEditingController();
  List coordinateList = [];
  void updateCoordinateList(List val){
    coordinateList = val;
  }
  Future<void> getCoordinatesByAddress(String address)async{
    final response =await _api.get('autocomplete?text=$address&apiKey=1272d7cb77a14086ad7ed896a6dfcc0b',customBaseUrl: 'https://api.geoapify.com/v1/geocode/');
    print("response $response");
  }

  Future<void> fetchData(ApiService apiService, BuildContext context) async {
    try {
      // Perform a GET request
      final response = await apiService.get("/posts");

      // Handle the response (print the data)
      print("Response data: $response");
    } catch (e) {
      // Handle the error and show an alert dialog
    }
  }

// https://api.geoapify.com/v1/geocode/autocomplete?text=sarfarazganj&apiKey=1272d7cb77a14086ad7ed896a6dfcc0b
}