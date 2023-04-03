import 'package:flutter/material.dart';
import 'package:voting_blockchain/pages/home_page_drawer.dart';
import 'package:voting_blockchain/widgets/custom_textfield2.dart';
import 'package:voting_blockchain/widgets/poll_card.dart';

class HomePage extends StatelessWidget {
  List<String> choices = [
    "Man of Steel",
    "Infinity War",
  ];
  HomePage({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            _scaffoldKey.currentState!.openDrawer();
                          },
                          icon: const Icon(Icons.menu)),
                      Expanded(
                        child: CustomTextField2(
                          label: "Search",
                        ),
                      ),
                    ],
                  ),
                ),
                PollCardComplete(),
              ],
            ),
          ),
        ),
      ),
      drawer: HomePageDrawer(),
    );
  }
}
