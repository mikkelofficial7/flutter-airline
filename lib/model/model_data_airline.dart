import 'model_item_airline.dart';

class Data {
  String? sId;
  String? name;
  int? trips;
  List<Airline>? airline;
  int? iV;

  Data({this.sId, this.name, this.trips, this.airline, this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    trips = json['trips'];
    if (json['airline'] != null) {
      airline = <Airline>[];
      json['airline'].forEach((v) {
        airline!.add(new Airline.fromJson(v));
      });
    }
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['trips'] = this.trips;
    if (this.airline != null) {
      data['airline'] = this.airline!.map((v) => v.toJson()).toList();
    }
    data['__v'] = this.iV;
    return data;
  }
}