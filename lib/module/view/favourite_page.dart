// // import 'package:flutter/material.dart';
// //
// // import 'package:provider/provider.dart';
// // import 'package:quotes_api_app/provider/news_provider.dart';
// // import 'package:quotes_api_app/view/detail_page.dart';
// //
// // class favourite_page extends StatelessWidget {
// //   const favourite_page({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     // News newsdata = ModalRoute.of(context)!.settings.arguments as News;
// //     return Scaffold(
// //       backgroundColor: const Color(0xffBC9798),
// //       appBar: AppBar(
// //         backgroundColor: const Color(0xffBC9798),
// //         title: const Text(
// //           "Favourite",
// //           style: TextStyle(fontWeight: FontWeight.bold),
// //         ),
// //         centerTitle: true,
// //       ),
// //       body: ListView(
// //         children: Provider.of<newsprovider>(context).Favourite.map(
// //           (e) {
// //             return InkWell(
// //               onTap: () {
// //                 Navigator.push(
// //                   context,
// //                   MaterialPageRoute(
// //                     builder: (context) => detal_page(url: e.url),
// //                   ),
// //                 );
// //               },
// //               child: Card(
// //                 elevation: 8,
// //                 shadowColor: const Color(0xffC2D0C1),
// //                 margin: const EdgeInsets.all(10),
// //                 child: Container(
// //                   decoration: BoxDecoration(
// //                     color: const Color(0xffC2D0C1),
// //                     borderRadius: BorderRadius.circular(10),
// //                   ),
// //                   alignment: Alignment.center,
// //                   height: 200,
// //                   width: double.infinity,
// //                   child: const Text(
// //                     ,
// //                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
// //                   ),
// //                 ),
// //               ),
// //             );
// //           },
// //         ).toList(),
// //       ),
// //     );
// //   }
// // }
//
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:quotes_api_app/module/provider/news_provider.dart';
// import 'package:quotes_api_app/module/view/detail_page.dart';
//
// class favourite_page extends StatelessWidget {
//   const favourite_page({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.blue,
//         title: const Text(
//           "My Favourite",
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//       ),
//       body: ListView(
//         children: Provider.of<newsprovider>(context).favourite.map(
//           (e) {
//             return InkWell(
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => detal_page(url: e.url),
//                   ),
//                 );
//               },
//               child: Card(
//                 elevation: 8,
//                 margin: const EdgeInsets.all(10),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: const Color(0xffF2F2F2),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   alignment: Alignment.center,
//                   height: 70,
//                   width: double.infinity,
//                   child: Text(
//                     e.title,
//                     style: const TextStyle(
//                         fontWeight: FontWeight.bold, fontSize: 18),
//                   ),
//                 ),
//               ),
//             );
//           },
//         ).toList(),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:quotes_api_app/module/helper/database_helper.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<Map<String, dynamic>> favorites = [];

  @override
  void initState() {
    super.initState();
    fetchFavorites();
  }

  void fetchFavorites() async {
    final results = await DatabaseHelper().getFavorites();
    setState(() {
      favorites = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          final favorite = favorites[index];
          return ListTile(
            title: Text(favorite[DatabaseHelper.columnName]),
            // Display other information as needed
          );
        },
      ),
    );
  }
}
