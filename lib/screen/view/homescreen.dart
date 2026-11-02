import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/apiservice/movieapi.dart';
import 'package:flutter_application_1/model/model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> genres = const [
    "Action",
    "Adventure",
    "Animation",
    "Comedy",
    "Documentary",
    "Drama",
    "Fantasy",
    "Horror",
    "Sci-Fi",
    "Thriller",
  ];

  List<Movie> datanow = [];
  List<MoviePop> popData = [];
  final api = Movieapi();
  int popIndex = 0;
  Timer? popTimer;
  @override
  void initState() {
    super.initState();
    fetchdata();
  }

  Future<void> fetchdata() async {
    final data = await api.getdata();
    final popdata = await api.popget();
    setState(() {
      datanow = data;
      popData = popdata;
    });
    if (popData.isNotEmpty) {
      popTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
        if (!mounted || popData.isEmpty) return;

        setState(() {
          popIndex = (popIndex + 1) % popData.length;
        });
      });
    }
  }

  int currentindex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff080808),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                // 1. HERO IMAGE (Placed first so it stays at the bottom of the stack)
                Container(
                  height: 730,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image:
                        datanow.isNotEmpty &&
                            datanow[currentindex].backdropPath != null
                        ? DecorationImage(
                            image: NetworkImage(
                              "https://image.tmdb.org/t/p/original${datanow[currentindex].backdropPath}",
                            ),
                            fit: BoxFit.cover,
                          )
                        : const DecorationImage(
                            image: AssetImage("assets/images/hero.jpg"),
                            fit: BoxFit.cover,
                          ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(25),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black],
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          datanow[currentindex].title.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          datanow[currentindex].overview.toString(),
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 40),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          onPressed: () {},
                          child: const Text(
                            "Watch Now",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // 2. TRANSPARENT NAVIGATION BAR (Placed second so it overlays on top)
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    color: Colors.transparent, // Displays the image behind it
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 15,
                    ),
                    child: Row(
                      children: [
                        const Text(
                          "CINEPHILE",
                          style: TextStyle(
                            color: Color.fromARGB(255, 192, 161, 158),
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const Spacer(),
                        ...["Home", "Movies", "TV Shows", "Genres"].map(
                          (e) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              e,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        const Icon(Icons.search, color: Colors.white, size: 18),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            //================ TRENDING TITLE =================
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Trending Now",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 15),

            //================ MOVIE LIST =================
            SizedBox(
              height: 230,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: datanow.length,
                itemBuilder: (context, index) {
                  final movie = datanow[index];

                  return InkWell(
                    onTap: () {
                      setState(() {
                        currentindex = index;
                      });
                    },
                    child: Container(
                      width: 120,
                      margin: const EdgeInsets.only(right: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              "https://image.tmdb.org/t/p/w500${movie.posterPath}",
                              width: 120,
                              height: 170,
                              fit: BoxFit.cover,
                            ),
                          ),

                          SizedBox(height: 8),

                          Text(
                            movie.title ?? "",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 35),
            //================ FEATURE BANNER =================
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              height: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image:
                    popData.isNotEmpty && popData[popIndex].posterPath != null
                    ? DecorationImage(
                        image: NetworkImage(
                          "https://image.tmdb.org/t/p/w500${popData[popIndex].posterPath}",
                        ),
                        fit: BoxFit.cover,
                      )
                    : const DecorationImage(
                        image: AssetImage("assets/images/hero.jpg"),
                        fit: BoxFit.cover,
                      ),
              ),
              child: Container(
                padding: EdgeInsets.all(20),
                alignment: Alignment.bottomLeft,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  gradient: LinearGradient(
                    colors: [Colors.black, Colors.transparent],
                  ),
                ),
                child: Text(
                  "https://image.tmdb.org/t/p/w500${popData[popIndex].title}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            SizedBox(height: 35),

            //================ GENRE TITLE =================
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Browse by Genre",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            //================ GENRES =================
            Padding(
              padding: EdgeInsets.all(20),
              child: Wrap(
                spacing: 10,
                runSpacing: 12,
                children: genres.map((e) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade900,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      e,
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  );
                }).toList(),
              ),
            ),

            SizedBox(height: 50),

            //================ FOOTER =================
            Container(
              padding: EdgeInsets.all(25),
              color: Color(0xff050505),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "CINEPHILE",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Explore",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: 10),

                          Text(
                            "Featured\nCategories\nNew Releases",
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ],
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Company",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: 10),

                          Text(
                            "About\nCareers\nContact",
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ],
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Newsletter",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: 10),

                          Text(
                            "Subscribe\nGet updates",
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: 40),

                  Text(
                    "© 2026 Cinephile. All rights reserved.",
                    style: TextStyle(color: Colors.grey, fontSize: 11),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
