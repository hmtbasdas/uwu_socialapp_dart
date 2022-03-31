import 'package:get/get.dart';

import '../../utils/strings.dart';

class TopicsApiClient extends GetConnect implements GetxService {

  late String token;
  final String topicsBaseUrl;

  TopicsApiClient({required this.topicsBaseUrl}){
    baseUrl = topicsBaseUrl;
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