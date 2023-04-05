import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ResultPage extends StatelessWidget {
  ResultPage({super.key, required this.pollData, required this.result});
  final dynamic pollData;
  final dynamic result;
  late List<CandidateData> _candidateData;
  late String _winner;
  late String _totalVotes;

  @override
  Widget build(BuildContext context) {
    _candidateData = getChartData(result);
    _winner = getWinner(result);
    _totalVotes = getTotalVotes(result);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          child: SingleChildScrollView(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Poll: 2",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontFamily: "Alkatra"),
                    ),
                    Icon(Icons.how_to_vote_sharp),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    pollData["title"],
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontFamily: "Alkatra"),
                    textAlign: TextAlign.justify,
                  ),
                ),
                SizedBox(
                  height: 400,
                  child: SfCircularChart(
                    // title: ChartTitle(
                    //     text: pollData["title"],
                    //     textStyle: Theme.of(context)
                    //         .textTheme
                    //         .titleLarge!
                    //         .copyWith(fontFamily: "Alkatra")),
                    legend: Legend(
                      isVisible: true,
                      overflowMode: LegendItemOverflowMode.wrap,
                      textStyle: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontFamily: "Alkatra", color: Colors.white),
                      position: LegendPosition.bottom,
                    ),
                    tooltipBehavior: TooltipBehavior(enable: true),
                    series: <CircularSeries>[
                      PieSeries<CandidateData, String>(
                        dataSource: _candidateData,
                        xValueMapper: (datum, index) => datum.name,
                        yValueMapper: (datum, index) => datum.votes,
                        dataLabelSettings:
                            const DataLabelSettings(isVisible: true),
                        enableTooltip: true,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                ResultRow(
                  label: "Winner :",
                  value: _winner,
                ),
                ResultRow(
                  label: "By :",
                  value: "${result["votes"][result["winners"][0]]} votes",
                ),
                ResultRow(
                  label: "Total :",
                  value: "${_totalVotes} votes",
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
      ),
    );
  }
}

class ResultRow extends StatelessWidget {
  const ResultRow({super.key, required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            textAlign: TextAlign.right,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontFamily: "Alkatra"),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(
          flex: 4,
          child: Text(
            value,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontFamily: "Alkatra"),
          ),
        ),
      ],
    );
  }
}

class CandidateData {
  final String name;
  final int votes;
  CandidateData({required this.name, required this.votes});
}

List<CandidateData> getChartData(dynamic data) {
  final List<dynamic> choices = data["choices"];
  final List<dynamic> votes = data["votes"];
  List<CandidateData> candidateData = [];
  for (int i = 0; i < choices.length; i++) {
    candidateData.add(CandidateData(name: choices[i]["name"], votes: votes[i]));
  }
  return candidateData;
}

String getWinner(dynamic data) {
  final List<dynamic> choices = data["choices"];
  final List<dynamic> winners = data["winners"];
  String ans = "";
  for (int ind in winners) {
    ans += choices[ind]["name"];
    ans += ", ";
  }
  ans = ans.substring(0, ans.length - 2);
  return ans;
}

String getTotalVotes(dynamic data) {
  final List<dynamic> votes = data["votes"];
  int ans = 0;
  for (int vote in votes) {
    ans += vote;
  }
  return ans.toString();
}
