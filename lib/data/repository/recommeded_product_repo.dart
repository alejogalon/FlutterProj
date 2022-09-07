import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:my_firstapp/data/api/api_client.dart';
import 'package:my_firstapp/utils/app_constants.dart';

class RecommendedProductRepo extends GetxService{
  final ApiClient apiClient;//instance

  //constructor
  RecommendedProductRepo({required this.apiClient});

  Future<Response> getRecommendedProductList() async{
    return await apiClient.getData(AppConstants.RECOMMENDED_PRODUCT_URI);
  }
}