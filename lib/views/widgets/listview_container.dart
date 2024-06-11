import 'package:flutter/material.dart';

import '../../models/course_model.dart';
import '../../utils/routes_utild.dart';

class CustomListViewBuilderContainer extends StatelessWidget {
  final bool isViewStylePressed;
  final Course course;
  final bool isDelete;
  final Function()? onDeletePressed;

  CustomListViewBuilderContainer({
    super.key,
    required this.course,
    required this.isViewStylePressed,
    required this.isDelete,
    this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RouteNames.courseInfo, arguments: course);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
        child: Card(
          // margin: isViewStylePressed ? null : const EdgeInsets.only(bottom: 15),
          child: isViewStylePressed
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Course name: ${course.courseTitle}',
                    ),
                    Text(
                        'Description:  ${course.courseDescription.split(' ')[0]}'),
                    Text('Price: ${course.coursePrice}'),
                  ],
                )
              : Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 20),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Course name:  ${course.courseTitle}',
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Description:   ${course.courseDescription.split(' ')[0]}',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    'Price: ${course.coursePrice}',
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ])),
                    if (isDelete)
                      TextButton(
                          onPressed: onDeletePressed,
                          child: const Text('Delete course')),
                  ],
                ),
        ),
      ),
    );
  }
}
