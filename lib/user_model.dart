class User {
  int? id;
  String name;
  String email;
  String phone;
  String? image;

  User({this.id, required this.name, required this.email, required this.phone, required this.image,});

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{"name": name, "email": email, "phone": phone, "image": image,};

    if (id != null) {
      map["id"] = id;
    }
    return map;
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
      image: map['image'],
    );
  }
}
