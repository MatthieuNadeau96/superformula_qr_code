class SeedModel {
  final String seed;
  final String description;

  SeedModel({
    required this.seed,
    required this.description,
  });

  factory SeedModel.fromJson(Map<String, dynamic> json) {
    return SeedModel(
      seed: json['seed'],
      description: json['description'],
    );
  }
}
