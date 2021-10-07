import 'dart:convert';

class UserClass {
  final String name;
  final String email;
  UserClass({
    required this.name,
    required this.email,
  });
  

  UserClass copyWith({
    String? name,
    String? email,
  }) {
    return UserClass(
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
    };
  }

  factory UserClass.fromMap(Map<String, dynamic> map) {
    return UserClass(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserClass.fromJson(String source) => UserClass.fromMap(json.decode(source));

  @override
  String toString() => 'UserClass(name: $name, email: $email)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is UserClass &&
      other.name == name &&
      other.email == email;
  }

  @override
  int get hashCode => name.hashCode ^ email.hashCode;
}
