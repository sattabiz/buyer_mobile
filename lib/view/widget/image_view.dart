import 'package:flutter/material.dart';
import 'app_bar/top_app_bar_centered.dart';

class ImageView extends StatelessWidget {
  final String imageUrl;
  const ImageView({Key? key,required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const TopAppBarCentered(title: "Fotoğraf",backRoute: "null"),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Image.network(
           loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator( 
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                      : null,
                ),
              );
            },
           fit: BoxFit.fill,
           imageUrl
          ),
        ));
  }
}
