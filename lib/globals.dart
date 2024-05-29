import 'package:flutter/material.dart';

import 'model/entities/advice_entity.dart';
import 'model/entities/subject_entity.dart';
import 'model/entities/user_entity.dart';

UserEntity userData = UserEntity();

final GlobalKey<AnimatedListState> advisorSubjectsKey = GlobalKey<AnimatedListState>();
List<SubjectEntity> advisorSubjectsList = [];

final GlobalKey<AnimatedListState> studentPendingAdvicesKey = GlobalKey<AnimatedListState>();
List<AdviceEntity> studentPendingAdvicesList = [];

//final GlobalKey<AnimatedListState> studentCompletedAdvicesKey = GlobalKey<AnimatedListState>();
List<AdviceEntity> studentCompletedAdvicesList = [];

final GlobalKey<AnimatedListState> advisorPendingAdvicesKey = GlobalKey<AnimatedListState>();
List<AdviceEntity> advisorPendingAdvicesList = [];
