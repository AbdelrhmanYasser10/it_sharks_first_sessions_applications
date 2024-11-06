class GeocodingModel {
  double? latitude;
  String? lookupSource;
  double? longitude;
  String? localityLanguageRequested;
  String? continent;
  String? continentCode;
  String? countryName;
  String? countryCode;
  String? principalSubdivision;
  String? principalSubdivisionCode;
  String? city;
  String? locality;
  String? postcode;
  String? plusCode;
  Fips? fips;
  LocalityInfo? localityInfo;

  GeocodingModel(
      {this.latitude,
        this.lookupSource,
        this.longitude,
        this.localityLanguageRequested,
        this.continent,
        this.continentCode,
        this.countryName,
        this.countryCode,
        this.principalSubdivision,
        this.principalSubdivisionCode,
        this.city,
        this.locality,
        this.postcode,
        this.plusCode,
        this.fips,
        this.localityInfo});

  GeocodingModel.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    lookupSource = json['lookupSource'];
    longitude = json['longitude'];
    localityLanguageRequested = json['localityLanguageRequested'];
    continent = json['continent'];
    continentCode = json['continentCode'];
    countryName = json['countryName'];
    countryCode = json['countryCode'];
    principalSubdivision = json['principalSubdivision'];
    principalSubdivisionCode = json['principalSubdivisionCode'];
    city = json['city'];
    locality = json['locality'];
    postcode = json['postcode'];
    plusCode = json['plusCode'];
    fips = json['fips'] != null ? new Fips.fromJson(json['fips']) : null;
    localityInfo = json['localityInfo'] != null
        ? new LocalityInfo.fromJson(json['localityInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['latitude'] = this.latitude;
    data['lookupSource'] = this.lookupSource;
    data['longitude'] = this.longitude;
    data['localityLanguageRequested'] = this.localityLanguageRequested;
    data['continent'] = this.continent;
    data['continentCode'] = this.continentCode;
    data['countryName'] = this.countryName;
    data['countryCode'] = this.countryCode;
    data['principalSubdivision'] = this.principalSubdivision;
    data['principalSubdivisionCode'] = this.principalSubdivisionCode;
    data['city'] = this.city;
    data['locality'] = this.locality;
    data['postcode'] = this.postcode;
    data['plusCode'] = this.plusCode;
    if (this.fips != null) {
      data['fips'] = this.fips!.toJson();
    }
    if (this.localityInfo != null) {
      data['localityInfo'] = this.localityInfo!.toJson();
    }
    return data;
  }
}

class Fips {
  String? state;
  String? county;
  String? countySubdivision;
  String? place;

  Fips({this.state, this.county, this.countySubdivision, this.place});

  Fips.fromJson(Map<String, dynamic> json) {
    state = json['state'];
    county = json['county'];
    countySubdivision = json['countySubdivision'];
    place = json['place'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['state'] = this.state;
    data['county'] = this.county;
    data['countySubdivision'] = this.countySubdivision;
    data['place'] = this.place;
    return data;
  }
}

class LocalityInfo {
  List<Administrative>? administrative;
  List<Informative>? informative;

  LocalityInfo({this.administrative, this.informative});

  LocalityInfo.fromJson(Map<String, dynamic> json) {
    if (json['administrative'] != null) {
      administrative = <Administrative>[];
      json['administrative'].forEach((v) {
        administrative!.add(new Administrative.fromJson(v));
      });
    }
    if (json['informative'] != null) {
      informative = <Informative>[];
      json['informative'].forEach((v) {
        informative!.add(new Informative.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.administrative != null) {
      data['administrative'] =
          this.administrative!.map((v) => v.toJson()).toList();
    }
    if (this.informative != null) {
      data['informative'] = this.informative!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Administrative {
  String? name;
  String? description;
  String? isoName;
  int? order;
  int? adminLevel;
  String? isoCode;
  String? wikidataId;
  int? geonameId;

  Administrative(
      {this.name,
        this.description,
        this.isoName,
        this.order,
        this.adminLevel,
        this.isoCode,
        this.wikidataId,
        this.geonameId});

  Administrative.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    isoName = json['isoName'];
    order = json['order'];
    adminLevel = json['adminLevel'];
    isoCode = json['isoCode'];
    wikidataId = json['wikidataId'];
    geonameId = json['geonameId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    data['isoName'] = this.isoName;
    data['order'] = this.order;
    data['adminLevel'] = this.adminLevel;
    data['isoCode'] = this.isoCode;
    data['wikidataId'] = this.wikidataId;
    data['geonameId'] = this.geonameId;
    return data;
  }
}

class Informative {
  String? name;
  String? description;
  String? isoName;
  int? order;
  String? isoCode;
  String? wikidataId;
  int? geonameId;

  Informative(
      {this.name,
        this.description,
        this.isoName,
        this.order,
        this.isoCode,
        this.wikidataId,
        this.geonameId});

  Informative.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    isoName = json['isoName'];
    order = json['order'];
    isoCode = json['isoCode'];
    wikidataId = json['wikidataId'];
    geonameId = json['geonameId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    data['isoName'] = this.isoName;
    data['order'] = this.order;
    data['isoCode'] = this.isoCode;
    data['wikidataId'] = this.wikidataId;
    data['geonameId'] = this.geonameId;
    return data;
  }
}