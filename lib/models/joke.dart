import 'package:json_annotation/json_annotation.dart';

part 'joke.g.dart';

@JsonSerializable()
class Joke {

  Joke({required this.id, required this.value, this.url});

  factory Joke.fromJson(Map<String, dynamic> json) => _$JokeFromJson(json);
  final String id, value;
  final String? url;

  Map<String, dynamic> toJson() => _$JokeToJson(this);
}
