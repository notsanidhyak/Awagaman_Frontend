// ignore_for_file: public_member_api_docs, sort_constructors_first

class Students {
  String? id;
  String? name;
  String? time;
  Students({
    this.id,
    this.name,
    this.time,
  });

  Students.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    time = json['time'];
  }
}
