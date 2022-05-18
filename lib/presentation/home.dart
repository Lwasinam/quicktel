import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:quicktel/domain/query.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.menu, size: 30),
                    Icon(Icons.notifications_none_outlined,
                        size: 33, color: Colors.grey)
                  ],
                ),
                SizedBox(
                  height: 18,
                ),
                SizedBox(
                    height: 60,
                    child: Material(
                      borderRadius: BorderRadius.circular(30.0),
                      color: Colors.transparent,
                      elevation: 9,
                      shadowColor: Colors.grey.withOpacity(0.5),
                      child: TextFormField(
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w500),
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search_rounded),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            // enabledBorder: OutlineInputBorder(
                            //   borderRadius: BorderRadius.circular(20.0),
                            //   borderSide: BorderSide(color: Colors.white),
                            // ),
                            // focusedBorder: OutlineInputBorder(
                            //   borderRadius: BorderRadius.circular(20.0),
                            //   borderSide: BorderSide(color: Colors.white),
                            // ),
                            // hintText: "Name",
                            hintText: 'What are you looking for?',
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 16.0),
                            filled: true,
                            fillColor: Colors.white),
                      ),
                    )),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: 85,
                  child: CarouselSlider(
                    options: CarouselOptions(
                        autoPlay: true, viewportFraction: 1, height: 85),
                    items: [
                      'Fashion Sale',
                      'Black Friday',
                      'Tech Week',
                      'Clothing',
                      "Shoes sale"
                    ].map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                              padding: EdgeInsets.only(left: 20),
                              width: MediaQuery.of(context).size.height,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  image: DecorationImage(
                                      colorFilter: ColorFilter.mode(
                                        Colors.orange,
                                        // Color(0xffA412),
                                        BlendMode.softLight,
                                      ),
                                      fit: BoxFit.cover,
                                      image: AssetImage('assets/fsh.jpg')),
                                  color: Colors.amber),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    i,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 38.0),
                                  ),
                                  Text(
                                    'See more >',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18.0),
                                  ),
                                ],
                              ));
                        },
                      );
                    }).toList(),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Shops Near You",
                      style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "See All >",
                      style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 130,
                  color: Colors.white,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: (BuildContext context, int index) {
                      List categories = [
                        'Jay Collection',
                        'YGC Shoes',
                        'Phones',
                        'Computers'
                      ];
                      return Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(
                          left: 10,
                          right: 10,
                        ),
                        width: 130,
                        height: 50,
                        child: Center(
                            child: Text(categories[index],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.white))),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage("assets/image$index.jpg")),
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Featured",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
                ),
                Flexible(
                  child: Query(
                      options: QueryOptions(document: gql(readProducts)),
                      builder: (QueryResult result,
                          {VoidCallback? refetch, FetchMore? fetchMore}) {
                        if (result.hasException) {
                          return Center(
                            child: Text(result.exception.toString()),
                          );
                        }

                       //get products from api
                        List products = result.data!['getInventoriesAtRandom'];
                        return GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 2 / 3.5,
                            crossAxisCount: 2,
                          ),
                          itemCount: products.length,
                          itemBuilder: (BuildContext context, int index) {
                            // print(result.data!['getInventoriesAtRandom']);

                            // print(products[index]['inventoryName']);

                            //Getting data from API
                            String inventoryName =
                                products[index]['inventoryName'];
                            String inventoryDescriptions =
                                products[index]['inventoryDescription'];
                            var imageUrl = products[index]['Images'][0]
                                ['mediumImageOnlineURL'];
                            // print(inventoryName);
                            // print(inventoryDescriptions);
                            // print(imageUrl);

                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Stack(
                                children: [
                                  Container(
                                    // height: 150,
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    // color: Colors.black,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 200,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: AssetImage(
                                                    'assets/cloth.jpg')),
                                            color: Colors.blue,
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                            height: 20,
                                            // width: 10,
                                            child: RatingBar.builder(
                                              initialRating: 5,
                                              minRating: 1,
                                              direction: Axis.vertical,
                                              allowHalfRating: false,
                                              itemSize: 15,
                                              itemCount: 5,
                                              itemPadding: EdgeInsets.symmetric(
                                                  horizontal: 0.0),
                                              itemBuilder: (context, _) => Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                              ),
                                              onRatingUpdate: (rating) {
                                                print(rating);
                                              },
                                            )),
                                        Container(
                                            height: 30,
                                            child: Text(
                                              inventoryName,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                            )),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "N 499",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "N199",
                                              style: TextStyle(
                                                color: Colors.grey,
                                                  decoration: TextDecoration
                                                      .lineThrough),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    left: 100,
                                    top: 180,
                                    child: Material(
                                      borderRadius: BorderRadius.circular(30),
                                      elevation: 4,
                                      child: Container(
                                        height: 40,
                                        width: 40,
                                        child: Center(
                                          child: Icon(
                                            Icons.favorite_outline,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(30.0)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
