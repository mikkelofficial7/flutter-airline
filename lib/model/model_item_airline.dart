class Airline {
  int? id;
  String? name;
  String? country;
  String? logo;
  String? slogan;
  String? headQuaters;
  String? website;
  String? established;

  Airline(
      {this.id,
        this.name,
        this.country,
        this.logo,
        this.slogan,
        this.headQuaters,
        this.website,
        this.established});

  Airline.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    country = json['country'];
    logo = json['logo'];
    slogan = json['slogan'];
    headQuaters = json['head_quaters'];
    website = json['website'];
    established = json['established'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['country'] = this.country;
    data['logo'] = this.logo;
    data['slogan'] = this.slogan;
    data['head_quaters'] = this.headQuaters;
    data['website'] = this.website;
    data['established'] = this.established;
    return data;
  }
}