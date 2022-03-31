import 'package:get/get.dart';
import 'package:uwusocialapp/data/api/topics_api_client.dart';
import 'package:uwusocialapp/utils/strings.dart';

class TopicsRepository extends GetxService{

  final TopicsApiClient topicsApiClient;

  TopicsRepository({required this.topicsApiClient});

  Future<Response> getTopicsList() async {
    return await topicsApiClient.getData(Strings.TOPICS_URI);
  }

}