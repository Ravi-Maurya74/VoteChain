import 'package:flutter/material.dart';


class HomePageDrawer extends StatelessWidget {
  const HomePageDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        AppBar(
          title: Text(
            'Movie Apps',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          leading: null,
          automaticallyImplyLeading: false,
        ),
        ListTile(
          leading: const Icon(
            Icons.person,
            color: Colors.white,
          ),
          title: Text(
            'Account',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          onTap: () {
            // Navigator.pushNamed(context, ChangeAccount.routeName);
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.add_circle,
            color: Colors.white,
          ),
          title: Text(
            'Add movie',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          onTap: () {
            // Navigator.pushNamed(context, AddMoviePage.routeName);
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.bookmarks_rounded,
            color: Colors.white,
          ),
          title: Text(
            'My Bookmarks',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          onTap: () async {
            // var response = await NetworkHelper().postData(
            //     url: 'getBookmarkedMovies/',
            //     jsonMap: {
            //       "user_id": Provider.of<User>(context, listen: false).id
            //     });
            // var data = jsonDecode(utf8.decode(response.bodyBytes));
            // Navigator.pushNamed(context, FilteredMovies.routeName,
            //     arguments: data);
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.power_settings_new,
            color: Colors.white,
          ),
          title: Text(
            'Log out',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          onTap: () {
            // CoolAlert.show(
            //   context: context,
            //   type: CoolAlertType.confirm,
            //   confirmBtnText: 'Confirm',
            //   onConfirmBtnTap: () {
            //     GetStorage().remove('user_id');
            //     SystemNavigator.pop();
            //   },
            // );
          },
        ),
      ]),
    );
  }
}