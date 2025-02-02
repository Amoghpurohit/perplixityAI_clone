import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:perplexity_ai_clone/pages/chat_page.dart';
import 'package:perplexity_ai_clone/services/chat_web_service.dart';
import 'package:perplexity_ai_clone/theme/app_theme.dart';
import 'package:perplexity_ai_clone/widgets/text_field_buttons.dart';

class SearchSection extends StatefulWidget {
  const SearchSection({super.key});

  @override
  State<SearchSection> createState() => _SearchSectionState();
}

class _SearchSectionState extends State<SearchSection> {
  final queryController = TextEditingController();
  bool isHoveredOn = false;
  bool isIncreaseWidth = false;
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    queryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Expanded(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            
            children: [
              const Text(
                'Where Knowledge Begins',
                style: TextStyle(
                    color: AppColors.iconGrey,
                    fontSize: 40,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 30,
              ),
              Focus(
                focusNode: _focusNode,
                onFocusChange: (hasFocus) {
                  setState(() {
                    isIncreaseWidth = hasFocus;
                  });
                },
                child: MouseRegion(
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
                    width: kIsWeb ? MediaQuery.of(context).size.width * 0.5 : MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                      color: AppColors.searchBar,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: AppColors.searchBarBorder,
                        width: isIncreaseWidth ? 1.5 : 0,
                      ),
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                      child: Column(
                        children: [
                          TextField(
                            controller: queryController,
                            decoration: const InputDecoration(
                              hintText: 'Search Anything...',
                              hintStyle: TextStyle(color: AppColors.textGrey),
                              border: InputBorder.none,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Row(
                              children: [
                                const TextFieldButton(
                                    text: 'Focus', icon: Icons.auto_awesome_outlined),
                                const SizedBox(
                                  width: 12,
                                ),
                                const TextFieldButton(
                                    text: 'Images', icon: Icons.image),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    ChatWebService()
                                        .chat(queryController.text.trim());
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ChatPage(
                                            query: queryController.text.trim(),
                                          ),
                                        ));
                                  },
                                  child: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(40),
                                          color: AppColors.submitButton),
                                      child: const Icon(
                                        Icons.arrow_forward,
                                        color: AppColors.backgroundColor,
                                        size: 16,
                                      )),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
