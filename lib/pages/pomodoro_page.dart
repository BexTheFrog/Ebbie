import 'dart:async';
import 'package:ebbie/widgets/custom_appbar.dart';
import 'package:ebbie/widgets/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

enum PomodoroMode { foco, pausaCurta, pausaLonga }

class PomodoroPage extends StatefulWidget {
  const PomodoroPage({super.key});

  @override
  State<PomodoroPage> createState() => _PomodoroPageState();
}

class _PomodoroPageState extends State<PomodoroPage> {
  OverlayEntry? _overlayEntry;
  late TextEditingController _focoController;
  late TextEditingController _curtaController;
  late TextEditingController _longaController;

  int focusMinutes = 25;
  int shortBreakMinutes = 5;
  int longBreakMinutes = 15;

  PomodoroMode currentMode = PomodoroMode.foco;
  int totalSeconds = 25 * 60;
  int remainingSeconds = 25 * 60;
  Timer? timer;
  bool isRunning = false;

  bool autoStartBreak = false;
  PomodoroMode selectedBreakType = PomodoroMode.pausaCurta;
  bool autoStartFocus = false;

  @override
  void initState() {
    super.initState();
    _focoController = TextEditingController(text: focusMinutes.toString());
    _curtaController = TextEditingController(
      text: shortBreakMinutes.toString(),
    );
    _longaController = TextEditingController(text: longBreakMinutes.toString());
    _updateTotalSeconds();
  }

  @override
  void dispose() {
    timer?.cancel();
    _overlayEntry?.remove();
    _focoController.dispose();
    _curtaController.dispose();
    _longaController.dispose();
    super.dispose();
  }

  void _updateTotalSeconds() {
    setState(() {
      if (currentMode == PomodoroMode.foco) {
        totalSeconds = focusMinutes * 60;
      } else if (currentMode == PomodoroMode.pausaCurta) {
        totalSeconds = shortBreakMinutes * 60;
      } else {
        totalSeconds = longBreakMinutes * 60;
      }
      remainingSeconds = totalSeconds;
    });
  }

