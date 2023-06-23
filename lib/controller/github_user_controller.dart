import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:github_rest_api/model/github_user_model.dart';
import 'package:github_rest_api/constant_values/api.dart';

class GithubUserController extends GetxController {
  final Dio _dio = Dio();


  late final Rx<GithubUserModel?> user = Rx<GithubUserModel?>(null);
  late final RxBool isLoading = RxBool(false);

  Future<void> fetchUser(String? username) async {
    try {
      isLoading.value = true;

      // Set the token in the request headers
      _dio.options.headers['Authorization'] = 'Bearer $accessToken';

      final response = await _dio.get('https://api.github.com/users/$username');
      if (response.statusCode == 200) {
        print('sssssssssssssssssss');
        print(response.statusCode);
        final jsonData = response.data as Map<String, dynamic>;
        user.value = GithubUserModel.fromJson(jsonData);
      }
    } catch (error) {
      // Handle error
    } finally {
      isLoading.value = false;
    }
    print("ggggggggggggggggggggggggg");
    print(user);
  }
}