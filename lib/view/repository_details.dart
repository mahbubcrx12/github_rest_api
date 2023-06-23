import 'package:flutter/material.dart';
import 'package:github_rest_api/view/home.dart';
import 'package:jiffy/jiffy.dart';
import 'package:github_rest_api/model/repo_model.dart';
import 'package:get/get.dart';

class RepoDetails extends StatelessWidget {
  final RepositoryModel repo;
  final String name, createdDate, language;
  final bool? isPrivate;
  const RepoDetails(
      {super.key,
      required this.name,
      required this.createdDate,
      required this.language,
      required this.isPrivate,
      required this.repo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Repository Details',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white54),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "${name}",
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Created At: ',
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      Jiffy.parse('${createdDate}').yMMMMEEEEdjm,
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                )),
            Text(
              "ID: ${repo.id}",
              style: TextStyle(
                color: Colors.white54,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              "Description: ${repo.description}",
              style: TextStyle(
                color: Colors.white54,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              "Programming Language: ${language}",
              style: TextStyle(
                color: Colors.white54,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              "Forks: ${repo.forks}",
              style: TextStyle(
                color: Colors.white54,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              "Forks Count: ${repo.forksCount}",
              style: TextStyle(
                color: Colors.white54,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              "Watcher: ${repo.watchers}",
              style: TextStyle(
                color: Colors.white54,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              "Watcher count: ${repo.watchersCount}",
              style: TextStyle(
                color: Colors.white54,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          
          Get.to(() => HomePage());
        },
        child: Icon(
          Icons.home,
          color: Colors.blueAccent,
          size: 30,
        ),
      ),
    );
  }
}