  OverlayEntry _createOverlayEntry(BuildContext context) {
    final theme = Provider.of<ThemeController>(context, listen: false);

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
                    Text(
                      "Personalizar tempos",
                      style: TextStyle(
                        color: theme.textOverlayColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 25),

                    _buildTimeEditor(
                      "Foco",
                      _focoController,
                      theme.primaryColor,
                    ),
                    const SizedBox(height: 15),
                    _buildTimeEditor(
                      "Pausa Curta",
                      _curtaController,
                      theme.timePersonalizedColor,
                    ),
                    const SizedBox(height: 15),
                    _buildTimeEditor(
                      "Pausa Longa",
                      _longaController,
                      theme.accentColor,
                    ),
                    const SizedBox(height: 25),

                    Row(
                      children: [
                        Checkbox(
                          value: autoStartBreak,
                          onChanged: (value) {
                            autoStartBreak = value ?? false;
                            _overlayEntry?.markNeedsBuild();
                          },
                        ),

                        Text(
                          "Iniciar pausa automaticamente",
                          style: TextStyle(
                            color: theme.textOverlayColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    if (autoStartBreak)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 8,
                        ),
                        margin: const EdgeInsets.only(bottom: 15),
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(240, 232, 219, 1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Tipo de pausa:",
                              style: TextStyle(
                                color: theme.textOverlayColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  value:
                                      selectedBreakType ==
                                      PomodoroMode.pausaCurta,
                                  onChanged: (value) {
                                    if (value == true) {
                                      selectedBreakType =
                                          PomodoroMode.pausaCurta;
                                      _overlayEntry?.markNeedsBuild();
                                    }
                                  },
                                ),

                                Text(
                                  "Pausa Curta",
                                  style: TextStyle(
                                    color: theme.textOverlayColor,
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Checkbox(
                                  value:
                                      selectedBreakType ==
                                      PomodoroMode.pausaLonga,
                                  onChanged: (value) {
                                    if (value == true) {
                                      selectedBreakType =
                                          PomodoroMode.pausaLonga;
                                      _overlayEntry?.markNeedsBuild();
                                    }
                                  },
                                ),

                                Text(
                                  "Pausa Longa",
                                  style: TextStyle(
                                    color: theme.textOverlayColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                    Row(
                      children: [
                        Checkbox(
                          value: autoStartFocus,
                          onChanged: (value) {
                            autoStartFocus = value ?? false;
                            _overlayEntry?.markNeedsBuild();
                          },
                        ),

                        Text(
                          "Iniciar foco automaticamente",
                          style: TextStyle(
                            color: theme.textOverlayColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),

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
                            backgroundColor: theme.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              focusMinutes =
                                  int.tryParse(_focoController.text) ??
                                  focusMinutes;
                              shortBreakMinutes =
                                  int.tryParse(_curtaController.text) ??
                                  shortBreakMinutes;
                              longBreakMinutes =
                                  int.tryParse(_longaController.text) ??
                                  longBreakMinutes;

                              _updateTotalSeconds();
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
    final theme = context.watch<ThemeController>();

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
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              maxLength: 2,
              controller: controller,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                counterText: '',
                hintText: "min",
                hintStyle: TextStyle(
                  fontSize: 15,
                  color: color.withOpacity(0.6),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: theme.appbarColor.withOpacity(0.6),
                    width: 1.5,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: color.withOpacity(0.8),
                    width: 2.2,
                  ),
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
    if (_overlayEntry != null) return;

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

        if (currentMode == PomodoroMode.foco && autoStartBreak) {
          currentMode = selectedBreakType;
          _updateTotalSeconds();
          startTimer();
        } else if ((currentMode == PomodoroMode.pausaCurta ||
                currentMode == PomodoroMode.pausaLonga) &&
            autoStartFocus) {
          currentMode = PomodoroMode.foco;
          _updateTotalSeconds();
          startTimer();
        }
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
      } else if (currentMode == PomodoroMode.pausaCurta) {
        currentMode = PomodoroMode.pausaLonga;
      } else {
        currentMode = PomodoroMode.foco;
      }
      _updateTotalSeconds();
      isRunning = false;
      timer?.cancel();
    });
  }

  String get minutes => (remainingSeconds ~/ 60).toString().padLeft(2, "0");
  String get seconds => (remainingSeconds % 60).toString().padLeft(2, "0");

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeController>();

    return Scaffold(
      appBar: const CustomAppBar(),
      backgroundColor: const Color(0xFFFDF7E4),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 35),
                GestureDetector(
                  onTap: nextMode,
                  child: IntrinsicWidth(
                    child: Container(
                      height: 55,
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        color: currentMode == PomodoroMode.foco
                            ? theme.primaryColor
                            : currentMode == PomodoroMode.pausaCurta
                            ? theme.secondaryColor
                            : theme.accentColor,
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
                            color: theme.textColor,
                            size: 30,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            currentMode == PomodoroMode.foco
                                ? "Foco"
                                : currentMode == PomodoroMode.pausaCurta
                                ? "Pausa Curta"
                                : "Pausa Longa",
                            style: TextStyle(
                              color: theme.textColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
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
                    Transform.scale(
                      scaleY: 1.3,
                      scaleX: 1.3,
                      child: Text(
                        minutes,
                        style: TextStyle(
                          height: 0.9,
                          fontSize: 200,
                          color: theme.accentColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Transform.scale(
                      scaleY: 1.3,
                      scaleX: 1.3,
                      child: Text(
                        seconds,
                        style: TextStyle(
                          height: 0.9,
                          fontSize: 200,
                          color: theme.accentColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: _showOverlay,
                      child: Container(
                        decoration: BoxDecoration(
                          color: theme.secondaryBotomColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        height: 70,
                        width: 70,
                        child: Icon(
                          Icons.more_horiz,
                          color: theme.textColor,
                          size: 50,
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    GestureDetector(
                      onTap: () => isRunning ? pauseTimer() : startTimer(),
                      child: Container(
                        decoration: BoxDecoration(
                          color: theme.botomPlayColor,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        height: 80,
                        width: 120,
                        child: Icon(
                          isRunning ? Icons.pause : Icons.play_arrow,
                          color: theme.textColor,
                          size: 50,
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    GestureDetector(
                      onTap: resetTimer,
                      child: Container(
                        decoration: BoxDecoration(
                          color: theme.secondaryBotomColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        height: 70,
                        width: 70,
                        child: Icon(
                          Icons.refresh,
                          color: theme.textColor,
                          size: 50,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
