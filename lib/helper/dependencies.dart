import 'package:get/get.dart';
import 'package:uwusocialapp/controller/country_list_controller.dart';
import 'package:uwusocialapp/data/api/country_api_client.dart';
import 'package:uwusocialapp/data/firebase/auth_services/auth_service.dart';
import 'package:uwusocialapp/data/firebase/database_services/firestore_services.dart';
import 'package:uwusocialapp/data/repository/country_repo.dart';
import 'package:uwusocialapp/data/repository/topics_repo.dart';
import 'package:uwusocialapp/utils/strings.dart';
import '../controller/topics_list_controller.dart';
import '../data/api/topics_api_client.dart';
import '../data/firebase/storage_services/avatars_controller.dart';

Future<void> init() async {

  //country api
  Get.lazyPut(() => CountryApiClient(countryBaseUrl: Strings.BASE_URL));
  Get.lazyPut(() => TopicsApiClient(topicsBaseUrl: Strings.BASE_URL));

  //repos
  Get.lazyPut(() => CountryRepository(apiClient: Get.find()));
  Get.lazyPut(() => TopicsRepository(topicsApiClient: Get.find()));

  //controllers
  Get.lazyPut(() => CountryListController(countryRepository: Get.find()));
  Get.lazyPut(() => TopicsListController(topicsRepository: Get.find()));

  /* ----------------------------------------- Firebase -------------------------------------- */

  //controller
  Get.lazyPut(() => AvatarsController());

  //services
  Get.lazyPut(() => AuthService());
  Get.lazyPut(() => FirestoreService());
}