import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';

ScanModel scanModelFromJson(String str) => ScanModel.fromJson(json.decode(str));

String scanModelToJson(ScanModel data) => json.encode(data.toJson());

class ScanModel {
    ScanModel({
        this.type,
        required this.value,
    }) {
      if(value.contains('http')) {
        type = 'http';
      } else {
        type = 'geo';
      }
    }

    String? id;
    String? type;
    String value;

    LatLng getLatLng() {

      final latLng = value.substring(4).split(',');
      final lat = double.parse(latLng[0]);
      final lng = double.parse(latLng[1]);

      return LatLng(lat, lng);

    }

    factory ScanModel.fromJson(Map<String, dynamic> json) => ScanModel(
        type: json["type"],
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "value": value,
    };
}
