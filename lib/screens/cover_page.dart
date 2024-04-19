import 'package:flutter/material.dart';

class CoverPage extends StatelessWidget {
  const CoverPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cover Page',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blueGrey,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Team Members:',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              '1) Devkumar Gajjar (8884369)',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              '2) Sachin Kumar Reddy Komatireddy (8899637)',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              '3) Krushangkumar Kathiriya (8901343)',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              '4) Sabrup Singh (8896923)',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              'Our group consists of 4 people. We have divided each task among ourselves:',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '- Home Page and Animations for whole application was done by Sabrup Singh.',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              '- Candidates and Candidate profile pages were done by Devkumar.',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              '- Posts Page and Job Application pages, including the functionality for job listing button was done by Sachin Kumar Reddy Komatireddy.',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              '- The Jobs Page, including the functionality for Apply button was done by Krushang.',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 30),


            Center( // Wrap the ElevatedButton in a Center widget
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Go back to the previous screen
                },
                child: Text('Go Back'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
