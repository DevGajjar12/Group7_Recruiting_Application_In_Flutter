import 'package:flutter/material.dart';
import 'screens/post_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CandidatesScreen(),
    );
  }
}

class CandidatesScreen extends StatelessWidget {
  const CandidatesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Candidates'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: candidateProfiles.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: CandidateCard(
              candidateName: candidateProfiles[index]['name'] ?? '',
              candidateDesignation: candidateProfiles[index]['designation'] ?? '',
              profileImage: candidateProfiles[index]['profileImage'],
              coverImage: candidateProfiles[index]['coverImage'],
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CandidateDetailScreen(
                      candidateName: candidateProfiles[index]['name'] ?? '',
                      about: candidateProfiles[index]['about'] ?? '',
                      experience: candidateProfiles[index]['experience'] ?? '',
                      education: candidateProfiles[index]['education'] ?? '',
                      certifications: candidateProfiles[index]['certifications'] ?? '',
                      profileImage: candidateProfiles[index]['profileImage'] ?? '',
                      coverImage: candidateProfiles[index]['coverImage'] ?? '',
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to PostScreen when the button is pressed
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PostScreen()),
          );
        },
        child: const Icon(Icons.post_add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}

class CandidateCard extends StatefulWidget {
  final String candidateName;
  final String candidateDesignation;
  final String? profileImage;
  final String? coverImage;
  final VoidCallback onTap;

  const CandidateCard({
    super.key,
    required this.candidateName,
    required this.candidateDesignation,
    required this.profileImage,
    required this.coverImage,
    required this.onTap,
  });

  @override
  _CandidateCardState createState() => _CandidateCardState();
}

class _CandidateCardState extends State<CandidateCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => setState(() => _isHovered = true),
      onExit: (event) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Card(
          elevation: _isHovered ? 15 : 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: widget.coverImage != null ? AssetImage(widget.coverImage!) : const AssetImage('assets/cover.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: widget.profileImage != null ? AssetImage(widget.profileImage!) : const AssetImage('assets/profile.jpg'),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.candidateName,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(widget.candidateDesignation),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CandidateDetailScreen extends StatelessWidget {
  final String candidateName;
  final String about;
  final String experience;
  final String education;
  final String certifications;
  final String profileImage;
  final String coverImage;

  const CandidateDetailScreen({
    Key? key,
    required this.candidateName,
    required this.about,
    required this.experience,
    required this.education,
    required this.certifications,
    required this.profileImage,
    required this.coverImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Candidate Profile'),
      ),
      body: Container(
        color: Colors.grey.shade200,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 250,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(coverImage),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: CircleAvatar(
                  radius: 80,
                  backgroundImage: AssetImage(profileImage),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  candidateName,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'About',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  about,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Experience',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                title: Text(experience),
                leading: const Icon(Icons.work),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Education',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                title: Text(education),
                leading: const Icon(Icons.school),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Certifications',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                title: Text(certifications),
                leading: const Icon(Icons.card_membership),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



List<Map<String, String?>> candidateProfiles = [
  {
    'name': 'Devkumar Gajjar',
    'designation': 'Data Analyst',
    'profileImage': 'assets/profile2.jpg',
    'coverImage': 'assets/cover2.png',
    'about': 'About Devkumar Gajjar: To make best use of my skills of Data Analysis & Machine Learning and contribute my best potential to the organization’s growth whenever given opportunity.',
    'experience': 'Data Analyst at Finestar Diamond (Jan 2022 - Apr 2023)',
    'education': 'Bachelors degree in Information Technology',
    'certifications': 'Google data analytics professional certificate',
  },
  {
    'name': 'Sachin Reddy',
    'designation': 'Full-Stack Developer',
    'profileImage': 'assets/profile1.png',
    'coverImage': 'assets/cover1.jpg',
    'about': 'About Sachin: To make best use of my skills of Frontend & Backend to contribute my best potential to the organization’s growth whenever given opportunity.',
    'experience': 'Full-Stack at Infosys (Jan 2022 - Apr 2023)',
    'education': 'Bachelors degree in Computer Science',
    'certifications': 'IBM Full-stack Developer professional certificate',
  },
  {
    'name': 'Krushang',
    'designation': 'Graphic Designer',
    'profileImage': 'assets/profile0.png',
    'coverImage': 'assets/cover0.jpg',
    'about': 'About Krushang: To make best use of my skills of Graphic Designer to contribute my best potential to the organization’s growth whenever given opportunity.',
    'experience': 'Graphic Designer at TCS (Jan 2022 - Apr 2023)',
    'education': 'Bachelors degree in Computer Science',
    'certifications': 'IBM Graphic Designer professional certificate',
  },
  {
    'name': 'Sabrup Chahal',
    'designation': 'Mern-Stack Developer',
    'profileImage': 'assets/profile3.png',
    'coverImage': 'assets/cover3.jpg',
    'about': 'About Sabrup: To make best use of my skills of Mern-Stack Developer to contribute my best potential to the organization’s growth whenever given opportunity.',
    'experience': 'Mern-Stack at iNuron (Jan 2021 - Apr 2022)',
    'education': 'Bachelors degree in Computer Science',
    'certifications': 'IBM Mern-Stack Developer professional certificate',
  },
];
