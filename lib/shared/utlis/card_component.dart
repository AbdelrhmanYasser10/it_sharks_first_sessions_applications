import 'package:flutter/material.dart';
import 'package:it_sharks_first_app/models/news_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/constants.dart';

class CardComponent extends StatelessWidget {
  final Articles article;
  const CardComponent({super.key,required this.article});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()async{
        if (!await launchUrl(Uri.parse(article.url!))) {
          throw Exception('Could not launch ${article.url!}');
        }
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Text(
                article.title ?? "[Title]",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0
                ),
                maxLines: 1,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                article.description ?? "[Description]",
                style: const TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 14.0
                ),
                maxLines: 3,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                height: 10.0,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(12,),
                child: Image.network(
                  article.urlToImage ?? PLACEHOLDERIMAGE,
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                article.author ?? "[Author]",
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 10.0
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
