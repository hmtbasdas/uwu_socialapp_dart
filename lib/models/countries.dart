class Countries {
  String? country;

  Countries({this.country});

  Countries.fromJson(Map<String, dynamic> json) {
    country = json['country'];
  }
}