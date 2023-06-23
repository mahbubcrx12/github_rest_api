import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:github_rest_api/theme/theme_controller.dart';
import 'package:github_rest_api/view/github_user.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:flutter/cupertino.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController userNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isDarkMode = false;
  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;
  String? userName = '';

  @override
  void initState() {
    // TODO: implement initState

    getConnectivity();
    super.initState();
  }

  getConnectivity() =>
      subscription = Connectivity().onConnectivityChanged.listen(
        (ConnectivityResult result) async {
          isDeviceConnected = await InternetConnectionChecker().hasConnection;
          if (!isDeviceConnected && isAlertSet == false) {
            showDialogBox();
            setState(() => isAlertSet = true);
          }
        },
      );

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    userNameController.dispose();
    subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    userNameController.clear();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Welcome to github',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                ThemeController themeController = Get.find();
                themeController.toggleTheme();
                setState(() {
                  isDarkMode = !isDarkMode; // Update the theme mode variable
                });
              },
              child: Icon(
                Icons.sunny,
                size: 25,
                color: isDarkMode ? Colors.yellow : Colors.black,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 50,
            ),
            CircleAvatar(
              radius: 100,
              backgroundImage: NetworkImage(
                  'https://cdn.freebiesupply.com/logos/thumbs/1x/github-icon-1-logo.png'),
            ),
            SizedBox(
              height: 60,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Form(
                key: _formKey,
                child: TextFormField(
                    controller: userNameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter username';
                      }
                    },
                    onChanged: (val) {
                      userName = val;
                    },
                    decoration: InputDecoration(
                      hintText: 'github username',
                      hintStyle:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                      filled: true,
                      fillColor: Colors.white54,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueGrey),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    )),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Get.to(() => GithubUserPage(
                        userName: userName,
                      ));
                }
              },
              child: Text(
                'Search',
                style: TextStyle(fontSize: 25),
              ),
              style: ElevatedButton.styleFrom(
                  primary: Colors.blue.withOpacity(.6)),
            )
          ],
        ),
      ),
    );
  }

  showDialogBox() => showCupertinoDialog<String>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('No Connection'),
          content: const Text('Please check your internet connectivity'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.pop(context, 'Cancel');
                setState(() => isAlertSet = false);
                isDeviceConnected =
                    await InternetConnectionChecker().hasConnection;
                if (!isDeviceConnected && isAlertSet == false) {
                  showDialogBox();
                  setState(() => isAlertSet = true);
                }
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
}
