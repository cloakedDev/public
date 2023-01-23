class Coffee {
  String? file;

  Coffee({this.file});

  Coffee.fromJson(Map<String, dynamic> json) {
    file = json['file'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['file'] = file;
    return data;
  }
}
