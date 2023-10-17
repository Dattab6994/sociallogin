class BeerModel {
  int? id;
  String? name;
  String? tagline;
  String? firstBrewed;
  String? description;
  String? imageUrl;
  Volume? volume;
  Volume? boilVolume;
  List<String>? foodPairing;
  String? brewersTips;
  String? contributedBy;

  BeerModel(
      {this.id,
      this.name,
      this.tagline,
      this.firstBrewed,
      this.description,
      this.imageUrl,
      this.volume,
      this.boilVolume,
      this.foodPairing,
      this.brewersTips,
      this.contributedBy});

  BeerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    tagline = json['tagline'];
    firstBrewed = json['first_brewed'];
    description = json['description'];
    imageUrl = json['image_url'];
    volume =
        json['volume'] != null ? new Volume.fromJson(json['volume']) : null;
    boilVolume = json['boil_volume'] != null
        ? new Volume.fromJson(json['boil_volume'])
        : null;
    foodPairing = json['food_pairing'].cast<String>();
    brewersTips = json['brewers_tips'];
    contributedBy = json['contributed_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['tagline'] = this.tagline;
    data['first_brewed'] = this.firstBrewed;
    data['description'] = this.description;
    data['image_url'] = this.imageUrl;
    if (this.volume != null) {
      data['volume'] = this.volume!.toJson();
    }
    if (this.boilVolume != null) {
      data['boil_volume'] = this.boilVolume!.toJson();
    }
    data['food_pairing'] = this.foodPairing;
    data['brewers_tips'] = this.brewersTips;
    data['contributed_by'] = this.contributedBy;
    return data;
  }
}

class Volume {
  int? value;
  String? unit;

  Volume({this.value, this.unit});

  Volume.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    unit = json['unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['unit'] = this.unit;
    return data;
  }
}
