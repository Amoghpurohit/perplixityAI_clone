import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:perplexity_ai_clone/services/chat_web_service.dart';
import 'package:perplexity_ai_clone/widgets/search_section.dart';
import 'package:perplexity_ai_clone/widgets/side_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
    ChatWebService().connect();
  }

  @override
  Widget build(BuildContext context) {
    
    return const Scaffold(
      body: Row(
        children: [
          kIsWeb ? SideNavBar() : SizedBox(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SearchSection(),
                ],
              ),
            ),  
          )
        ],
      ),
    );
  }
}