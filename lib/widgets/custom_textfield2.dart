import 'dart:convert';

// import 'package:cached_network_image/cached_network_image.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:voting_blockchain/helpers/networking.dart';
import 'package:voting_blockchain/pages/result_page.dart';
import 'package:voting_blockchain/pages/vote_page.dart';

class CustomTextField2 extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController textEditingController = TextEditingController();
  late GetStorage box;
  CustomTextField2({
    required this.label,
    this.hint = '',
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    box = GetStorage();
    return Container(
      // margin: const EdgeInsets.symmetric(horizontal: 25),
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 0),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(37, 42, 52, 1),
        borderRadius: BorderRadius.circular(17),
      ),
      child: Row(
        children: [
          Container(
              margin: const EdgeInsets.only(right: 10),
              child: IconButton(
                padding: EdgeInsets.zero,
                enableFeedback: true,
                alignment: Alignment.centerLeft,
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                icon: Icon(
                  Icons.search,
                  color: Colors.white.withOpacity(0.7),
                ),
                onPressed: () async {
                  if (textEditingController.text.length > 2) {
                    var voterId = box.read("voter_id");
                    var results = await NetworkHelper().postData(
                      url: 'searchElection/',
                      jsonMap: {
                        "title": textEditingController.text,
                        "voter_id": voterId
                      },
                    );
                    // print(textEditingController.value);
                    // Navigator.pushNamed(context, FilteredMovies.routeName,
                    //     arguments: jsonDecode(results.body));
                  }
                },
              )),
          Expanded(
              child: TypeAheadField(
            hideOnLoading: true,
            minCharsForSuggestions: 2,
            getImmediateSuggestions: false,
            noItemsFoundBuilder: (context) => const ListTile(
              title: Text('No Results'),
            ),
            textFieldConfiguration: TextFieldConfiguration(
                controller: textEditingController,
                autofocus: false,
                decoration: const InputDecoration(border: InputBorder.none)),
            suggestionsCallback: (pattern) async {
              var voterId = box.read("voter_id");
              var results = await NetworkHelper().postData(
                url: 'searchElection/',
                jsonMap: {"title": pattern, "voter_id": voterId},
              );
              // print(jsonDecode(results.body));
              return jsonDecode(results.body) as List<dynamic>;
            },
            itemBuilder: (context, itemData) {
              return ListTile(
                // tileColor: itemData["has_voted"]
                //     ? Colors.green.shade900
                //     : Colors.deepPurple.shade800,
                leading: itemData["running"]
                    ? const Icon(
                        Icons.how_to_vote_sharp,
                        color: Colors.white,
                      )
                    : const Icon(
                        Icons.bar_chart_outlined,
                        color: Colors.white,
                      ),
                title: Text(
                  itemData['title'] as String,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontFamily: "Alkatra",
                      ),
                ),
                // subtitle: Text(
                //   (itemData['year'] as int).toString(),
                //   style: Theme.of(context).textTheme.bodySmall,
                // ),
              );
            },
            onSuggestionSelected: (pollData) async {
              if (pollData["running"] && pollData["has_voted"]) {
                CoolAlert.show(
                    context: context,
                    type: CoolAlertType.info,
                    text:
                        "You have already voted! Please wait till the election is over to view the results.",
                    barrierDismissible: false);
                return;
              } else if (pollData["running"]) {
                var result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VotePage(
                        pollData: pollData,
                      ),
                    ));
                // if (result != null && result == true) {
                //   setState(() {
                //     widget.pollData["has_voted"] = true;
                //     widget.pollData["number_of_votes"] =
                //         widget.pollData["number_of_votes"] + 1;
                //   });
                //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                //       content: Text('Vote hash copied to clipboard!')));
                // }
              } else {
                CoolAlert.show(
                  context: context,
                  type: CoolAlertType.loading,
                  text: 'Loading...',
                  barrierDismissible: false,
                );
                final response = await NetworkHelper().postData(
                    url: "getElectionResult/",
                    jsonMap: {"election_id": pollData["id"]});
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResultPage(
                      pollData: pollData,
                      result: jsonDecode(response.body),
                    ),
                  ),
                );
              }
            },
          )

              // TextField(
              //   decoration: InputDecoration(
              //     border: InputBorder.none,
              //     // label: Text(label),
              //     hintText: hint,
              //     // labelStyle: TextStyle(color: Colors.white),
              //   ),
              //   controller: textEditingController,
              //   autofillHints: gethints(label),
              // ),
              ),
        ],
      ),
    );
  }
}

Iterable<String> gethints(String label) {
  if (label == 'Email') {
    return [AutofillHints.email];
  } else if (label == 'Full Name') {
    return [AutofillHints.name];
  } else {
    return [];
  }
}
