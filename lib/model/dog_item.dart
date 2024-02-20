
class DogItem {
  List<Breeds>? breeds;
  String? id;
  String? url;
  int? width;
  int? height;

  DogItem({this.breeds, this.id, this.url, this.width, this.height});

  DogItem.fromJson(Map<String, dynamic> json) {
    if(json["breeds"] is List) {
      breeds = json["breeds"] == null ? null : (json["breeds"] as List).map((e) => Breeds.fromJson(e)).toList();
    }
    if(json["id"] is String) {
      id = json["id"];
    }
    if(json["url"] is String) {
      url = json["url"];
    }
    if(json["width"] is int) {
      width = json["width"];
    }
    if(json["height"] is int) {
      height = json["height"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if(breeds != null) {
      _data["breeds"] = breeds?.map((e) => e.toJson()).toList();
    }
    _data["id"] = id;
    _data["url"] = url;
    _data["width"] = width;
    _data["height"] = height;
    return _data;
  }
}

class Breeds {
  Weight? weight;
  Height? height;
  int? id;
  String? name;
  String? countryCode;
  String? bredFor;
  String? lifeSpan;
  String? temperament;
  String? referenceImageId;

  Breeds({this.weight, this.height, this.id, this.name, this.countryCode, this.bredFor, this.lifeSpan, this.temperament, this.referenceImageId});

  Breeds.fromJson(Map<String, dynamic> json) {
    if(json["weight"] is Map) {
      weight = json["weight"] == null ? null : Weight.fromJson(json["weight"]);
    }
    if(json["height"] is Map) {
      height = json["height"] == null ? null : Height.fromJson(json["height"]);
    }
    if(json["id"] is int) {
      id = json["id"];
    }
    if(json["name"] is String) {
      name = json["name"];
    }
    if(json["country_code"] is String) {
      countryCode = json["country_code"];
    }
    if(json["bred_for"] is String) {
      bredFor = json["bred_for"];
    }
    if(json["life_span"] is String) {
      lifeSpan = json["life_span"];
    }
    if(json["temperament"] is String) {
      temperament = json["temperament"];
    }
    if(json["reference_image_id"] is String) {
      referenceImageId = json["reference_image_id"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if(weight != null) {
      _data["weight"] = weight?.toJson();
    }
    if(height != null) {
      _data["height"] = height?.toJson();
    }
    _data["id"] = id;
    _data["name"] = name;
    _data["country_code"] = countryCode;
    _data["bred_for"] = bredFor;
    _data["life_span"] = lifeSpan;
    _data["temperament"] = temperament;
    _data["reference_image_id"] = referenceImageId;
    return _data;
  }
}

class Height {
  String? imperial;
  String? metric;

  Height({this.imperial, this.metric});

  Height.fromJson(Map<String, dynamic> json) {
    if(json["imperial"] is String) {
      imperial = json["imperial"];
    }
    if(json["metric"] is String) {
      metric = json["metric"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["imperial"] = imperial;
    _data["metric"] = metric;
    return _data;
  }
}

class Weight {
  String? imperial;
  String? metric;

  Weight({this.imperial, this.metric});

  Weight.fromJson(Map<String, dynamic> json) {
    if(json["imperial"] is String) {
      imperial = json["imperial"];
    }
    if(json["metric"] is String) {
      metric = json["metric"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["imperial"] = imperial;
    _data["metric"] = metric;
    return _data;
  }
}