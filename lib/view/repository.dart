import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:github_rest_api/controller/repository_controller.dart';
import 'package:github_rest_api/model/repo_model.dart';
import 'package:github_rest_api/view/home.dart';
import 'package:github_rest_api/view/repository_details.dart';
import 'package:jiffy/jiffy.dart';

class RepositoryPage extends StatefulWidget {
  final String? userName;
  const RepositoryPage({Key? key, required this.userName}) : super(key: key);
  @override
  _RepositoryPageState createState() => _RepositoryPageState();
}

class _RepositoryPageState extends State<RepositoryPage> {
  final RepositoryController _repositoryController =
      Get.put(RepositoryController());

  bool isList = true;

  @override
  void initState() {
    super.initState();
    clearPreviousData();
    _repositoryController.fetchRepository(widget.userName);
  }

  void clearPreviousData() {
    Get.delete<
        RepositoryController>(); // Clear the instance of Repository controller
    // Clear any other instances or variables here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Repositories',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white54),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: TextButton(
                onPressed: () {
                  setState(() {
                    isList = !isList;
                  });
                },
                child: isList ? Text('Grid') : Text('List')),
          )
        ],
      ),
      body: isList == true ? _listView() : _gridView(),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.search_sharp,color: Colors.red,),
          onPressed: () {
            Get.to(() => HomePage());
          }),
    );
  }

  _listView() {
    return Obx(() {
      if (_repositoryController.isLoading.value) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else if (_repositoryController.repository.value == null) {
        return Center(
          child: _onNotFound(),
        );
      } else {
        final List<RepositoryModel> repositories =
            _repositoryController.repository.value!;
        return ListView.builder(
          shrinkWrap: true,
          itemCount: repositories.length,
          itemBuilder: (context, index) {
            final RepositoryModel repo = repositories[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
              child: InkWell(
                onTap: () {
                  Get.to(() => RepoDetails(
                      repo: repo,
                      name: repo.name.toString(),
                      createdDate: repo.createdAt.toString(),
                      language: repo.language.toString(),
                      isPrivate: repo.private));
                },
                child: Container(
                  color: Colors.black12,
                  child: ListTile(
                    title: Text(
                      '${repo.name}',
                      style: TextStyle(
                          color: Colors.white54,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 4,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(Jiffy.parse('${repo.pushedAt}').yMMMMEEEEdjm),
                            Text('${repo.visibility}'),
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Container(
                            width: 300,
                            child: Text(
                              '${repo.description}',
                            )),
                        SizedBox(
                          height: 4,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${repo.language}',
                              style: TextStyle(color: Colors.redAccent),
                            ),
                            Text('${repo.defaultBranch}')
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }
    });
  }

  _gridView() {
    return Obx(() {
      if (_repositoryController.isLoading.value) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else if (_repositoryController.repository.value == null) {
        return Center(
          child: _onNotFound(),
        );
      } else {
        final List<RepositoryModel> repositories =
            _repositoryController.repository.value!;
        return GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: repositories.length,
          itemBuilder: (context, index) {
            final RepositoryModel repo = repositories[index];
            return InkWell(
              onTap: () {
                Get.to(() => RepoDetails(
                    repo: repo,
                    name: repo.name.toString(),
                    createdDate: repo.createdAt.toString(),
                    language: repo.language.toString(),
                    isPrivate: repo.private));
              },
              child: Container(
                color: Colors.black12,
                child: ListTile(
                  title: Text(
                    '${repo.name}',
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                              child: Text(Jiffy.parse('${repo.pushedAt}')
                                  .yMMMMEEEEdjm)),
                          Text('${repo.visibility}'),
                        ],
                      ),
                      SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${repo.language}',
                            style: TextStyle(color: Colors.redAccent),
                          ),
                          Text('${repo.defaultBranch}'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }
    });
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
                'Repository not found!!!',
                style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.white54),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Try another user name',
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
