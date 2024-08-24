import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../models/plant_model.dart';

Expanded shimmer_loading(List<String> category) {
  return Expanded(
    child: Column(
      children: [
        SizedBox(
          height: 32,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: category.length,
            // Same number of shimmer items as categories
            itemBuilder: (context, index) {
              return Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  height: 20,
                  width: 100,
                  padding: const EdgeInsets.symmetric(
                      vertical: 5, horizontal: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
            },
            separatorBuilder:
                (BuildContext context, int index) {
              return const SizedBox(width: 10);
            },
          ),
        ),
        const SizedBox(height: 24),
        Expanded(
          child: ListView.builder(
            itemCount: 6,
            itemBuilder: (context, index) {
              return Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Padding(
                  padding:
                  const EdgeInsets.only(bottom: 16.0),
                  child: Row(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 100.0,
                        height: 100.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                          BorderRadius.circular(8.0),
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              height: 16.0,
                              color: Colors.white,
                            ),
                            const SizedBox(height: 8.0),
                            Container(
                              width: double.infinity,
                              height: 16.0,
                              color: Colors.white,
                            ),
                            const SizedBox(height: 8.0),
                            Container(
                              width: 100.0,
                              height: 16.0,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    ),
  );
}
SizedBox horizontal_listview(List<dynamic> data) {
  return SizedBox(
    height: 32,
    child: ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: data.length,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.symmetric(
              vertical: 5, horizontal: 15),
          decoration: BoxDecoration(
            color: index == 1
                ? const Color(0xFFB08888)
                : const Color(0XFFF4F4F4),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              "${data[index]}",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: index != 1
                    ? const Color(0xFF000000)
                    .withOpacity(0.4)
                    : Colors.white,
              ),
            ),
          ),
        );
      },
      separatorBuilder:
          (BuildContext context, int index) {
        return const SizedBox(width: 10);
      },
    ),
  );
}
Stack free_shipping_banner() {
  return Stack(
    children: [
      Container(
        height: 112,
        margin: const EdgeInsets.symmetric(
            vertical: 10),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius:
          BorderRadius.circular(10),
          gradient: const LinearGradient(
            colors: [
              Color(0xffDCEEFF),
              Color(0xffFFE6CF)
            ],
          ),
        ),
        child: Row(
          mainAxisAlignment:
          MainAxisAlignment.start,
          children: [
            Padding(
              padding:
              const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Free Shipping',
                    style: TextStyle(
                      fontSize: 14,
                      letterSpacing: 0.4,
                      fontWeight:
                      FontWeight.w800,
                      color: Colors.black,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'on orders ',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight:
                          FontWeight.w500,
                          color: Colors.black
                              .withOpacity(0.4),
                        ),
                      ),
                      Container(
                        padding:
                        const EdgeInsets
                            .symmetric(
                            horizontal: 4,
                            vertical: 0),
                        decoration:
                        BoxDecoration(
                          borderRadius:
                          BorderRadius
                              .circular(5),
                          color: const Color(
                              0xffFFC37C),
                        ),
                        child: const Text(
                          'over \$100',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight:
                            FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      Positioned(
        right: 30,
        bottom: 10,
        child: Image.asset(
            'assets/free_shipping.png',
            height: 128),
      ),
    ],
  );
}

Container plant_tile(int index, Plant plant) {
  return Container(
    height: 112,
    margin:
    const EdgeInsets.symmetric(vertical: 5),
    child: Row(
      mainAxisAlignment:
      MainAxisAlignment.center,
      crossAxisAlignment:
      CrossAxisAlignment.center,
      children: [
        Stack(
          children: [
            Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius:
                    BorderRadius.circular(
                        16),
                  ),
                  clipBehavior: Clip.none,
                  child: const SizedBox(
                    height: 20,
                    width: 112,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: index % 2 != 0
                        ? const Color(
                        0xFFFFF3E9)
                        : const Color(
                        0xFFE9F7FF),
                    borderRadius:
                    BorderRadius.circular(
                        16),
                  ),
                  clipBehavior: Clip.none,
                  child: const SizedBox(
                    height: 85,
                    width: 112,
                  ),
                ),
              ],
            ),
            Positioned(
              top: -15,
              child: Image.network(
                plant.imageUrl,
                height: 120,
                width: 112,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 10,
              right: 10,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                  BorderRadius.circular(4),
                ),
                height: 22,
                width: 22,
                child: Icon(
                  Icons.favorite_border,
                  size: 14,
                  color: Colors.black
                      .withOpacity(0.3),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            mainAxisAlignment:
            MainAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          plant.name,
                          style:
                          const TextStyle(
                            fontSize: 15,
                            fontWeight:
                            FontWeight.w700,
                          ),
                          overflow: TextOverflow
                              .ellipsis,
                        ),
                      ),
                      Text(
                        "⭐ ${plant.rating}",
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight:
                          FontWeight.w600,
                          color:
                          Color(0xFFFFBB56),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "${plant.displaySize} cm",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight:
                      FontWeight.w500,
                      color: const Color(
                          0xFF000000)
                          .withOpacity(0.4),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Text(
                "${plant.price}\$",
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF000000),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ],
    ),
  );
}


