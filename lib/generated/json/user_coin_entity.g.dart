import 'package:wanandroid_flutter_re/generated/json/base/json_convert_content.dart';
import 'package:wanandroid_flutter_re/entity/user_coin_entity.dart';

UserCoinEntity $UserCoinEntityFromJson(Map<String, dynamic> json) {
	final UserCoinEntity userCoinEntity = UserCoinEntity();
	final int? coinCount = jsonConvert.convert<int>(json['coinCount']);
	if (coinCount != null) {
		userCoinEntity.coinCount = coinCount;
	}
	final int? level = jsonConvert.convert<int>(json['level']);
	if (level != null) {
		userCoinEntity.level = level;
	}
	final String? nickname = jsonConvert.convert<String>(json['nickname']);
	if (nickname != null) {
		userCoinEntity.nickname = nickname;
	}
	final String? rank = jsonConvert.convert<String>(json['rank']);
	if (rank != null) {
		userCoinEntity.rank = rank;
	}
	final int? userId = jsonConvert.convert<int>(json['userId']);
	if (userId != null) {
		userCoinEntity.userId = userId;
	}
	final String? username = jsonConvert.convert<String>(json['username']);
	if (username != null) {
		userCoinEntity.username = username;
	}
	return userCoinEntity;
}

Map<String, dynamic> $UserCoinEntityToJson(UserCoinEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['coinCount'] = entity.coinCount;
	data['level'] = entity.level;
	data['nickname'] = entity.nickname;
	data['rank'] = entity.rank;
	data['userId'] = entity.userId;
	data['username'] = entity.username;
	return data;
}