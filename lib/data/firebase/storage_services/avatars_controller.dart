import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class AvatarsController extends GetxController {

  final FirebaseStorage _storage = FirebaseStorage.instance;

  final List<dynamic> _avatarList = [];
  List<dynamic> get avatarList => _avatarList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getAvatars() async {
    ListResult listResult = await _storage.ref("/avatars/").listAll();

    for (var element in listResult.items) {
      _avatarList.add(await _storage.ref(element.fullPath).getDownloadURL());
    }

    _isLoaded = true;
  }
}