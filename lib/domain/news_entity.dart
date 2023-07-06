import 'package:json_annotation/json_annotation.dart';

part 'news_entity.g.dart';

@JsonSerializable()
class NewsEntity {
  final String? by;
  final int? descendants;
  final int? id;
  final List<int>? kids;
  final int? score;
  final int? time;
  final String? title;
  final String? type;
  final String? url;

  NewsEntity({
    this.by,
    this.descendants,
    this.id,
    this.kids,
    this.score,
    this.time,
    this.title,
    this.type,
    this.url,
  });

  factory NewsEntity.fromJson(Map<String, dynamic> json) =>
      _$NewsEntityFromJson(json);

  Map<String, dynamic> toJson() => _$NewsEntityToJson(this);
}
