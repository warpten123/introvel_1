import 'package:flutter/material.dart';
import 'package:introvel_1/sql/sql_helper.dart';
import 'package:provider/provider.dart';

import '../../../../models/album.dart';
import '../../../../provider/user_provider.dart';

class AlbumsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return Center(
      child: FutureBuilder<List<Map<String, dynamic>>>(
        future: SQLHelper.getAllAlbums(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final albums = snapshot.data!;
            return ListView.builder(
              itemCount: albums.length,
              itemBuilder: (context, index) {
                final album = albums[index];
                return Card(
                  child: ListTile(
                    title: Text(album['album_title']),
                    subtitle: Text(album['created_at'].toString()),
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
