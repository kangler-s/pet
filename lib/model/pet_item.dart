class PetItem {
  String? id;
  String? url;
  int? width;
  int? height;
  String? mimeType;
  List<Breeds>? breeds;
  List<dynamic>? categories;

  PetItem(
      {this.id,
      this.url,
      this.width,
      this.height,
      this.mimeType,
      this.breeds,
      this.categories});

  PetItem.fromJson(Map<String, dynamic> json) {
    if (json["id"] is String) {
      id = json["id"];
    }
    if (json["url"] is String) {
      url = json["url"];
    }
    if (json["width"] is int) {
      width = json["width"];
    }
    if (json["height"] is int) {
      height = json["height"];
    }
    if (json["mime_type"] is String) {
      mimeType = json["mime_type"];
    }
    if (json["breeds"] is List) {
      breeds = json["breeds"] == null
          ? null
          : (json["breeds"] as List).map((e) => Breeds.fromJson(e)).toList();
    }
    if (json["categories"] is List) {
      categories = json["categories"] ?? [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["url"] = url;
    _data["width"] = width;
    _data["height"] = height;
    _data["mime_type"] = mimeType;
    if (breeds != null) {
      _data["breeds"] = breeds?.map((e) => e.toJson()).toList();
    }
    if (categories != null) {
      _data["categories"] = categories;
    }
    return _data;
  }
}

class Breeds {
  int? id;
  String? name;
  String? weight;
  String? height;
  String? lifeSpan;
  String? breedGroup;

  Breeds(
      {this.id,
      this.name,
      this.weight,
      this.height,
      this.lifeSpan,
      this.breedGroup});

  Breeds.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) {
      id = json["id"];
    }
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["weight"] is String) {
      weight = json["weight"];
    }
    if (json["height"] is String) {
      height = json["height"];
    }
    if (json["life_span"] is String) {
      lifeSpan = json["life_span"];
    }
    if (json["breed_group"] is String) {
      breedGroup = json["breed_group"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["name"] = name;
    _data["weight"] = weight;
    _data["height"] = height;
    _data["life_span"] = lifeSpan;
    _data["breed_group"] = breedGroup;
    return _data;
  }
}
