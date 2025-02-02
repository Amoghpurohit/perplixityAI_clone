import 'package:flutter/material.dart';
import 'package:perplexity_ai_clone/theme/app_theme.dart';

class SideNavBar extends StatefulWidget {
  const SideNavBar({super.key});

  @override
  State<SideNavBar> createState() => _SideNavBarState();
}

class _SideNavBarState extends State<SideNavBar> {
  bool isCollapsed = true;

  final iconsMap = [
    {
      "icon": const Icon(Icons.add),
      "label": "New Chat",
    },
    {
      "icon": const Icon(Icons.search),
      "label": "Search",
    },
    {
      "icon": const Icon(Icons.language),
      "label": "Spaces",
    },
    {
      "icon": const Icon(Icons.auto_awesome),
      "label": "Discover",
    },
    {
      "icon": const Icon(Icons.cloud),
      "label": "Library",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: isCollapsed ? 64 : 200,
      color: AppColors.sideNav,
      child: Padding(
        padding: EdgeInsets.only(left: isCollapsed ? 0 : 14),
        child: Column(
          crossAxisAlignment: isCollapsed
              ? CrossAxisAlignment.center
              : CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 40),
              child: isCollapsed
                  ? const Icon(Icons.auto_awesome_mosaic,
                      color: AppColors.iconGrey, size: 22)
                  : const Row(
                      children: [
                        Icon(Icons.auto_awesome_mosaic,
                            color: AppColors.iconGrey, size: 22),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Perplexity AI",
                          style: TextStyle(
                              color: AppColors.iconGrey, fontSize: 16),
                        ),
                      ],
                    ),
            ),
            ...iconsMap.map(
              (e) => Container(
                margin: const EdgeInsets.symmetric(vertical: 14),
                child: isCollapsed
                    ? Icon(
                        (e["icon"] as Icon).icon!,
                        color: AppColors.iconGrey,
                        size: 22,
                      )
                    : Row(
                        children: [
                          Icon(
                            (e["icon"] as Icon).icon!,
                            color: AppColors.iconGrey,
                            size: 22,
                          ),
                          const SizedBox(
                            width: 7,
                          ),
                          Text(
                            e["label"] as String,
                            style: const TextStyle(
                                color: AppColors.iconGrey, fontSize: 16),
                          ),
                        ],
                      ),
              ),
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                setState(() {
                  isCollapsed = !isCollapsed;
                });
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 14),
                child: isCollapsed
                    ? const Icon(
                        Icons.keyboard_arrow_right,
                        color: AppColors.iconGrey,
                        size: 22,
                      )
                    : const Icon(
                        Icons.keyboard_arrow_left,
                        color: AppColors.iconGrey,
                        size: 22,
                      ),
              ),
            ),
            const SizedBox(height: 14),
          ],
        ),
      ),
    );
  }
}
