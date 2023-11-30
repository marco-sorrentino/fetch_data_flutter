class User {
  const User({
    required this.id,
    required this.name,
    required this.username,
    required this.address,
  });

  final int id;
  final String name;
  final String username;
  final Address address;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      address: Address.fromJson(json['address']),
    );
  }
}

class Address {
  const Address({
    required this.street,
    required this.city,
  });

  final String street;
  final String city;

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      street: json['street'],
      city: json['city'],
    );
  }
}
