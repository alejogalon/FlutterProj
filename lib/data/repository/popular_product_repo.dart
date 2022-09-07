import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:my_firstapp/data/api/api_client.dart';
import 'package:my_firstapp/utils/app_constants.dart';

class PopularProductRepo extends GetxService{
  final ApiClient apiClient;//instance

  //constructor
  PopularProductRepo({required this.apiClient});

  Future<Response> getPopularProductList() async{
    return await apiClient.getData(AppConstants.POPULAR_PRODUCT_URI);
  }
}