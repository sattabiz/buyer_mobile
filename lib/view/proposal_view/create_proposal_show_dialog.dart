import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../view_model/proposal_controller/create_proposal_view_model.dart';

class CreateProposalShowDialog extends ConsumerStatefulWidget {
  int productId;
  final Function onImageSelected;
  CreateProposalShowDialog({super.key, required this.productId, required this.onImageSelected});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _State();
}

class _State extends ConsumerState<CreateProposalShowDialog> {
  String? fileName;

  @override
  void initState() {
    super.initState();
  }

  bool isFileSelected() {
    if (ref.watch(formItemProvider)[widget.productId].image == null) {
      return false;
    } else {
      return true;
    }
  }
  void handleImageSelection() {
    widget.onImageSelected(); 
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titleTextStyle: Theme.of(context).textTheme.titleLarge,
      titlePadding: const EdgeInsets.all(0.0),
      actionsAlignment: MainAxisAlignment.center,
      title: Container(
        width: 450,
        height: 60,
        constraints: const BoxConstraints(
          minWidth: 200,
        ),
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
                  child: const Text('Dosya Yükleme')),
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
      content: Container(
        height: 107,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            button(context,
             FlutterI18n.translate(context, "tr.proposal.open_camera"),
              Icons.camera_alt_rounded,
              () async {
                XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
                if (pickedFile != null) {
                  File imageFile = File(pickedFile.path);
                  MultipartFile filetoMultipart = await MultipartFile.fromFile(imageFile.path);
                  ref.read(formItemProvider.notifier).addImage(widget.productId, filetoMultipart, pickedFile);
                  handleImageSelection();
                  Navigator.of(context).pop();
                }
              }
            ),
            button(context,
              FlutterI18n.translate(context, "tr.proposal.open_gallery"),
              Icons.photo_library,
              ()async{
                XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                if (pickedFile != null) {
                  File imageFile = File(pickedFile.path);
                  MultipartFile filetoMultipart = await MultipartFile.fromFile(imageFile.path);
                  ref.read(formItemProvider.notifier).addImage(widget.productId, filetoMultipart, pickedFile);
                  handleImageSelection();
                  Navigator.of(context).pop();
                }
              }
            ),
          ],
        ),
      ),
    );
  }

  Container button(BuildContext context, String buttonName, dynamic iconData,void Function() function) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 5),
      child: OutlinedButton(
        onPressed: function,
        style: ButtonStyle(
          fixedSize: MaterialStateProperty.all(const Size(120, 40)),
          overlayColor: MaterialStateProperty.all(
              Theme.of(context).colorScheme.secondaryContainer),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(
                color: Theme.of(context).colorScheme.shadow,
              ),
            ),
          ),
        ),
        /*  */
        child: Row(
          children: [
            Icon(iconData, color: Colors.black,),
            const SizedBox(width: 5,),
            Text(buttonName,
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Theme.of(context).colorScheme.shadow,
                    )),
          ],
        ),
      ),
    );
  }
  
  
}
