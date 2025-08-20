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

class PomodoroPage extends StatefulWidget {
  const PomodoroPage({super.key});

  @override
  State<PomodoroPage> createState() => _PomodoroPageState();
}

class _PomodoroPageState extends State<PomodoroPage> {
  int _selectedMinutes = 25;
  int _remainingSeconds = 25 * 60;
  Timer? _timer;
  bool _isRunning = false;

  void _startTimer() {
    if (_isRunning) return;
    setState(() => _isRunning = true);

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() => _remainingSeconds--);
      } else {
        _timer?.cancel();
        setState(() => _isRunning = false);
      }
    });
  }

  void _pauseTimer() {
    _timer?.cancel();
    setState(() => _isRunning = false);
  }

  void _resetTimer([int? newMinutes]) {
    _timer?.cancel();
    setState(() {
      if (newMinutes != null) {
        _selectedMinutes = newMinutes;
        _remainingSeconds = newMinutes * 60;
      } else {
        _remainingSeconds = _selectedMinutes * 60;
      }
      _isRunning = false;
    });
  }

  /// Abre modal com opções de tempo
  void _showTimeOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        final options = [5, 15, 25];
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 15),
            const Text(
              "Escolha o tempo",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            Wrap(
              spacing: 15,
              children: [
                ...options.map(
                  (min) => ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFEA6D5A),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(ctx);
                      _resetTimer(min);
                    },
                    child: Text("$min min"),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[300],
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(ctx);
                    _setCustomTime();
                  },
                  child: const Text("Personalizar"),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        );
      },
    );
  }

  void _setCustomTime() async {
    final controller = TextEditingController();
    int? customMinutes = await showDialog<int>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Tempo personalizado"),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(hintText: "Digite os minutos"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Cancelar"),
          ),
          TextButton(
            onPressed: () {
              final value = int.tryParse(controller.text);
              if (value != null && value > 0) {
                Navigator.pop(ctx, value);
              }
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );

    if (customMinutes != null) {
      _resetTimer(customMinutes);
    }
  }

  String get minutes => (_remainingSeconds ~/ 60).toString().padLeft(2, '0');
  String get seconds => (_remainingSeconds % 60).toString().padLeft(2, '0');

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
                Image.network('assets/images/logo.png', height: 50),
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
          SizedBox(height: 30),
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
                        minutes,
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
                          seconds,
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

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: _showTimeOptions,
                child: Container(
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
              ),
              const SizedBox(width: 20),
              GestureDetector(
                onTap: _isRunning ? _pauseTimer : _startTimer,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFED6A5A),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  height: 70,
                  width: 100,
                  child: Icon(
                    _isRunning ? Icons.pause : Icons.play_arrow,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
              const SizedBox(width: 20),
              GestureDetector(
                onTap: _resetTimer,
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

class _CircleIcon extends StatelessWidget {
  final IconData icon;
  final Color bgColor;
  final Color iconColor;
  final VoidCallback onTap;

  const _CircleIcon({
    required this.icon,
    required this.bgColor,
    this.iconColor = Colors.black,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        backgroundColor: bgColor,
        radius: 35,
        child: Icon(icon, color: iconColor, size: 32),
      ),
    );
  }
}
