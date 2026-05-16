class NetworkModel {
  final String name;
  final String logo;

  NetworkModel({
    required this.name,
    required this.logo,
  });
}

class PlanModel {
  final String name;
  final int duration;
  final double amount;

  PlanModel({
    required this.name,
    required this.duration,
    required this.amount,
  });
}