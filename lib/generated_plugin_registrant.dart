/*
 *  This file is part of Rhythm (https://github.com/EncryptoCyphers/Rhythm).
 * 
 * Rhythm is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * Rhythm is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with Rhythm.  If not, see <http://www.gnu.org/licenses/>.
 * 
 * Copyright (c) 2022-2023, EncryptoCyphers
 */

//
// Generated file. Do not edit.
//
// ignore_for_file: directives_ordering
// ignore_for_file: lines_longer_than_80_chars
// ignore_for_file: depend_on_referenced_packages

import 'package:audio_session/audio_session_web.dart';
import 'package:cloud_firestore_web/cloud_firestore_web.dart';
import 'package:firebase_auth_web/firebase_auth_web.dart';
import 'package:firebase_core_web/firebase_core_web.dart';
import 'package:fluttertoast/fluttertoast_web.dart';
import 'package:just_audio_web/just_audio_web.dart';
// import 'package:on_audio_query_web/on_audio_query_web.dart';
import 'package:url_launcher_web/url_launcher_web.dart';

import 'package:flutter_web_plugins/flutter_web_plugins.dart';

// ignore: public_member_api_docs
void registerPlugins(Registrar registrar) {
  AudioSessionWeb.registerWith(registrar);
  FirebaseFirestoreWeb.registerWith(registrar);
  FirebaseAuthWeb.registerWith(registrar);
  FirebaseCoreWeb.registerWith(registrar);
  FluttertoastWebPlugin.registerWith(registrar);
  JustAudioPlugin.registerWith(registrar);
  // OnAudioQueryPlugin.registerWith(registrar);
  UrlLauncherPlugin.registerWith(registrar);
  registrar.registerMessageHandler();
}
