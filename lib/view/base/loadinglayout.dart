

import 'package:flutter/material.dart';

class DetailScreenLoadingLayout extends StatelessWidget {
  const DetailScreenLoadingLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          width: MediaQuery.of(context).size.width,
          height: 210,
          color: Colors.grey[400],
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          width: MediaQuery.of(context).size.width / 2,
          height: 20,
          color: Colors.grey[400],
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          width: MediaQuery.of(context).size.width,
          height: 30,
          color: Colors.grey[400],
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          width: MediaQuery.of(context).size.width ,
          height: 20,
          color: Colors.grey[400],
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          width: MediaQuery.of(context).size.width / 2,
          height: 20,
          color: Colors.grey[400],
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          width: MediaQuery.of(context).size.width ,
          height: 100,
          color: Colors.grey[400],
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          width: MediaQuery.of(context).size.width / 2,
          height: 20,
          color: Colors.grey[400],
        ),
        ListView.builder(
            itemCount: 5,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index){
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                width: MediaQuery.of(context).size.width ,
                height: 100,
                color: Colors.grey[400],
              );
            }
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          width: MediaQuery.of(context).size.width / 2,
          height: 20,
          color: Colors.grey[400],
        ),
        SizedBox(
          height: 250,
          child: ListView.builder(
              itemCount: 10,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (context, index){
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 3),
                  width: 160,
                  height: 100,
                  color: Colors.grey[400],
                );
              }
          ),
        )
      ],
    );
  }
}

class DownloadScreenLoadingLayout extends StatelessWidget {
  const DownloadScreenLoadingLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          width: MediaQuery.of(context).size.width,
          height: 150,
          color: Colors.grey[400],
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          width: MediaQuery.of(context).size.width,
          height: 150,
          color: Colors.grey[400],
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          width: MediaQuery.of(context).size.width,
          height: 150,
          color: Colors.grey[400],
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          width: MediaQuery.of(context).size.width,
          height: 150,
          color: Colors.grey[400],
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          width: MediaQuery.of(context).size.width,
          height: 150,
          color: Colors.grey[400],
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          width: MediaQuery.of(context).size.width,
          height: 150,
          color: Colors.grey[400],
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          width: MediaQuery.of(context).size.width,
          height: 150,
          color: Colors.grey[400],
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          width: MediaQuery.of(context).size.width,
          height: 150,
          color: Colors.grey[400],
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          width: MediaQuery.of(context).size.width,
          height: 150,
          color: Colors.grey[400],
        ),

      ],
    );
  }
}
