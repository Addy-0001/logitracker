import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logitracker/core/helper/ui_helpers.dart';

void onImagePickerPick(
  BuildContext context,
  Function(File) onFileSelected, {
  Future<String?> Function(String)? validator,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    enableDrag: true,
    builder:
        (context) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              onTap: () async {
                Navigator.of(context, rootNavigator: false).pop();
                final value = await ImagePicker().pickImage(
                  source: ImageSource.camera,
                  imageQuality: 40,
                );
                try {
                  if (value != null) {
                    if (validator == null) {
                      onFileSelected(File(value.path));
                    } else {
                      var resp = await validator(value.path);
                      if (resp == null) {
                        onFileSelected(File(value.path));
                      } else {
                        displayToastFailure(resp);
                      }
                    }
                  }
                } catch (e) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(e.toString())));
                }
              },
              leading: const Icon(Icons.camera_alt_outlined),
              title: const Text("From Camera"),
            ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              onTap: () async {
                Navigator.of(context, rootNavigator: false).pop();
                final value = await ImagePicker().pickImage(
                  source: ImageSource.gallery,
                  imageQuality: 40,
                );
                try {
                  if (value != null) {
                    if (validator == null) {
                      onFileSelected(File(value.path));
                    } else {
                      var resp = await validator(value.path);
                      if (resp == null) {
                        onFileSelected(File(value.path));
                      } else {
                        displayToastFailure(resp);
                      }
                    }
                  }
                } catch (e) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(e.toString())));
                }
              },
              leading: const Icon(Icons.image),
              title: const Text("From Gallery"),
            ),
          ],
        ),
  );
}
