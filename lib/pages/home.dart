/*
 *  This file is part of Rhythm (https://github.com/EncryptoCyphers/Rhythm).
 * 
 * Rhythm is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * Rhythm is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with Rhythm.  If not, see <http://www.gnu.org/licenses/>.
 * 
 * Copyright (c) 2022-2023, EncryptoCyphers
 */
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Home extends StatelessWidget {
  const Home({
    super.key,
    required this.nm,
  });
  final String nm;
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Hello, $nm',
                style: const TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: 'Ubuntu',
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Padding(
                    padding: EdgeInsets.only(right: 0),
                    /*child: Icon(
                      Icons.search,
                      size: 28,
                      color: Colors.white,
                    ),*/
                  ),
                  /*Icon(
                    Icons.settings,
                    size: 28,
                    color: Colors.white,
                  ),*/
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        CarouselSlider(
            items: [
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  image: DecorationImage(
                    image: AssetImage('images/pop.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  image: DecorationImage(
                    image: AssetImage('images/party.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  image: DecorationImage(
                    image: AssetImage('images/newrelease.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  image: DecorationImage(
                    image: AssetImage('images/edm.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  image: DecorationImage(
                    image: AssetImage('images/rock.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  image: DecorationImage(
                    image: AssetImage('images/classics.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
            options: CarouselOptions(
              height: 200.0,
              autoPlay: true,
              autoPlayCurve: Curves.easeInOut,
              enlargeCenterPage: true,
            )),
        const Padding(
          padding: EdgeInsets.only(left: 20, top: 20),
          child: Text(
            'Most Popular',
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: 'Ubuntu',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          // ignore: sized_box_for_whitespace
          child: Container(
            height: 110,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Container(
                  width: 120,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    image: DecorationImage(
                      image: AssetImage('images/pop.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  width: 120,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    image: DecorationImage(
                      image: AssetImage('images/party.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  width: 120,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    image: DecorationImage(
                      image: AssetImage('images/classics.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  width: 120,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    image: DecorationImage(
                      image: AssetImage('images/edm.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  width: 120,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    image: DecorationImage(
                      image: AssetImage('images/newrelease.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  width: 120,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    image: DecorationImage(
                      image: AssetImage('images/rock.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text(
            'Favourites',
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: 'Ubuntu',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          // ignore: sized_box_for_whitespace
          child: Container(
            height: 110,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Container(
                  width: 120,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    image: DecorationImage(
                      image: AssetImage('images/pop.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  width: 120,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    image: DecorationImage(
                      image: AssetImage('images/party.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  width: 120,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    image: DecorationImage(
                      image: AssetImage('images/classics.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  width: 120,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    image: DecorationImage(
                      image: AssetImage('images/edm.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  width: 120,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    image: DecorationImage(
                      image: AssetImage('images/newrelease.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  width: 120,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    image: DecorationImage(
                      image: AssetImage('images/rock.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text(
            'Recently Played',
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'Ubuntu',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          // ignore: sized_box_for_whitespace
          child: Container(
            height: 110,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Container(
                  width: 120,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    image: DecorationImage(
                      image: AssetImage('images/pop.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  width: 120,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    image: DecorationImage(
                      image: AssetImage('images/party.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  width: 120,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    image: DecorationImage(
                      image: AssetImage('images/classics.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  width: 120,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    image: DecorationImage(
                      image: AssetImage('images/edm.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  width: 120,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    image: DecorationImage(
                      image: AssetImage('images/newrelease.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  width: 120,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    image: DecorationImage(
                      image: AssetImage('images/rock.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
