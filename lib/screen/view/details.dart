import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/model.dart';

class Details extends StatefulWidget {
  final Movie movieItem;

  const Details({super.key, required this.movieItem});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    final movieItem = widget.movieItem;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                'https://image.tmdb.org/t/p/original/${movieItem.backdropPath}',
              ),
            ),
          ),
          child: Container(
            color: Colors.black.withOpacity(.6),
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 70),

                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          "https://image.tmdb.org/t/p/original/${movieItem.backdropPath}",
                        ),
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                        color: Colors.black.withOpacity(.6),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(
                              Icons.arrow_circle_left_outlined,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),

                          const SizedBox(height: 60),

                          /// RATING + LANGUAGE
                          Row(
                            children: [
                              Text(
                                "${movieItem.voteAverage} 💫",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(width: 10),

                              Text(
                                movieItem.originalLanguage ?? "",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 10),

                          /// TITLE
                          Text(
                            movieItem.title ?? "",
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 40,
                            ),
                          ),

                          const SizedBox(height: 10),

                          /// YEAR + POPULARITY
                          Row(
                            children: [
                              Text(
                                movieItem.releaseDate != null
                                    ? "${movieItem.releaseDate!.year} | "
                                    : "",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              Text(
                                "${movieItem.popularity} 💥",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 20),

                          /// OVERVIEW
                          Text(
                            movieItem.overview ?? "",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),

                          const SizedBox(height: 30),

                          /// BUTTONS
                          Row(
                            children: [
                              MaterialButton(
                                onPressed: () {},
                                minWidth: 120,
                                height: 60,
                                color: Colors.red,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: const Text(
                                  "Stream Now",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),

                              const SizedBox(width: 14),

                              MaterialButton(
                                onPressed: () {},
                                minWidth: 120,
                                height: 60,
                                color: Colors.grey.shade900,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: const Text(
                                  "Watch Later",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
