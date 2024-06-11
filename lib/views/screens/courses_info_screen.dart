import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/course_model.dart';

class CourseInfoScreen extends StatefulWidget {
  final Course course;

  const CourseInfoScreen({super.key, required this.course});

  @override
  State<CourseInfoScreen> createState() => _CourseInfoScreenState();
}

class _CourseInfoScreenState extends State<CourseInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.course.courseTitle),
        centerTitle: false,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Image.network(
            widget.course.courseImageUrl,
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('Course description: ${widget.course.courseDescription}'),
                Text('Course price: \$${widget.course.coursePrice}'),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Lessons',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ],
            ),
          ),
          ListView.builder(
            itemCount: widget.course.courseLessons.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) => GestureDetector(
              onTap: () => setState(() {
                ///////////////////////////////
                // Navigator.pushNamed(context, RouteNames.youTubeVideo, arguments: {
                //   'course': widget.course,
                //   'index': index,
                // });
                // Navigator.push(
                //   context,
                //   CupertinoPageRoute(
                //     builder: (BuildContext context) => YouTubeVideoScreen(
                //       course: widget.course,
                //       index: index,
                //     ),
                //   ),
                // );
              }),
              child: Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.course.courseLessons[index].lessonTitle),
                        Text(widget
                            .course.courseLessons[index].lessonDescription),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
