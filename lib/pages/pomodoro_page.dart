import 'dart:async';
import 'package:ebbie/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

enum PomodoroMode { foco, pausaCurta, pausaLonga }

class PomodoroPage extends StatefulWidget {
  const PomodoroPage({super.key});

  @override
  State<PomodoroPage> createState() => _PomodoroPageState();
}

class _PomodoroPageState extends State<PomodoroPage> {
  OverlayEntry? _overlayEntry;

  int focusMinutes = 25;
  int shortBreakMinutes = 5;
  int longBreakMinutes = 15;

  PomodoroMode currentMode = PomodoroMode.foco;
  int totalSeconds = 25 * 60;
  int remainingSeconds = 25 * 60;
  Timer? timer;
  bool isRunning = false;

  OverlayEntry _createOverlayEntry(BuildContext context) {
    final focoController = TextEditingController(text: focusMinutes.toString());
    final curtaController = TextEditingController(
      text: shortBreakMinutes.toString(),
    );
    final longaController = TextEditingController(
      text: longBreakMinutes.toString(),
    );

    return OverlayEntry(
      builder: (context) => Stack(
        children: [
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: _hideOverlay,
            child: Container(color: Colors.black.withOpacity(0.4)),
          ),

          Center(
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: 370,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(247, 237, 226, 1),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Personalizar tempos",
                      style: TextStyle(
                        color: Color.fromRGBO(93, 87, 108, 1),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 25),

                    _buildTimeEditor(
                      "Foco",
                      focoController,
                      const Color(0xFFEA6D5A),
                    ),
                    const SizedBox(height: 15),
                    _buildTimeEditor(
                      "Pausa Curta",
                      curtaController,
                      const Color(0xFFD3D0A0),
                    ),
                    const SizedBox(height: 15),
                    _buildTimeEditor(
                      "Pausa Longa",
                      longaController,
                      const Color(0xFF9BC1BC),
                    ),
                    const SizedBox(height: 25),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          onPressed: _hideOverlay,
                          child: const Text(
                            "Cancelar",
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFEA6D5A),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              focusMinutes =
                                  int.tryParse(focoController.text) ??
                                  focusMinutes;
                              shortBreakMinutes =
                                  int.tryParse(curtaController.text) ??
                                  shortBreakMinutes;
                              longBreakMinutes =
                                  int.tryParse(longaController.text) ??
                                  longBreakMinutes;

                              // Atualiza o modo atual
                              if (currentMode == PomodoroMode.foco) {
                                totalSeconds = focusMinutes * 60;
                              } else if (currentMode ==
                                  PomodoroMode.pausaCurta) {
                                totalSeconds = shortBreakMinutes * 60;
                              } else {
                                totalSeconds = longBreakMinutes * 60;
                              }

                              remainingSeconds = totalSeconds;
                              isRunning = false;
                              timer?.cancel();
                            });
                            _hideOverlay();
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 8,
                            ),
                            child: Text(
                              "Salvar",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeEditor(
    String label,
    TextEditingController controller,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          SizedBox(
            width: 70,
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: "min",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: color.withOpacity(0.7)),
                ),
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 8),
              ),
              style: TextStyle(color: color, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  void _showOverlay() {
    _overlayEntry = _createOverlayEntry(context);
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

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
        totalSeconds = shortBreakMinutes * 60;
      } else if (currentMode == PomodoroMode.pausaCurta) {
        currentMode = PomodoroMode.pausaLonga;
        totalSeconds = longBreakMinutes * 60;
      } else {
        currentMode = PomodoroMode.foco;
        totalSeconds = focusMinutes * 60;
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
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
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
          const SizedBox(height: 35),
          GestureDetector(
            onTap: nextMode,
            child: IntrinsicWidth(
              child: Container(
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 15),
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
          ),
          const SizedBox(height: 50),

          Column(
            children: [
              Text(
                minutes,
                style: const TextStyle(
                  height: 0.9,
                  fontSize: 200,
                  color: Color.fromRGBO(155, 193, 188, 1),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                seconds,
                style: const TextStyle(
                  height: 0.9,
                  fontSize: 200,
                  color: Color.fromRGBO(155, 193, 188, 1),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 50),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  if (_overlayEntry == null) {
                    _showOverlay();
                  } else {
                    _hideOverlay();
                  }
                },
                child: Container(
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
