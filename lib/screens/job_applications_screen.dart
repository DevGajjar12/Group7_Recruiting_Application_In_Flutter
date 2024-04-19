import 'package:flutter/material.dart';
import 'package:recruiting_application/prefs_manager.dart';

class JobApplicationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Job Applications'),
        backgroundColor: Colors.blueGrey,
      ),
      body: FutureBuilder<List<JobApply>>(
        future: PrefsRepo().getApply(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final jobApplications = snapshot.data;
            return ListView.builder(
              itemCount: jobApplications?.length,
              itemBuilder: (context, index) {
                final job = jobApplications?[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(16.0),
                      title: Text(
                        job!.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // You can add more information here if needed
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
