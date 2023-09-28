import 'package:flutter/material.dart';

import '../../model/tutorRequestModel.dart';

class RequestListWidget extends StatefulWidget {
  final TutorRequestModel model;

  const RequestListWidget({Key? key, required this.model}) : super(key: key);

  @override
  State<RequestListWidget> createState() => _RequestListWidgetState();
}

class _RequestListWidgetState extends State<RequestListWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                  text: TextSpan(
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                      children: <TextSpan>[
                    TextSpan(
                      text: 'Student name : ',
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: widget.model.studentName,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                  ])),
            ],
          ),
          SizedBox(
            height: 3,
          ),
          RichText(
              text: TextSpan(
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                  children: <TextSpan>[
                TextSpan(
                  text: 'Student Address : ',
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: widget.model.studentAddress,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ])),
          const SizedBox(
            height: 3,
          ),
          RichText(
              text: TextSpan(
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                  children: <TextSpan>[
                TextSpan(
                  text: 'Subject : ',
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: widget.model.courseName,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ])),
          const SizedBox(
            height: 3,
          ),
          RichText(
              text: TextSpan(
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                  children: <TextSpan>[
                TextSpan(
                  text: 'Date & Time : ',
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: '${widget.model.date} ${widget.model.time}',
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ])),
          const SizedBox(
            height: 3,
          ),
          RichText(
              text: TextSpan(
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                  children: <TextSpan>[
                TextSpan(
                  text: 'Day & Shift : ',
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: '${widget.model.day} ${widget.model.shift}',
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ])),
          const SizedBox(
            height: 3,
          ),
          RichText(
              text: TextSpan(
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                  children: <TextSpan>[
                TextSpan(
                  text: 'Status :  ',
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: 'Completed',
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ])),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
