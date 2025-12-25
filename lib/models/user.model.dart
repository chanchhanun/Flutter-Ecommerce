class User {
  User({
    required this.id,
    required this.fullName,
    required this.email,
    required this.address,
    required this.v,
  });

  final String? id;
  final String? fullName;
  final String? email;
  final List<dynamic> address;
  final int? v;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["_id"],
      fullName: json["fullName"],
      email: json["email"],
      address: json["address"] == null
          ? []
          : List<dynamic>.from(json["address"]!.map((x) => x)),
      v: json["__v"],
    );
  }

  factory User.empty() {
    return User(id: '', fullName: '', email: '', address: [], v: 0);
  }
}
