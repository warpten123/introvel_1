import 'package:flutter/material.dart';
import 'package:introvel_1/screens/dashboard/widgets/create_album/create_album_form.dart';

void showCustomModalBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return CreateAlbumForm();
    },
  );
}
