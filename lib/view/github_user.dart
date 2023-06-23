import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:github_rest_api/controller/github_user_controller.dart';
import 'package:github_rest_api/model/github_user_model.dart';
import 'package:github_rest_api/view/home.dart';
import 'package:github_rest_api/view/repository.dart';

class GithubUserPage extends StatefulWidget {
  final String? userName;

  const GithubUserPage({Key? key, required this.userName}) : super(key: key);

  @override
  _GithubUserPageState createState() => _GithubUserPageState();
}

class _GithubUserPageState extends State<GithubUserPage> {
  final GithubUserController _githubUserController =
      Get.put(GithubUserController());

  @override
  void initState() {
    super.initState();
    clearPreviousData();
    _githubUserController.fetchUser(widget.userName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'GitHub User',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white54),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Obx(
          () {
            if (_githubUserController.isLoading.value) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              final GithubUserModel? user = _githubUserController.user.value;
              return user != null
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 45,
                              backgroundImage:
                                  NetworkImage('${user.avatarUrl}'),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5.0),
                                    child: Text(
                                      '${user.name ?? 'N/A'}',
                                      style: TextStyle(
                                          color: Colors.white60,
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Text(
                                    '${user.login ?? 'N/A'}',
                                    style: TextStyle(
                                        color: Colors.white60, fontSize: 16),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Text(
                            '${user.bio ?? 'N/A'}',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white60,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Text(
                            '${user.location ?? 'N/A'}',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white60,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              '${user.followers ?? 'N/A'} followers',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white60,
                                  fontWeight: FontWeight.w400),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 5,
                                width: 5,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              '${user.following ?? 'N/A'} following',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white54,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            height: 30,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.white60,
                                borderRadius: BorderRadius.circular(6)),
                            child: InkWell(
                              onTap: () {
                                Get.to(
                                    () => RepositoryPage(userName: user.login));
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Repositories',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18),
                                    ),
                                    Text('${user.publicRepos ?? 'N/A'}')
                                  ],
                                ),
                              ),
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            height: 30,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.white54,
                                borderRadius: BorderRadius.circular(6)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Organizations',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18),
                                  ),
                                  Text('${user.company ?? 'N/A'}')
                                ],
                              ),
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            height: 30,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.white54,
                                borderRadius: BorderRadius.circular(6)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Twitter Account',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18),
                                  ),
                                  Text('${user.twitterUsername ?? 'N/A'}')
                                ],
                              ),
                            )),
                      ],
                    )
                  : _onNotFound(); // if user name not found
            }
          },
        ),
      ),
    );
  }

  void clearPreviousData() {
    Get.delete<
        GithubUserController>(); // Clear the instance of Github User Data
    // Clear any other instances or variables here
  }

  _onNotFound() {
    return Center(
      child: Container(
          height: MediaQuery.of(context).size.height * .4,
          width: MediaQuery.of(context).size.width * .70,
          //color: Colors.white54,
          child: Column(
            children: [
              Text(
                'User not found!!!',
                style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.white54),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Enter a valid user name',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white54),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    Get.to(() => HomePage());
                  },
                  child: Text("Tap to search again..."))
            ],
          )),
    );
  }
}
