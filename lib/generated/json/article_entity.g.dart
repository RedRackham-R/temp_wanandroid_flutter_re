import 'package:wanandroid_flutter_re/generated/json/base/json_convert_content.dart';
import 'package:wanandroid_flutter_re/entity/article_entity.dart';
import 'package:wanandroid_flutter_re/entity/article_tag_entity.dart';


ArticleEntity $ArticleEntityFromJson(Map<String, dynamic> json) {
	final ArticleEntity articleEntity = ArticleEntity();
	final bool? adminAdd = jsonConvert.convert<bool>(json['adminAdd']);
	if (adminAdd != null) {
		articleEntity.adminAdd = adminAdd;
	}
	final String? apkLink = jsonConvert.convert<String>(json['apkLink']);
	if (apkLink != null) {
		articleEntity.apkLink = apkLink;
	}
	final int? audit = jsonConvert.convert<int>(json['audit']);
	if (audit != null) {
		articleEntity.audit = audit;
	}
	final String? author = jsonConvert.convert<String>(json['author']);
	if (author != null) {
		articleEntity.author = author;
	}
	final bool? canEdit = jsonConvert.convert<bool>(json['canEdit']);
	if (canEdit != null) {
		articleEntity.canEdit = canEdit;
	}
	final int? chapterId = jsonConvert.convert<int>(json['chapterId']);
	if (chapterId != null) {
		articleEntity.chapterId = chapterId;
	}
	final String? chapterName = jsonConvert.convert<String>(json['chapterName']);
	if (chapterName != null) {
		articleEntity.chapterName = chapterName;
	}
	final bool? collect = jsonConvert.convert<bool>(json['collect']);
	if (collect != null) {
		articleEntity.collect = collect;
	}
	final int? courseId = jsonConvert.convert<int>(json['courseId']);
	if (courseId != null) {
		articleEntity.courseId = courseId;
	}
	final String? desc = jsonConvert.convert<String>(json['desc']);
	if (desc != null) {
		articleEntity.desc = desc;
	}
	final String? descMd = jsonConvert.convert<String>(json['descMd']);
	if (descMd != null) {
		articleEntity.descMd = descMd;
	}
	final String? envelopePic = jsonConvert.convert<String>(json['envelopePic']);
	if (envelopePic != null) {
		articleEntity.envelopePic = envelopePic;
	}
	final bool? fresh = jsonConvert.convert<bool>(json['fresh']);
	if (fresh != null) {
		articleEntity.fresh = fresh;
	}
	final String? host = jsonConvert.convert<String>(json['host']);
	if (host != null) {
		articleEntity.host = host;
	}
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		articleEntity.id = id;
	}
	final bool? isAdminAdd = jsonConvert.convert<bool>(json['isAdminAdd']);
	if (isAdminAdd != null) {
		articleEntity.isAdminAdd = isAdminAdd;
	}
	final String? link = jsonConvert.convert<String>(json['link']);
	if (link != null) {
		articleEntity.link = link;
	}
	final String? niceDate = jsonConvert.convert<String>(json['niceDate']);
	if (niceDate != null) {
		articleEntity.niceDate = niceDate;
	}
	final String? niceShareDate = jsonConvert.convert<String>(json['niceShareDate']);
	if (niceShareDate != null) {
		articleEntity.niceShareDate = niceShareDate;
	}
	final String? origin = jsonConvert.convert<String>(json['origin']);
	if (origin != null) {
		articleEntity.origin = origin;
	}
	final String? prefix = jsonConvert.convert<String>(json['prefix']);
	if (prefix != null) {
		articleEntity.prefix = prefix;
	}
	final String? projectLink = jsonConvert.convert<String>(json['projectLink']);
	if (projectLink != null) {
		articleEntity.projectLink = projectLink;
	}
	final int? publishTime = jsonConvert.convert<int>(json['publishTime']);
	if (publishTime != null) {
		articleEntity.publishTime = publishTime;
	}
	final int? realSuperChapterId = jsonConvert.convert<int>(json['realSuperChapterId']);
	if (realSuperChapterId != null) {
		articleEntity.realSuperChapterId = realSuperChapterId;
	}
	final int? selfVisible = jsonConvert.convert<int>(json['selfVisible']);
	if (selfVisible != null) {
		articleEntity.selfVisible = selfVisible;
	}
	final int? shareDate = jsonConvert.convert<int>(json['shareDate']);
	if (shareDate != null) {
		articleEntity.shareDate = shareDate;
	}
	final String? shareUser = jsonConvert.convert<String>(json['shareUser']);
	if (shareUser != null) {
		articleEntity.shareUser = shareUser;
	}
	final int? superChapterId = jsonConvert.convert<int>(json['superChapterId']);
	if (superChapterId != null) {
		articleEntity.superChapterId = superChapterId;
	}
	final String? superChapterName = jsonConvert.convert<String>(json['superChapterName']);
	if (superChapterName != null) {
		articleEntity.superChapterName = superChapterName;
	}
	final List<ArticleTagEntity>? tags = jsonConvert.convertListNotNull<ArticleTagEntity>(json['tags']);
	if (tags != null) {
		articleEntity.tags = tags;
	}
	final String? title = jsonConvert.convert<String>(json['title']);
	if (title != null) {
		articleEntity.title = title;
	}
	final int? type = jsonConvert.convert<int>(json['type']);
	if (type != null) {
		articleEntity.type = type;
	}
	final int? userId = jsonConvert.convert<int>(json['userId']);
	if (userId != null) {
		articleEntity.userId = userId;
	}
	final int? visible = jsonConvert.convert<int>(json['visible']);
	if (visible != null) {
		articleEntity.visible = visible;
	}
	final int? zan = jsonConvert.convert<int>(json['zan']);
	if (zan != null) {
		articleEntity.zan = zan;
	}
	final int? originId = jsonConvert.convert<int>(json['originId']);
	if (originId != null) {
		articleEntity.originId = originId;
	}
	final bool? extIsCollecting = jsonConvert.convert<bool>(json['extIsCollecting']);
	if (extIsCollecting != null) {
		articleEntity.extIsCollecting = extIsCollecting;
	}
	return articleEntity;
}

