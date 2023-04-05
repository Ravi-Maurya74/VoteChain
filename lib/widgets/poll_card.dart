import 'dart:convert';
import 'package:http/http.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:voting_blockchain/helpers/networking.dart';
import 'package:voting_blockchain/pages/result_page.dart';

class PollCard extends StatelessWidget {
  const PollCard({super.key, required this.pollData});
  final dynamic pollData;

  @override
  Widget build(BuildContext context) {
    final created = DateFormat("yyyy-MM-dd")
        .parse((pollData['created'] as String).substring(0, 10));
    final date = DateFormat.yMMMMd('en_US').format(created);
    return GestureDetector(
      onTap: () async {
        final response = await NetworkHelper().postData(
            url: "getElectionResult/",
            jsonMap: {"election_id": pollData["id"]});
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ResultPage(
                  pollData: pollData, result: jsonDecode(response.body)),
            ));
      },
      child: Container(
        decoration: BoxDecoration(
          // color: Colors.deepPurple[300],
          borderRadius: BorderRadius.circular(20),
          gradient: pollData["has_voted"]
              ? LinearGradient(
                  // colors: [
                  //   Colors.deepPurple[300]!,
                  //   Colors.deepPurple[600]!,
                  //   Colors.deepPurple[800]!,
                  // ],
                  colors: [
                    Colors.teal[300]!.withOpacity(0.9),
                    Colors.teal[600]!.withOpacity(0.7),
                    Colors.teal[800]!.withOpacity(0.7),
                  ],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                )
              : LinearGradient(
                  colors: [
                    Colors.deepPurple[300]!,
                    Colors.deepPurple[600]!,
                    Colors.deepPurple[800]!,
                  ],
                  // colors: [
                  //   Colors.teal[300]!.withOpacity(0.9),
                  //   Colors.teal[600]!.withOpacity(0.7),
                  //   Colors.teal[800]!.withOpacity(0.7),
                  // ],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                ),
        ),
        margin: EdgeInsets.only(bottom: 20, top: 10),
        // height: 200,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 15,
            bottom: 15,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Poll: ${pollData["id"]}",
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(fontFamily: "Alkatra"),
                  ),
                  Text(
                    date,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontFamily: "Alkatra",
                        ),
                  ),
                ],
              ),
              const Divider(
                color: Colors.white,
                height: 1,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                pollData["title"],
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontFamily: "Alkatra",
                      fontWeight: FontWeight.w700,
                    ),
                // textAlign: TextAlign.justify,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Icon(
                    Icons.person_add_alt_1,
                    size: 25,
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  Text(
                    pollData["number_of_votes"].toString(),
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(fontSize: 16),
                    textAlign: TextAlign.end,
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  const Text(
                    "|",
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  const Icon(
                    Icons.format_list_numbered,
                    size: 25,
                  ),
                  Text(
                    pollData["number_of_choices"].toString(),
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(fontSize: 16),
                    textAlign: TextAlign.end,
                  ),
                  const Spacer(),
                  pollData["running"]
                      ? const Icon(Icons.how_to_vote_sharp)
                      : const Icon(Icons.bar_chart_outlined),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

// class PollCard extends StatelessWidget {
//   const PollCard({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         // color: Colors.deepPurple[300],
//         borderRadius: BorderRadius.circular(20),
//         gradient: LinearGradient(
//           colors: [
//             Colors.deepPurple[300]!.withOpacity(0.7),
//             Colors.deepPurple[600]!.withOpacity(0.7),
//             Colors.deepPurple[800]!.withOpacity(0.7),
//           ],
//           // colors: [
//           //   Colors.teal[300]!.withOpacity(0.7),
//           //   Colors.teal[600]!.withOpacity(0.7),
//           //   Colors.teal[800]!.withOpacity(0.7),
//           // ],
//           begin: Alignment.bottomLeft,
//           end: Alignment.topRight,
//         ),
//       ),
//       // height: 200,
//       width: double.infinity,
//       child: Padding(
//         padding: const EdgeInsets.only(
//           left: 20,
//           right: 20,
//           top: 15,
//           bottom: 15,
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   "Poll: 1",
//                   style: Theme.of(context)
//                       .textTheme
//                       .titleSmall!
//                       .copyWith(fontFamily: "Alkatra"),
//                 ),
//                 Text(
//                   "3 April, 2023",
//                   style: Theme.of(context).textTheme.titleSmall!.copyWith(
//                         fontFamily: "Alkatra",
//                       ),
//                 ),
//               ],
//             ),
//             Divider(
//               color: Colors.white,
//               height: 1,
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             Text(
//               "Why my pages are not refreshing with bottom navigation in flutter?",
//               style: Theme.of(context).textTheme.titleLarge!.copyWith(
//                     fontFamily: "Alkatra",
//                     fontWeight: FontWeight.w700,
//                   ),
//               // textAlign: TextAlign.justify,
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 Icon(
//                   Icons.person_add_alt_1,
//                   size: 25,
//                 ),
//                 const SizedBox(
//                   width: 3,
//                 ),
//                 Text(
//                   "323",
//                   style: Theme.of(context)
//                       .textTheme
//                       .titleSmall!
//                       .copyWith(fontSize: 16),
//                   textAlign: TextAlign.end,
//                 ),
//                 const SizedBox(
//                   width: 6,
//                 ),
//                 const Text(
//                   "|",
//                   style: TextStyle(fontSize: 20),
//                 ),
//                 const SizedBox(
//                   width: 6,
//                 ),
//                 Icon(
//                   Icons.format_list_numbered,
//                   size: 25,
//                 ),
//                 Text(
//                   "6",
//                   style: Theme.of(context)
//                       .textTheme
//                       .titleSmall!
//                       .copyWith(fontSize: 16),
//                   textAlign: TextAlign.end,
//                 ),
//                 Spacer(),
//                 // Icon(Icons.how_to_vote_sharp),
//                 Icon(Icons.bar_chart_outlined),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
