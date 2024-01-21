import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';

import '../../view_model/proposal_controller/create_proposal_view_model.dart';

class ImageDialog extends ConsumerStatefulWidget {
  final int productId;
  final Function onImageRemove;

  ImageDialog({
    Key? key,
    required this.productId,
    required this.onImageRemove,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ImageDialogState();
}

class _ImageDialogState extends ConsumerState<ImageDialog> {
  @override
  Widget build(BuildContext context) {
    final imageFile = ref.watch(formItemProvider.notifier).isImageXfile(widget.productId);

    return AlertDialog(
      titleTextStyle: Theme.of(context).textTheme.titleLarge,
      titlePadding: const EdgeInsets.all(0.0),
      actionsAlignment: MainAxisAlignment.center,
      title: Container(
        height: 60,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          color: Theme.of(context).colorScheme.secondaryContainer,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 20),
                alignment: Alignment.centerLeft,
                child: const Text('Seçilen Fotoğraf'),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 20),
              child: IconButton(
                iconSize: 30,
                color: Theme.of(context).colorScheme.shadow,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.close),
              ),
            ),
          ],
        ),
      ),
      content: SingleChildScrollView(
        child: Center(
          child: Container(
            width: 300,
            height: 300,
            child: imageFile != null
                ? Image.file(
                    File(imageFile.path),
                    fit: BoxFit.contain,
                  )
                : const Center(child: Text("Fotoğraf bulunamadı.")),
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Sil'),
          onPressed: () {
            ref.read(formItemProvider.notifier).removeImage(widget.productId);
            widget.onImageRemove();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}