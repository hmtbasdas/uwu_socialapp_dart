import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {

  String _id;
  String _nickname;
  String _gender;
  Timestamp _birthday;
  String _country;
  String _avatar;
  String _bio;
  List<dynamic> _topics;

  AppUser(this._id, this._nickname, this._gender, this._birthday, this._country,
      this._avatar, this._bio, this._topics);

  List<dynamic> get topics => _topics;

  String get bio => _bio;

  String get avatar => _avatar;

  String get country => _country;

  Timestamp get birthday => _birthday;

  String get gender => _gender;

  String get nickname => _nickname;

  String get id => _id;
}