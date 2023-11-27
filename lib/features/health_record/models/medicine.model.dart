class Medicine {
  String name;
  int qty;
  String patientId;
  DateTime? dateGiven;

  Medicine({
    required this.name,
    required this.qty,
    required this.patientId,
    required this.dateGiven,
  });

  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(
      name: json['name'] ?? '',
      qty: json['qty'] ?? 0,
      patientId: json['patientId'] ?? '',
      dateGiven: json['dateGiven'] != null
          ? DateTime.parse(json['dateGiven'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'qty': qty.toString(),
      'patientId': patientId,
      'dateGiven': dateGiven!.toIso8601String(),
    };
  }
}
