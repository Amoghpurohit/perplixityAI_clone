import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:perplexity_ai_clone/theme/app_theme.dart';
import 'package:perplexity_ai_clone/widgets/answers_section.dart';
import 'package:perplexity_ai_clone/widgets/side_bar.dart';
import 'package:perplexity_ai_clone/widgets/sources_section.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key ,required this.query});

  final String query;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      Row(
        children: [
          kIsWeb ? const SideNavBar() : const SizedBox(),
          SizedBox(width: MediaQuery.of(context).size.width * 0.1),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(query, style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                    const SizedBox(height: 20,),
                    const Row(
                      children: [
                        Icon(Icons.source_outlined, color: AppColors.whiteColor,),
                        SizedBox(width: 10),
                        Text("Sources", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.whiteColor),),
                      ],
                    ),
                    const SizedBox(height: 20,),
                    const SourceSection(),
                    const SizedBox(height: 20,),
                    const AnswersSection(),
                  ],
                ),
              ),
            ),
          ),
          kIsWeb ? const Placeholder(strokeWidth: 0, color: AppColors.backgroundColor,) : const SizedBox()
        ],
      ),
    );
  }
}