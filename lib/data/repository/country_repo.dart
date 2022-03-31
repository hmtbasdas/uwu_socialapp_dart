import 'package:get/get.dart';
import 'package:uwusocialapp/data/api/country_api_client.dart';
import 'package:uwusocialapp/utils/strings.dart';

class CountryRepository extends GetxService {

  final CountryApiClient apiClient;

  CountryRepository({required this.apiClient});

  Future<Response> getCountryList() async {
    return await apiClient.getData(Strings.COUNTRY_URI);
  }
}