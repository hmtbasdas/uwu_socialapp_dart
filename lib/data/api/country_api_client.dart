import 'package:get/get.dart';
import 'package:uwusocialapp/utils/strings.dart';

class CountryApiClient extends GetConnect implements GetxService {

  late String token;
  final String countryBaseUrl;

  CountryApiClient({required this.countryBaseUrl}){
    baseUrl = countryBaseUrl;
    timeout = const Duration(seconds: 30);
    token = Strings.TOKEN;
  }

  Future<Response> getData(String uri) async {
    try{
      Response response = await get(uri);
      return response;
    }
    catch(error){
      return Response(statusCode: 1, statusText: error.toString());
    }
  }

}