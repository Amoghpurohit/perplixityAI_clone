import 'package:flutter/material.dart';
import 'package:perplexity_ai_clone/theme/app_theme.dart';

class TextFieldButton extends StatefulWidget {
  const TextFieldButton({super.key, required this.text, required this.icon});
  final String text;
  final IconData icon;

  @override
  State<TextFieldButton> createState() => _TextFieldButtonState();
}

class _TextFieldButtonState extends State<TextFieldButton> {
  bool isHoveredOn = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          isHoveredOn = true;
        });
      },
      onExit: (_) {
        setState(() {
          isHoveredOn = false;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color:
              isHoveredOn ? AppColors.proButton : null,
        ),
        child: InkWell(
          onTap: () {},
          child: Row(
            children: [
              Icon(
                widget.icon,
                color: AppColors.iconGrey,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                widget.text,
                style: const TextStyle(
                    color: AppColors.iconGrey,
                    fontSize: 12,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
