import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const myImageView = "myImageView";

class MyImageView extends StatefulWidget {
  const MyImageView({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  State<MyImageView> createState() => _MyImageViewState();
}

class _MyImageViewState extends State<MyImageView> {
  final Map<String, dynamic> creationParams = <String, dynamic>{};
  late Key _key;

  @override
  void initState() {
    super.initState();
    _key = UniqueKey();
    creationParams['imageUrl'] = widget.imageUrl;
  }

  @override
  void didUpdateWidget(covariant MyImageView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.imageUrl != widget.imageUrl) {
      creationParams['imageUrl'] = widget.imageUrl;
      _key = UniqueKey();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AndroidView(
      key: _key,
      viewType: myImageView,
      layoutDirection: TextDirection.ltr,
      creationParams: creationParams,
      creationParamsCodec: const StandardMessageCodec(),
    );
  }
}
