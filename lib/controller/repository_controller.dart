import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:github_rest_api/model/repo_model.dart';
import 'package:github_rest_api/constant_values/api.dart';

class RepositoryController extends GetxController {
  final Dio _dio = Dio();

  final Rx<List<RepositoryModel>?> repository =
      Rx<List<RepositoryModel>?>(null);
  final RxBool isLoading = RxBool(false);

  Future<void> fetchRepository(String? userName) async {
    try {
      isLoading.value = true;

      _dio.options.headers['Authorization'] = 'Bearer $accessToken';

      final response =
          await _dio.get('https://api.github.com/users/$userName/repos');
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = response.data; // Cast to a List<dynamic>

        // Map the list of JSON data to RepositoryModel objects
        final List<RepositoryModel> repos =
            jsonData.map((json) => RepositoryModel.fromJson(json)).toList();

        repository.value = repos;
        print('kkkkkkkkkkkkkkkkk');
        print(repository); // Assign the list to repository.value
      }
    } catch (error) {
      // Handle error
    } finally {
      isLoading.value = false;
    }
  }
}
