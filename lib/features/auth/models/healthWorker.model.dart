class HealthWorker {
  String healthWorkerId;
  String name;
  String password;

  HealthWorker({
    required this.healthWorkerId,
    required this.name,
    required this.password,
  });

  factory HealthWorker.fromJson(Map<String, dynamic> json) {
    return HealthWorker(
      healthWorkerId: json['healthWorkerId'],
      name: json['name'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'healthWorkerId': healthWorkerId,
      'name': name,
      'password': password,
    };
  }
}
