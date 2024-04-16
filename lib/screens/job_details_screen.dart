import 'package:flutter/material.dart';
import 'package:recruiting_application/prefs_manager.dart';

class JobDetailsScreen extends StatefulWidget {
  const JobDetailsScreen({super.key});

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  List<Map<String, dynamic>> jobDetails = [
    {'name': 'APP Developer', 'destination': 'Toronto, Ontario', 'salary': '\$5000 - \$6000', "apply": false},
    {'name': 'Web Developer', 'destination': 'Montreal, Quebec', 'salary': '\$4800 - \$5500', "apply": false},
    {'name': 'Software Engineer', 'destination': 'Vancouver, British Columbia', 'salary': '\$5500 - \$6500', "apply": false},
    {'name': 'Data Analyst', 'destination': 'Calgary, Alberta', 'salary': '\$5200 - \$6000', "apply": false},
    {'name': 'UX/UI Designer', 'destination': 'Edmonton, Alberta', 'salary': '\$4800 - \$5500', "apply": false},
    {'name': 'IT Project Manager', 'destination': 'Winnipeg, Manitoba', 'salary': '\$5800 - \$6700', "apply": false},
    {'name': 'Network Administrator', 'destination': 'Saskatoon, Saskatchewan', 'salary': '\$4900 - \$5600', "apply": false},
    {'name': 'Software Developer', 'destination': 'Halifax, Nova Scotia', 'salary': '\$5100 - \$5900', "apply": false},
    {'name': 'QA Tester', 'destination': 'St. John\'s, Newfoundland and Labrador', 'salary': '\$4900 - \$5600', "apply": false},
    {'name': 'Database Administrator', 'destination': 'Charlottetown, Prince Edward Island', 'salary': '\$5000 - \$5800', "apply": false},
    {'name': 'Cybersecurity Analyst', 'destination': 'Whitehorse, Yukon', 'salary': '\$5400 - \$6200', "apply": false},
    {'name': 'Mobile Developer', 'destination': 'Iqaluit, Nunavut', 'salary': '\$5300 - \$6100', "apply": false},
  ];

  bool isApplied = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      List<JobApply> data = await PrefsRepo().getApply();
      for (var element in data) {
        for (var jobElement in jobDetails) {
          if (element.name == jobElement['name'] + jobElement['destination']) {
            jobElement['apply'] = element.apply;
            setState(() {});
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Job Details')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: jobDetails.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (c, i) {
                return Column(
                  children: [
                    ListTile(
                      title: Text(jobDetails[i]['name'] ?? ''),
                      subtitle: Text(jobDetails[i]['destination'] ?? ''),
                      trailing: Text(jobDetails[i]['salary'] ?? ''),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () async {
                              jobDetails[i]['apply'] = !jobDetails[i]['apply'];
                              setState(() {});
                              await PrefsRepo().setApply(
                                data: JobApply(apply: jobDetails[i]['apply'], name: jobDetails[i]['name'] + jobDetails[i]['destination']),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              height: 30,
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(
                                child: Text(
                                  jobDetails[i]['apply'] ? 'Applied' : 'Apply now',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
