class Avatars {

  String? imgUrl;

  Avatars({this.imgUrl});

  Avatars.fromStorage(Map<String, String> list){
    imgUrl = list['imgUrl'];
  }
}