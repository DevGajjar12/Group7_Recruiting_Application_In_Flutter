import 'package:flutter/material.dart';
import 'package:recruiting_application/prefs_manager.dart';
import 'package:recruiting_application/screens/job_details_screen.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/scheduler.dart';
import 'screens/post_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // home: CandidatesScreen(),
      home: MyHomePage(),
    );
  }
}
class MyHomePage extends StatefulWidget{
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin{
  late Animation<double> _homeScreenAnimation;
  late AnimationController _homeScreenController;
  @override
  void initState() {
    super.initState();

    // Initialize home screen entrance animation
    _homeScreenController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _homeScreenAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _homeScreenController,
        curve: Curves.easeInOut,
      ),
    );

    _homeScreenController.forward();
  }

  @override
  void dispose() {
    _homeScreenController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text(
      //     'Welcome',
      //     style: TextStyle(
      //       fontSize: 24,
      //       fontWeight: FontWeight.w900,
      //     ),
      //   ),
      //   backgroundColor: Colors.blueGrey,
      // ),
      body: Center(
        child: FadeTransition(
          opacity: _homeScreenAnimation,
          child: Stack(
            fit: StackFit.expand, // Ensure the Stack fills the entire screen
            children: [
              Image(
                image: AssetImage('assets/cover3.jpg'),
                fit: BoxFit.cover, // Ensure the image covers the entire screen
              ),
              Positioned.fill(
                child: Container(
                  color: Colors.black.withOpacity(0.5), // Add a semi-transparent overlay
                ),
              ),
              Positioned.fill(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Discover Your Dream Job Here',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Explore all the most exciting jobs roles based on your interest',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                        ),

                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const CandidatesScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white, backgroundColor: Colors.blueGrey, padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          textStyle: TextStyle(fontSize: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          elevation: 3,
                        ),
                        child: Text('Get Started'),
                      ),

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

class CandidatesScreen extends StatefulWidget {
  const CandidatesScreen({Key? key});

  @override
  _CandidatesScreenState createState() => _CandidatesScreenState();
}
  class _CandidatesScreenState extends State<CandidatesScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Candidates',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w900,
          ),
        ),
        backgroundColor: Colors.blueGrey,

      ),
      backgroundColor: Colors.grey[200],
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
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
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ScaleTransition(
            scale: Tween<double>(begin: 1, end: 1.5).animate(CurvedAnimation(
              parent: _animationController, // You need to declare this AnimationController
              curve: Interval(0.0, 0.5, curve: Curves.easeInOut),
            )),
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const JobDetailsScreen()));
              },
              backgroundColor: Colors.blueGrey,
              child: const Icon(Icons.work),
            ),
          ),
          const SizedBox(height: 10),
          ScaleTransition(
            scale: Tween<double>(begin: 1, end: 1.5).animate(CurvedAnimation(
              parent: _animationController, // You need to declare this AnimationController
              curve: Interval(0.5, 1.0, curve: Curves.easeInOut),
            )),
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PostScreen()),
                );
              },
              backgroundColor: Colors.blueGrey,
              child: const Icon(Icons.post_add),
            ),
          ),
        ],
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
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: _isHovered ? Colors.white : Colors.grey[300],
            boxShadow: _isHovered
                ? [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ]
                : [],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                          image: DecorationImage(
                            image: widget.coverImage != null ? AssetImage(widget.coverImage!) : const AssetImage('assets/cover.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      AnimatedOpacity(
                        duration: Duration(milliseconds: 300),
                        opacity: _isHovered ? 1 : 0,
                        child: CircleAvatar(
                          radius: 90,
                          backgroundImage: widget.profileImage != null ? AssetImage(widget.profileImage!) : const AssetImage('assets/profile.jpg'),
                        ),
                      ),
                    ],
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

class CandidateDetailScreen extends StatefulWidget {
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
  State<CandidateDetailScreen> createState() => _CandidateDetailScreenState();
}

class _CandidateDetailScreenState extends State<CandidateDetailScreen> {
  bool isApplied = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      List<JobApply> data = await PrefsRepo().getApply();
      for (var element in data) {
        if (element.name == widget.candidateName) {
          isApplied = element.apply;
          print("Matched:------> ${isApplied}");
          setState(() {});
          break;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Candidate Profile',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blueGrey,
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
                    image: AssetImage(widget.coverImage),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: CircleAvatar(
                  radius: 80,
                  backgroundImage: AssetImage(widget.profileImage),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  widget.candidateName,
                  style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
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
                  widget.about,
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
                title: Text(widget.experience),
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
                title: Text(widget.education),
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
                title: Text(widget.certifications),
                leading: const Icon(Icons.card_membership),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: InkWell(
                  onTap: () async {
                    isApplied = !isApplied;
                    setState(() {});
                    await PrefsRepo().setApply(data: JobApply(apply: isApplied, name: widget.candidateName));
                  },
                  child: Ink(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      height: 50,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Text(
                          isApplied ? 'Applied' : 'Apply now',
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: ElevatedButton(
              //     onPressed: () async {
              //       isApplied = !isApplied;
              //       setState(() {});
              //       print("widget.candidateName:----> ${widget.candidateName}");
              //       await PrefsRepo().setApply(data: JobApply(apply: isApplied, name: widget.candidateName));
              //     },
              //     child: Text(isApplied ? 'Applied' : "Apply Now"),
              //   ),
              // ),
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
    'about':
        'About Devkumar Gajjar: To make best use of my skills of Data Analysis & Machine Learning and contribute my best potential to the organization’s growth whenever given opportunity.',
    'experience': 'Data Analyst at Finestar Diamond (Jan 2022 - Apr 2023)',
    'education': 'Bachelors degree in Information Technology',
    'certifications': 'Google data analytics professional certificate',
  },
  {
    'name': 'Sachin Reddy',
    'designation': 'Full-Stack Developer',
    'profileImage': 'assets/profile1.png',
    'coverImage': 'assets/cover1.jpg',
    'about':
        'About Sachin: To make best use of my skills of Frontend & Backend to contribute my best potential to the organization’s growth whenever given opportunity.',
    'experience': 'Full-Stack at Infosys (Jan 2022 - Apr 2023)',
    'education': 'Bachelors degree in Computer Science',
    'certifications': 'IBM Full-stack Developer professional certificate',
  },
  {
    'name': 'Krushang',
    'designation': 'Graphic Designer',
    'profileImage': 'assets/profile0.png',
    'coverImage': 'assets/cover0.jpg',
    'about':
        'About Krushang: To make best use of my skills of Graphic Designer to contribute my best potential to the organization’s growth whenever given opportunity.',
    'experience': 'Graphic Designer at TCS (Jan 2022 - Apr 2023)',
    'education': 'Bachelors degree in Computer Science',
    'certifications': 'IBM Graphic Designer professional certificate',
  },
  {
    'name': 'Sabrup Chahal',
    'designation': 'Mern-Stack Developer',
    'profileImage': 'assets/profile3.png',
    'coverImage': 'assets/cover3.jpg',
    'about':
        'About Sabrup: To make best use of my skills of Mern-Stack Developer to contribute my best potential to the organization’s growth whenever given opportunity.',
    'experience': 'Mern-Stack at iNuron (Jan 2021 - Apr 2022)',
    'education': 'Bachelors degree in Computer Science',
    'certifications': 'IBM Mern-Stack Developer professional certificate',
  },
];
