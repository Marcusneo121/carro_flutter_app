import 'package:cached_network_image/cached_network_image.dart';
import 'package:carro_flutter_app/modules/settings/entity/post.dart';
import 'package:flutter/material.dart';

class SettingItemWidget extends StatelessWidget {
  final Post postItem;
  const SettingItemWidget({
    super.key,
    required this.postItem,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.withOpacity(0.3),
      ),
      padding: const EdgeInsets.all(16),
      margin:
          const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      child: Row(
        children: [
          CachedNetworkImage(
            imageUrl: postItem.thumbnailUrl.toString(),
            imageBuilder: (context, imageProvider) {
              return Container(
                width: 100.0,
                height: 100.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover),
                ),
              );
            },
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  postItem.title.toString(),
                  style: const TextStyle(fontSize: 15.0),
                  overflow: TextOverflow.visible,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