Map<String, dynamic> $ArticleEntityToJson(ArticleEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['adminAdd'] = entity.adminAdd;
	data['apkLink'] = entity.apkLink;
	data['audit'] = entity.audit;
	data['author'] = entity.author;
	data['canEdit'] = entity.canEdit;
	data['chapterId'] = entity.chapterId;
	data['chapterName'] = entity.chapterName;
	data['collect'] = entity.collect;
	data['courseId'] = entity.courseId;
	data['desc'] = entity.desc;
	data['descMd'] = entity.descMd;
	data['envelopePic'] = entity.envelopePic;
	data['fresh'] = entity.fresh;
	data['host'] = entity.host;
	data['id'] = entity.id;
	data['isAdminAdd'] = entity.isAdminAdd;
	data['link'] = entity.link;
	data['niceDate'] = entity.niceDate;
	data['niceShareDate'] = entity.niceShareDate;
	data['origin'] = entity.origin;
	data['prefix'] = entity.prefix;
	data['projectLink'] = entity.projectLink;
	data['publishTime'] = entity.publishTime;
	data['realSuperChapterId'] = entity.realSuperChapterId;
	data['selfVisible'] = entity.selfVisible;
	data['shareDate'] = entity.shareDate;
	data['shareUser'] = entity.shareUser;
	data['superChapterId'] = entity.superChapterId;
	data['superChapterName'] = entity.superChapterName;
	data['tags'] =  entity.tags?.map((v) => v.toJson()).toList();
	data['title'] = entity.title;
	data['type'] = entity.type;
	data['userId'] = entity.userId;
	data['visible'] = entity.visible;
	data['zan'] = entity.zan;
	data['originId'] = entity.originId;
	data['extIsCollecting'] = entity.extIsCollecting;
	return data;
}