import 'package:flutter/material.dart';
import 'package:ebbie/config/app_colors.dart';

class CustomReviewMood extends StatefulWidget {
  final String title;
  final void Function(String mood) onConfirm;

  const CustomReviewMood({
    super.key,
    required this.title,
    required this.onConfirm,
  });

  @override
  State<CustomReviewMood> createState() => _CustomReviewMoodState();
}

class _CustomReviewMoodState extends State<CustomReviewMood> {
  String? selectedMood;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        padding: const EdgeInsets.all(20),
        height: 250,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              widget.title,
              style: const TextStyle(
                fontFamily: 'CerebriSansPro',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // Botões de humor
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _moodButton('mal', Colors.red),
                _moodButton('ok', Colors.orange),
                _moodButton('bem', Colors.green),
              ],
            ),

            const Spacer(),

            // Botão Confirmar
            ElevatedButton(
              onPressed: selectedMood != null
                  ? () {
                      widget.onConfirm(selectedMood!);
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.coral,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  'Confirmar',
                  style: TextStyle(
                    fontFamily: 'CerebriSansPro',
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _moodButton(String mood, Color color) {
    final isSelected = selectedMood == mood;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedMood = mood;
        });
      },
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.8) : color.withOpacity(0.4),
          shape: BoxShape.circle,
          border: isSelected ? Border.all(color: Colors.black, width: 2) : null,
        ),
        alignment: Alignment.center,
        child: Text(
          mood.toUpperCase(),
          style: const TextStyle(
            fontFamily: 'CerebriSansPro',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
