import 'package:flutter/material.dart';

class ImageFromResource extends StatelessWidget {
  final String resource;
  const ImageFromResource({Key? key, required this.resource}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getImage(),
      builder: (BuildContext context, AsyncSnapshot<Image> snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }

        if (snapshot.hasData) {
          return Container(
            child: snapshot.data!,
          );
        } else {
          return const Text("データが存在しません");
        }
      },
    );
  }

  Future<Image> getImage() async {
    if (resource.startsWith('asset')) {
      return Image.asset(
        resource,
      );
    }

    throw Exception("Image cannot be displayed");
  }
}
