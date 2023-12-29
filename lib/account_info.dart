import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/widgets/appbar.dart';

class AccountInfo extends StatefulWidget {
  const AccountInfo({super.key});

  @override
  State<AccountInfo> createState() => _AccountInfoState();
}

class _AccountInfoState extends State<AccountInfo> {
  late String userName = '';
  late String userMail = '';
  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('user_name') ?? '';
      userMail = prefs.getString('user_email') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: MyAppBar(title: 'Account Info'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(),
            Row(
              children: [
                Spacer(),
                Stack(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.deepOrange,
                      radius: 70,
                      backgroundImage: NetworkImage(
                          'https://clipart-library.com/images/pi5dn47BT.jpg'),
                    ),
                    Positioned(
                      child: Icon(Icons.add_a_photo),
                      bottom: 5,
                      right: 5,
                    )
                  ],
                ),
                Spacer(),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.deepOrange, width: 1)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        'User Name:',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        userName,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.edit,
                      size: 16,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.deepOrange, width: 1)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        'Email:',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        userMail,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.edit,
                      size: 16,
                    )
                  ],
                ),
              ),
            ),
            Spacer(
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }
}
