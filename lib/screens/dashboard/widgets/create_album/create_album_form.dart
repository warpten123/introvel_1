import 'package:flutter/material.dart';
import 'package:introvel_1/screens/dashboard/widgets/view_album/albums_list.dart';
import 'package:introvel_1/sql/sql_helper.dart';
import 'package:provider/provider.dart';

import '../../../../provider/user_provider.dart';
import '../../../../utilities/util.dart';

class CreateAlbumForm extends StatefulWidget {
  @override
  _CreateAlbumFormState createState() => _CreateAlbumFormState();
}

class _CreateAlbumFormState extends State<CreateAlbumForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _albumNameController = TextEditingController();
  TextEditingController _albumDescriptionController = TextEditingController();

  @override
  void dispose() {
    _albumNameController.dispose();
    _albumDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _albumNameController,
            decoration: InputDecoration(
              labelText: 'Album Name',
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter the album name';
              }
              return null;
            },
          ),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                final result = await SQLHelper.createAlbumPictureDiary(
                  userProvider.getStoredUserId(),
                  _albumNameController.text,
                );

                if (result >= 1) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => AlbumsList()),
                  );
                  showSnackBarSuccess(context, "Album Created Successfully!");
                } else {
                  showSnackBarError(context, "Error in creating your album!");
                }
              }
            },
            child: Text('Create Album'),
          ),
        ],
      ),
    );
  }
}
