
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ymcs/modules/webViwe/view.dart';
import 'package:ymcs/shared/cubit/cubit.dart';
import 'package:ymcs/shared/cubit/states.dart';
import 'package:ymcs/shared/network/linked.dart';

class Sports extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state){},
      builder: (context,state){
        List<dynamic> list = NewsCubit.get(context).sport;
        return ConditionalBuilder(
          condition: list.length>0,
          builder:(context)=>itemNews(list),
          fallback: (context)=>Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
  Widget itemNews(list) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0,bottom: 10.0),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children:
          [
            CarouselSlider.builder(
              itemCount: list.length,
              itemBuilder: (context, index, s) {
                return InkWell(
                  onTap: (){
                    navigateTo(context,View(list[index]['url']),);
                  },
                  child: Container(
                    child: Stack(
                      children: [
                        CachedNetworkImage(
                          width: 1000,
                          imageUrl: list[index]['urlToImage'],
                          fit: BoxFit.cover,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) =>
                              Center(
                                child: CircularProgressIndicator(
                                  value: downloadProgress.progress,
                                  strokeWidth: 3,
                                ),
                              ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error,color: Colors.deepOrange,),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            padding: const EdgeInsets.all(8.6),
                            color: Colors.black.withOpacity(0.5),
                            width: double.infinity,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  list[index]['title'],
                                  style: Theme.of(context).textTheme.bodyText1,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.watch_later_outlined,
                                      size: 16,
                                      color: Colors.deepOrange,
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      list[index]['publishedAt'],
                                      style: TextStyle(
                                        color: Colors.grey[400],
                                        fontSize: 11,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                );
              },
              options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 2.0,
                enlargeCenterPage: true,
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.only(top: 10.0),
              physics: NeverScrollableScrollPhysics(),
              itemCount: list.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 20.0),
                child: InkWell(
                  onTap: (){
                    navigateTo(context,View(list[index]['url']),);
                  },
                  child: Container(
                    width: double.infinity,
                    height: 105,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Theme.of(context).backgroundColor,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            child: CachedNetworkImage(
                              imageUrl: list[index]['urlToImage'],
                              fit: BoxFit.cover,
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) => Center(
                                child: CircularProgressIndicator(
                                  value: downloadProgress.progress,
                                  strokeWidth: 3,
                                ),
                              ),
                              errorWidget: (context, url, error) => Icon(Icons.error,color: Colors.deepOrange,),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  list[index]['title'],
                                  style: Theme.of(context).textTheme.bodyText1,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                                Row(
                                  //textBaseline: TextBaseline.ideographic,
                                  //crossAxisAlignment: CrossAxisAlignment.baseline,
                                  children: [
                                    Icon(
                                      Icons.watch_later_outlined,
                                      size: 16,
                                      color: Colors.deepOrange,
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      list[index]['publishedAt'],
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
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
          ],
        ),
      ),
    );
  }
}
