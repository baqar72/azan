import 'package:azan/AppManager/ApiServices/api_service.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController{
  ApiService apiService = ApiService();

  Future<void> hitAzanTiming()async{
    try {
      // Perform a GET request
      final response = await apiService.get("timingsByAddresss/05-09-2024?address=Lucknow,India&method=0");

      // Handle the response (print the data)
      print("Response data: $response");
    } catch (e) {
      // Handle the error
      print("Error : $e");
    }
  }
}