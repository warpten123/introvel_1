import 'package:flutter/material.dart';
import 'package:introvel_1/sql/sql_helper.dart';
import 'package:provider/provider.dart';

import '../../../../models/album.dart';
import '../../../../provider/user_provider.dart';

class AlbumsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return Material(
      child: FutureBuilder<List<Album>>(
        future: SQLHelper.getAlbumsUser(userProvider.getStoredUserId()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final albums = snapshot.data!;
            print("albums ${albums}");
            return ListView.builder(
              itemCount: albums.length,
              itemBuilder: (context, index) {
                final album = albums[index];
                return Card(
                  child: ListTile(
                    title: Text(album.album_title),
                    trailing: Text(album.diary_id.toString()),
                    subtitle: Text(album.created_at),
                    // Add more widgets to display album details
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
