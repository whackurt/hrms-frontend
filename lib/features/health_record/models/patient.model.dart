class Patient {
  String firstName;
  String lastName;
  String street;
  DateTime? birthDate;
  String zone;
  String barangay;
  String cityMunicipality;
  String province;

  Patient({
    required this.firstName,
    required this.lastName,
    required this.birthDate,
    required this.street,
    required this.zone,
    required this.barangay,
    required this.cityMunicipality,
    required this.province,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      birthDate: DateTime.parse(json['birthDate']),
      street: json['street'] ?? '',
      zone: json['zone'] ?? '',
      barangay: json['barangay'] ?? '',
      cityMunicipality: json['city_municipality'] ?? '',
      province: json['province'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName.toString(),
      'lastName': lastName,
      'birthDate': birthDate?.toIso8601String(),
      'zone': zone,
      'street': street,
      'barangay': barangay,
      'city_municipality': cityMunicipality,
      'province': province
    };
  }
}
