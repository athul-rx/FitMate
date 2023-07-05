// ignore_for_file: unused_field

import 'dart:developer';

import 'package:fitmate/services/camera_view.dart';
import 'package:fitmate/utilis/pose_painter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';


class PoseDetectorView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PoseDetectorViewState();
}

class _PoseDetectorViewState extends State<PoseDetectorView> {
  final PoseDetector _poseDetector =
      PoseDetector(options: PoseDetectorOptions());
  bool _canProcess = true;
  bool _isBusy = false;
  CustomPaint? _customPaint;
  String? _text;
  String? _previousText;
  int _pushUpCount = 0;
  bool _isCorrectPose = false;

  @override
  void dispose() async {
    _canProcess = false;
    _poseDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final cameraHeight = screenHeight * 3 / 4;
    final counterHeight = screenHeight - cameraHeight;

    return CameraView(
      customPaint: _customPaint,
      text: _text,
      counter: _pushUpCount,
      onImage: (inputImage) {
        processImage(inputImage);
      },
      title: _text ?? '',
    );
  }

  Future<void> processImage(InputImage inputImage) async {
    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;
    int count = 0;
    setState(() {
      _text = '';
    });
    final poses = await _poseDetector.processImage(inputImage);
    if (inputImage.inputImageData?.size != null &&
        inputImage.inputImageData?.imageRotation != null) {
      final painter = PosePainter(
        poses,
        inputImage.inputImageData!.size,
        inputImage.inputImageData!.imageRotation,
      );
      _customPaint = CustomPaint(painter: painter);

      for (final pose in poses) {
        final leftShoulder = pose.landmarks[PoseLandmarkType.leftShoulder];
        final rightShoulder = pose.landmarks[PoseLandmarkType.rightShoulder];
        final leftElbow = pose.landmarks[PoseLandmarkType.leftElbow];
        final rightElbow = pose.landmarks[PoseLandmarkType.rightElbow];
        final leftWrist = pose.landmarks[PoseLandmarkType.leftWrist];
        final rightWrist = pose.landmarks[PoseLandmarkType.rightWrist];

        if (leftShoulder != null &&
            rightShoulder != null &&
            leftElbow != null &&
            rightElbow != null &&
            leftWrist != null &&
            rightWrist != null) {
          final shoulderSameLevel =
              (leftShoulder.y - rightShoulder.y).abs() < 100;
          final elbowAboveShoulder =
              leftElbow.y > leftShoulder.y && rightElbow.y > rightShoulder.y;
          final wristBelowElbow =
              leftWrist.y > leftElbow.y && rightWrist.y > rightElbow.y;

          if (shoulderSameLevel && elbowAboveShoulder && wristBelowElbow) {
            if (_previousText != 'Correct pose') {
              setState(() {
                _text = 'Correct pose';
                _isCorrectPose = true;
                _previousText = _text;
                _pushUpCount++;
              });
            }
          } else {
            setState(() {
              _text = 'Incorrect pose';
              _isCorrectPose = false;
              _previousText = _text;
            });
          }
        } else {
          setState(() {
            _text = 'Push incorrect';
          });
        }
      }
    } else {
      log('Image data is null');
      _text = 'incorrect';
    }
    _isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }
}
