import 'package:flutter/material.dart';
import 'package:wanandroid_flutter/util/apis.dart';
import 'package:wanandroid_flutter/widget/article_item_view.dart';
import 'package:wanandroid_flutter/widget/refreshable_list.dart';
import 'package:wanandroid_flutter/config/tag.dart';
import 'package:wanandroid_flutter/widget/home_banner.dart';
import 'package:wanandroid_flutter/util/nav_util.dart';
import 'package:wanandroid_flutter/config/event.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RefreshableList(
      [
        Apis.banner(),
        Apis.topArticles(),
        Apis.articles,
      ],
      [
        '',
        '',
        'datas',
      ],
      [
        Tags.banner,
        Tags.top,
        Tags.normal,
      ],
      (item, index) {
        if (item is List) {
          return HomeBanner(
            item,
            (item) {
              NavUtil.navToWeb(context, item['url'], item['title']);
            },
          );
        }
        switch (item['localTag']) {
          case Tags.top:
            item['isTop'] = true;
            return ArticleItemView(item);
          case Tags.normal:
            return ArticleItemView(item);
            break;
        }
      },
      listenTypes: [Login, SwitchFavorite],
    );
  }
}
