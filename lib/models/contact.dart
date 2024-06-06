class Contact {
  int id;
  String name;
  String surname;
  String phoneNumber;

  Contact({
    required this.id,
    required this.name,
    required this.surname,
    required this.phoneNumber,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'surname': surname,
      'phoneNumber': phoneNumber,
    };
  }
}
