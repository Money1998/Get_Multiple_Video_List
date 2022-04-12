
import 'package:equatable/equatable.dart';
import 'package:multi_video_list/Model/getVideoModel.dart';

abstract class VideoState extends Equatable {
  const VideoState();
}

class VideoInitial extends VideoState {
  const VideoInitial();

  @override
  List<Object> get props => [];
}

class Processing extends VideoState {
  const Processing();

  @override
  List<Object> get props => [];
}
class VideoError extends VideoState {
  final String message;
  const VideoError(this.message);

  @override
  List<Object> get props => [message];
}

class GetVideoCompleted extends VideoState {
  final GetVideosModel videosModel;
  const GetVideoCompleted(this.videosModel);

  @override
  List<Object> get props => [videosModel];
}