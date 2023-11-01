import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config/api_url.dart';
import '../model/get_current_user_info_model.dart';
import '../service/get_services.dart';

final getCurrentUserInfoProvider = FutureProvider.autoDispose<CurrentUserInfoModel>((ref) async {
  final apiService = ApiService();
  Response response;
  try {
    response = await apiService.get(url: ApiUrls.userInfo);
  } catch (e) {
    rethrow;
  }
  CurrentUserInfoModel currentUserInfoModel =
          CurrentUserInfoModel.fromMap(response.data);

  ref.read(userIdProvider.notifier).state = currentUserInfoModel;

  return currentUserInfoModel;
});

final userIdProvider = StateProvider<CurrentUserInfoModel>((ref) => CurrentUserInfoModel());