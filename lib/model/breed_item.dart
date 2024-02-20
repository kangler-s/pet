class BreedItem {
  Weight? weight;
  String? id;
  String? name;
  String? cfaUrl;
  String? vetstreetUrl;
  String? vcahospitalsUrl;
  String? temperament;
  String? origin;
  String? countryCodes;
  String? countryCode;
  String? description;
  String? lifeSpan;
  int? indoor;
  int? lap;
  String? altNames;
  int? adaptability;
  int? affectionLevel;
  int? childFriendly;
  int? dogFriendly;
  int? energyLevel;
  int? grooming;
  int? healthIssues;
  int? intelligence;
  int? sheddingLevel;
  int? socialNeeds;
  int? strangerFriendly;
  int? vocalisation;
  int? experimental;
  int? hairless;
  int? natural;
  int? rare;
  int? rex;
  int? suppressedTail;
  int? shortLegs;
  String? wikipediaUrl;
  int? hypoallergenic;
  String? referenceImageId;
  ImageInfo? image;

  BreedItem(
      {this.weight,
      this.id,
      this.name,
      this.cfaUrl,
      this.vetstreetUrl,
      this.vcahospitalsUrl,
      this.temperament,
      this.origin,
      this.countryCodes,
      this.countryCode,
      this.description,
      this.lifeSpan,
      this.indoor,
      this.lap,
      this.altNames,
      this.adaptability,
      this.affectionLevel,
      this.childFriendly,
      this.dogFriendly,
      this.energyLevel,
      this.grooming,
      this.healthIssues,
      this.intelligence,
      this.sheddingLevel,
      this.socialNeeds,
      this.strangerFriendly,
      this.vocalisation,
      this.experimental,
      this.hairless,
      this.natural,
      this.rare,
      this.rex,
      this.suppressedTail,
      this.shortLegs,
      this.wikipediaUrl,
      this.hypoallergenic,
      this.referenceImageId,
      this.image});

  BreedItem.fromJson(Map<String, dynamic> json) {
    if (json["weight"] is Map) {
      weight = json["weight"] == null ? null : Weight.fromJson(json["weight"]);
    }
    if (json["id"] is String) {
      id = json["id"];
    }
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["cfa_url"] is String) {
      cfaUrl = json["cfa_url"];
    }
    if (json["vetstreet_url"] is String) {
      vetstreetUrl = json["vetstreet_url"];
    }
    if (json["vcahospitals_url"] is String) {
      vcahospitalsUrl = json["vcahospitals_url"];
    }
    if (json["temperament"] is String) {
      temperament = json["temperament"];
    }
    if (json["origin"] is String) {
      origin = json["origin"];
    }
    if (json["country_codes"] is String) {
      countryCodes = json["country_codes"];
    }
    if (json["country_code"] is String) {
      countryCode = json["country_code"];
    }
    if (json["description"] is String) {
      description = json["description"];
    }
    if (json["life_span"] is String) {
      lifeSpan = json["life_span"];
    }
    if (json["indoor"] is int) {
      indoor = json["indoor"];
    }
    if (json["lap"] is int) {
      lap = json["lap"];
    }
    if (json["alt_names"] is String) {
      altNames = json["alt_names"];
    }
    if (json["adaptability"] is int) {
      adaptability = json["adaptability"];
    }
    if (json["affection_level"] is int) {
      affectionLevel = json["affection_level"];
    }
    if (json["child_friendly"] is int) {
      childFriendly = json["child_friendly"];
    }
    if (json["dog_friendly"] is int) {
      dogFriendly = json["dog_friendly"];
    }
    if (json["energy_level"] is int) {
      energyLevel = json["energy_level"];
    }
    if (json["grooming"] is int) {
      grooming = json["grooming"];
    }
    if (json["health_issues"] is int) {
      healthIssues = json["health_issues"];
    }
    if (json["intelligence"] is int) {
      intelligence = json["intelligence"];
    }
    if (json["shedding_level"] is int) {
      sheddingLevel = json["shedding_level"];
    }
    if (json["social_needs"] is int) {
      socialNeeds = json["social_needs"];
    }
    if (json["stranger_friendly"] is int) {
      strangerFriendly = json["stranger_friendly"];
    }
    if (json["vocalisation"] is int) {
      vocalisation = json["vocalisation"];
    }
    if (json["experimental"] is int) {
      experimental = json["experimental"];
    }
    if (json["hairless"] is int) {
      hairless = json["hairless"];
    }
    if (json["natural"] is int) {
      natural = json["natural"];
    }
    if (json["rare"] is int) {
      rare = json["rare"];
    }
    if (json["rex"] is int) {
      rex = json["rex"];
    }
    if (json["suppressed_tail"] is int) {
      suppressedTail = json["suppressed_tail"];
    }
    if (json["short_legs"] is int) {
      shortLegs = json["short_legs"];
    }
    if (json["wikipedia_url"] is String) {
      wikipediaUrl = json["wikipedia_url"];
    }
    if (json["hypoallergenic"] is int) {
      hypoallergenic = json["hypoallergenic"];
    }
    if (json["reference_image_id"] is String) {
      referenceImageId = json["reference_image_id"];
    }
    if (json["image"] is Map) {
      image = json["image"] == null ? null : ImageInfo.fromJson(json["image"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (weight != null) {
      _data["weight"] = weight?.toJson();
    }
    _data["id"] = id;
    _data["name"] = name;
    _data["cfa_url"] = cfaUrl;
    _data["vetstreet_url"] = vetstreetUrl;
    _data["vcahospitals_url"] = vcahospitalsUrl;
    _data["temperament"] = temperament;
    _data["origin"] = origin;
    _data["country_codes"] = countryCodes;
    _data["country_code"] = countryCode;
    _data["description"] = description;
    _data["life_span"] = lifeSpan;
    _data["indoor"] = indoor;
    _data["lap"] = lap;
    _data["alt_names"] = altNames;
    _data["adaptability"] = adaptability;
    _data["affection_level"] = affectionLevel;
    _data["child_friendly"] = childFriendly;
    _data["dog_friendly"] = dogFriendly;
    _data["energy_level"] = energyLevel;
    _data["grooming"] = grooming;
    _data["health_issues"] = healthIssues;
    _data["intelligence"] = intelligence;
    _data["shedding_level"] = sheddingLevel;
    _data["social_needs"] = socialNeeds;
    _data["stranger_friendly"] = strangerFriendly;
    _data["vocalisation"] = vocalisation;
    _data["experimental"] = experimental;
    _data["hairless"] = hairless;
    _data["natural"] = natural;
    _data["rare"] = rare;
    _data["rex"] = rex;
    _data["suppressed_tail"] = suppressedTail;
    _data["short_legs"] = shortLegs;
    _data["wikipedia_url"] = wikipediaUrl;
    _data["hypoallergenic"] = hypoallergenic;
    _data["reference_image_id"] = referenceImageId;
    if (image != null) {
      _data["image"] = image?.toJson();
    }
    return _data;
  }
}

class ImageInfo {
  String? id;
  int? width;
  int? height;
  String? url;

  ImageInfo({this.id, this.width, this.height, this.url});

  ImageInfo.fromJson(Map<String, dynamic> json) {
    if (json["id"] is String) {
      id = json["id"];
    }
    if (json["width"] is int) {
      width = json["width"];
    }
    if (json["height"] is int) {
      height = json["height"];
    }
    if (json["url"] is String) {
      url = json["url"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["width"] = width;
    _data["height"] = height;
    _data["url"] = url;
    return _data;
  }
}

class Weight {
  String? imperial;
  String? metric;

  Weight({this.imperial, this.metric});

  Weight.fromJson(Map<String, dynamic> json) {
    if (json["imperial"] is String) {
      imperial = json["imperial"];
    }
    if (json["metric"] is String) {
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
