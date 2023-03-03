// Reference from:
// https://levelup.gitconnected.com/flutter-app-from-scratch-part-2-define-models-and-set-up-database-78a67666527a

import 'model_data_airline.dart';

class ListAirline {
  int? totalPassengers;
  int? totalPages;
  List<Data>? data;

  ListAirline({this.totalPassengers, this.totalPages, this.data});

  ListAirline.fromJson(Map<String, dynamic> json) {
    totalPassengers = json['totalPassengers'];
    totalPages = json['totalPages'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalPassengers'] = this.totalPassengers;
    data['totalPages'] = this.totalPages;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}