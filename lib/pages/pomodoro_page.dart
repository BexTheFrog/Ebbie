import 'dart:async';
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

enum PomodoroMode { foco, pausaCurta, pausaLonga }

class PomodoroPage extends StatefulWidget {
  const PomodoroPage({super.key});

  @override
  State<PomodoroPage> createState() => _PomodoroPageState();
}

class _PomodoroPageState extends State<PomodoroPage> {
  PomodoroMode currentMode = PomodoroMode.foco;
  int totalSeconds = 25 * 60;
  int remainingSeconds = 25 * 60;
  Timer? timer;
  bool isRunning = false;

  void startTimer() {
    if (timer != null && timer!.isActive) return;

    setState(() => isRunning = true);

    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (remainingSeconds > 0) {
        setState(() => remainingSeconds--);
      } else {
        timer?.cancel();
        setState(() => isRunning = false);
      }
    });
  }

  void pauseTimer() {
    timer?.cancel();
    setState(() => isRunning = false);
  }

  void resetTimer() {
    timer?.cancel();
    setState(() {
      remainingSeconds = totalSeconds;
      isRunning = false;
    });
  }

  void nextMode() {
    setState(() {
      if (currentMode == PomodoroMode.foco) {
        currentMode = PomodoroMode.pausaCurta;
        totalSeconds = 5 * 60;
      } else if (currentMode == PomodoroMode.pausaCurta) {
        currentMode = PomodoroMode.pausaLonga;
        totalSeconds = 15 * 60;
      } else {
        currentMode = PomodoroMode.foco;
        totalSeconds = 25 * 60;
      }
      remainingSeconds = totalSeconds;
      isRunning = false;
      timer?.cancel();
    });
  }

  String get minutes => (remainingSeconds ~/ 60).toString().padLeft(2, "0");
  String get seconds => (remainingSeconds % 60).toString().padLeft(2, "0");

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
        children: [
          const SizedBox(height: 30),
          GestureDetector(
            onTap: nextMode,
            child: Container(
              width: currentMode == PomodoroMode.foco ? 100 : 160,
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
              decoration: BoxDecoration(
                color: currentMode == PomodoroMode.foco
                    ? const Color(0xFFEA6D5A)
                    : currentMode == PomodoroMode.pausaCurta
                    ? const Color(0xFFD3D0A0)
                    : const Color(0xFF9BC1BC),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    currentMode == PomodoroMode.foco
                        ? Icons.psychology
                        : currentMode == PomodoroMode.pausaCurta
                        ? Icons.local_cafe
                        : Icons.coffee,
                    color: Colors.white,
                    size: 25,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    currentMode == PomodoroMode.foco
                        ? "Foco"
                        : currentMode == PomodoroMode.pausaCurta
                        ? "Pausa Curta"
                        : "Pausa Longa",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(
            height: 405,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    minutes,
                    style: const TextStyle(
                      fontSize: 205,
                      color: Color.fromRGBO(155, 193, 188, 1),
                      fontWeight: FontWeight.bold,
                      letterSpacing: 5,
                    ),
                  ),
                ),
                Positioned(
                  top: 180,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      seconds,
                      style: const TextStyle(
                        fontSize: 205,
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

          const SizedBox(height: 60), // espaço antes dos controles
          // Controles
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFD3D0A0),
                  borderRadius: BorderRadius.circular(20),
                ),
                height: 70,
                width: 70,
                child: const Icon(
                  Icons.more_horiz,
                  color: Colors.white,
                  size: 35,
                ),
              ),
              const SizedBox(width: 15),
              GestureDetector(
                onTap: () => isRunning ? pauseTimer() : startTimer(),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFED6A5A),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  height: 80,
                  width: 120,
                  child: Icon(
                    isRunning ? Icons.pause : Icons.play_arrow,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ),
              const SizedBox(width: 15),
              GestureDetector(
                onTap: resetTimer,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFD3D0A0),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  height: 70,
                  width: 70,
                  child: const Icon(
                    Icons.refresh,
                    color: Colors.white,
                    size: 35,
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
