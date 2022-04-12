import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_video_list/APIRepo/api_repo.dart';
import 'package:multi_video_list/BLoC/state/video_state.dart';
import 'package:multi_video_list/Common/global.dart';
import 'package:multi_video_list/Model/getVideoModel.dart';

class VideoCubit extends Cubit<VideoState> {
  final BaseRepository _baseRepository;

  VideoCubit(this._baseRepository) : super(const VideoInitial());

  getVideos() async {
    isInternetConnectivityAvailable().then((internet) async {
      if (internet) {
        try {
          emit(const Processing());
          GetVideosModel response = await _baseRepository.getVideoList();
          emit(GetVideoCompleted(response));
        } catch (e) {
          if (kDebugMode) {
            print('LoginError: $e');
          }
          emit(VideoError(blocVideoError));
        }
      } else {
        emit(VideoError(internetConnectionError));
      }
    });
  }
}
