class ConfiguracoesModel {
  final List<String> changeKeys;
  final ImagesModel images;

  ConfiguracoesModel.fromJson(Map<String, dynamic> json)
      : changeKeys = List.from(json['change_keys']),
        images = ImagesModel.fromJson(json['images']);
}

class ImagesModel {
  final String baseUrl;
  final String secureBaseUrl;
  final List<String> backdropSizes;
  final List<String> logoSizes;
  final List<String> posterSizes;
  final List<String> profileSizes;
  final List<String> stillSizes;

  ImagesModel.fromJson(Map<String, dynamic> json)
      : baseUrl = json['base_url'],
        secureBaseUrl = json['secure_base_url'],
        backdropSizes = List.from(json['backdrop_sizes']),
        logoSizes = List.from(json['logo_sizes']),
        posterSizes = List.from(json['poster_sizes']),
        profileSizes = List.from(json['profile_sizes']),
        stillSizes = List.from(json['still_sizes']);
}
