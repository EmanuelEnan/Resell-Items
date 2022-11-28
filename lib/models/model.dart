class Employees {
  String? content;
  String? title;
  String? image;
  String? userId;
  String? date;
  String? id;
  String? price;
  int? v;

  Employees({this.content, this.title, this.image, this.price});

  Employees.fromJson(Map<String, dynamic> json) {
    content = json['content'] ?? 'null';
    title = json['title'] ?? 'null';
    image = json['image'] ?? 'null';
    userId = json['userId'] ?? 'null';
    date = json['date'];
    id = json['_id'] ?? 'null';
    price = json['price'] ?? 'null';
    v = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['content'] = content;
    data['title'] = title;
    data['image'] = image;
    data['userId'] = userId;
    data['date'] = date;
    data['_id'] = id;
    data['price'] = price;
    data['__v'] = v;
    return data;
  }
}
