import 'package:flutter/material.dart';
 
void main() {
  runApp(const PomodoroApp());
}
 
class PomodoroApp extends StatelessWidget {
  const PomodoroApp({super.key});
 
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PomodoroPage(),
    );
  }
}
 
class PomodoroPage extends StatefulWidget {
  const PomodoroPage({super.key});
 
  @override
  State<PomodoroPage> createState() => _PomodoroPageState();
}
 
class _PomodoroPageState extends State<PomodoroPage> {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color.fromRGBO(93, 87, 108, 1),
          flexibleSpace: SafeArea(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset('assets/images/logo.png', height: 50),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    margin: const EdgeInsets.only(right: 20),
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(233, 167, 81, 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(247, 237, 226, 1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      height: 25,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text(
                            '15',
                            style: TextStyle(
                              color: Color.fromRGBO(233, 167, 81, 1),
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(width: 3),
                          Icon(
                            Icons.paid,
                            color: Color.fromRGBO(233, 167, 81, 1),
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: const Color(0xFFFDF7E4),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFEA6D5A),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.psychology, color: Colors.white, size: 22),
                SizedBox(width: 6),
                Text(
                  'Foco',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: 390,
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        "25",
                        style: const TextStyle(
                          fontSize: 200,
                          color: Color.fromRGBO(155, 193, 188, 1),
                          fontWeight: FontWeight.bold,
                          letterSpacing: 5,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 170,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          "00",
                          style: const TextStyle(
                            fontSize: 200,
                            color: Color.fromRGBO(155, 193, 188, 1),
                            fontWeight: FontWeight.bold,
                            letterSpacing: 3,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFD3D0A0),
                  borderRadius: BorderRadius.circular(10),
                ),
                height: 60,
                width: 60,
                child: const Icon(
                  Icons.more_horiz,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              const SizedBox(width: 20),
              GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFED6A5A),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  height: 70,
                  width: 100,
                  child: Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
              const SizedBox(width: 20),
              GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFD3D0A0),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 60,
                  width: 60,
                  child: const Icon(
                    Icons.refresh,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}