class MembroElencoModel {
  final bool adult;
  final num gender;
  final num id;
  final String knownForDepartment;
  final String name;
  final String originalName;
  final num popularity;
  final String profilePath;
  final num castId;
  final String character;
  final String creditId;
  final num order;
  final String department;
  final String job;

  MembroElencoModel.fromJson(Map<String, dynamic> json)
      : adult = json['adult'] ?? false,
        gender = json['gender'] ?? 0,
        id = json['id'] ?? 0,
        knownForDepartment = json['known_for_department'] ?? '',
        name = json['name'] ?? '',
        originalName = json['original_name'] ?? '',
        popularity = json['popularity'] ?? 0,
        profilePath = json['profile_path'] ?? '',
        castId = json['cast_id'] ?? 0,
        character = json['character'] ?? '',
        creditId = json['credit_id'] ?? '',
        order = json['order'] ?? 0,
        department = json['department'] ?? '',
        job = json['job'] ?? '';
}
