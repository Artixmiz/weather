import 'package:flutter/foundation.dart';

@immutable
class Wind {
  final double? speed;
  final int? deg;

  const Wind({this.speed, this.deg});

  @override
  String toString() => 'Wind(speed: $speed, deg: $deg)';

  factory Wind.fromJson(Map<String, dynamic> json) => Wind(
        speed: json['speed'] as double?,
        deg: json['deg'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'speed': speed,
        'deg': deg,
      };

  Wind copyWith({
    double? speed,
    int? deg,
  }) {
    return Wind(
      speed: speed ?? this.speed,
      deg: deg ?? this.deg,
    );
  }
}
