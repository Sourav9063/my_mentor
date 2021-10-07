import 'dart:convert';

class Mentor {
  final String name;
  final String email;
  final String relation;
  Mentor({
    required this.name,
    required this.email,
    required this.relation,
  });
  

  Mentor copyWith({
    String? name,
    String? email,
    String? relation,
  }) {
    return Mentor(
      name: name ?? this.name,
      email: email ?? this.email,
      relation: relation ?? this.relation,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'relation': relation,
    };
  }

  factory Mentor.fromMap(Map<String, dynamic> map) {
    return Mentor(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      relation: map['relation'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Mentor.fromJson(String source) => Mentor.fromMap(json.decode(source));

  @override
  String toString() => 'Mentor(name: $name, email: $email, relation: $relation)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Mentor &&
      other.name == name &&
      other.email == email &&
      other.relation == relation;
  }

  @override
  int get hashCode => name.hashCode ^ email.hashCode ^ relation.hashCode;
}
