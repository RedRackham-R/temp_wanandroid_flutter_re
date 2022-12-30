import 'package:wanandroid_flutter_re/base/ext/CommonExt.dart';
import 'package:wanandroid_flutter_re/entity/article_tag_entity.dart';

import 'package:wanandroid_flutter_re/generated/json/base/json_field.dart';
import 'package:wanandroid_flutter_re/generated/json/article_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
class ArticleEntity {
  bool? adminAdd;
  String? apkLink;
  int? audit;
  String? author;
  bool? canEdit;
  int? chapterId;
  String? chapterName;
  bool? collect;
  int? courseId;
  String? desc;
  String? descMd;
  String? envelopePic;
  bool? fresh;
  String? host;
  int? id;
  bool? isAdminAdd;
  String? link;
  String? niceDate;
  String? niceShareDate;
  String? origin;
  String? prefix;
  String? projectLink;
  int? publishTime;
  int? realSuperChapterId;
  int? selfVisible;
  int? shareDate;
  String? shareUser;
  int? superChapterId;
  String? superChapterName;
  List<ArticleTagEntity>? tags;
  String? title;
  int? type;
  int? userId;
  int? visible;
  int? zan;
  int? originId;

  //是否增加收藏
  bool extIsCollecting = false;

  ArticleEntity();

  factory ArticleEntity.fromJson(Map<String, dynamic> json) =>
      $ArticleEntityFromJson(json);

  Map<String, dynamic> toJson() => $ArticleEntityToJson(this);

  bool isTop() => type == 1;

  ///判断是否是文章item 如果有图片就是项目item
  bool isProject() => !envelopePic.isNullOrEmpty();

  @override
  String toString() {
    return jsonEncode(this);
  }
}
