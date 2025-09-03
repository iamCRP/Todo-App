class Usermodel {
  String? name;
  bool? isfun;

  Usermodel({this.name, this.isfun});

  Usermodel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    isfun = json['isfun'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['isfun'] = this.isfun;
    return data;
  }
}
