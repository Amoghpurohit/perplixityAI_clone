import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:perplexity_ai_clone/services/chat_web_service.dart';
import 'package:perplexity_ai_clone/theme/app_theme.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SourceSection extends StatefulWidget {
  const SourceSection({super.key});

  @override
  State<SourceSection> createState() => _SourceSectionState();
}

class _SourceSectionState extends State<SourceSection> {
  bool isLoading = true;
  List searchResults = [
    {
      'title': 'Ind vs Aus Live Score 4th Test',
      'url':
          'https://www.moneycontrol.com/sports/cricket/ind-vs-aus-live-score-4th-test-shubman-gill-dropped-australia-win-toss-opt-to-bat-liveblog-12897631.html',
    },
    {
      'title': 'Ind vs Aus Live Boxing Day Test',
      'url':
          'https://timesofindia.indiatimes.com/sports/cricket/india-vs-australia-live-score-boxing-day-test-2024-ind-vs-aus-4th-test-day-1-live-streaming-online/liveblog/116663401.cms',
    },
    {
      'title': 'Ind vs Aus - 4 Australian Batters Score Half Centuries',
      'url':
          'https://economictimes.indiatimes.com/news/sports/ind-vs-aus-four-australian-batters-score-half-centuries-in-boxing-day-test-jasprit-bumrah-leads-indias-fightback/articleshow/116674365.cms',
    },
  ];
  late StreamSubscription _subscription;

  @override
  void initState() {
    super.initState();
    _subscription = ChatWebService().getSearchResultController.listen((result) {
      setState(() {
        searchResults = result['results'];
        isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      //skeletonizer is a widget that shows a skeleton while the data is loading
      // but it requires fake data to be passed to it
      enabled: isLoading,
      effect: const ShimmerEffect(
          baseColor: Colors.white,
          highlightColor: AppColors.cardColor,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight, duration: Duration(milliseconds: 1000)),
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: [
          ...searchResults.map((result) {
            return Container(
              padding: const EdgeInsets.all(15),
              width: kIsWeb ? MediaQuery.of(context).size.width * 0.2 : MediaQuery.of(context).size.width * 0.35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.cardColor,
              ),
              child: Column(
                children: [
                  Text(
                    result['title'],
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.whiteColor),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Text(
                    result['url'],
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                        color: AppColors.textGrey),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
