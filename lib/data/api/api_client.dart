import 'package:get/get.dart';
import 'package:my_firstapp/utils/app_constants.dart';

class ApiClient extends GetConnect implements GetxService{
  late String token;
  final String appBaseUrl;
  late Map<String, String> _mainHeaders;

//[]this is a list
//{}this is a Map
  ApiClient({required this.appBaseUrl}){
    baseUrl = appBaseUrl;
    timeout = Duration(seconds: 30);
    token = AppConstants.TOKEN;
    _mainHeaders={
      'Content-type':'application/json; charset=UTF-8',
      'Authorization':'Bearer $token',
    };
  }
  Future<Response> getData(String uri) async{
    try{
      Response response = await get(uri);
      return response;
    }catch(e){
      return Response(statusCode: 1, statusText: e.toString());
    }
  }
}