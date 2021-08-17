import 'package:flutter/foundation.dart';

@immutable
class Coord {
  final double? lon;
  final double? lat;

  const Coord({this.lon, this.lat});

  @override
  String toString() => 'Coord(lon: $lon, lat: $lat)';

  factory Coord.fromJson(Map<String, dynamic> json) => Coord(
        lon: json['lon'] as double?,
        lat: json['lat'] as double?,
      );

  Map<String, dynamic> toJson() => {
        'lon': lon,
        'lat': lat,
      };

  Coord copyWith({
    double? lon,
    double? lat,
  }) {
    return Coord(
      lon: lon ?? this.lon,
      lat: lat ?? this.lat,
    );
  }
}
