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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Student name : ${widget.model.studentName}',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(
                height: 3,
              ),
              Text(
                'Student Address : ${widget.model.studentAddress}',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                'Subject : ${widget.model.courseName}',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                'Date & Time : ${widget.model.date}${widget.model.time}',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                'Status : ${widget.model.status}',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
              ),
              Row(
                children: [],
              )
            ],
          ),
          InkWell(
            onTap: () {},
            child: Icon(
              Icons.phone,
            ),
          )
        ],
      ),
    );
  }
}
