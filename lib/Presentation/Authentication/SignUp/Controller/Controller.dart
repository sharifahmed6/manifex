import 'package:get/get.dart';

class signup_controller extends GetxController {
  var password = true.obs;
  var confirm_password = true.obs;

  String? selectedAgeGroup;

  final List<String> ageGroups = [
    "Under 13",
    "13 – 17",
    "18 – 24",
    "25 – 34",
    "35 – 44",
    "45 – 54",
    "55 – 64",
    "65+",
  ];

  String? selectedHobbies;

  final List<String> hobbies = [
    "Reading",
    "Writing",
    "Traveling",
    "Photography",
    "Cooking",
    "Baking",
    "Gardening",
    "Painting",
    "Drawing",
    "Music",
    "Singing",
    "Dancing",
    "Playing Guitar",
    "Playing Piano",
    "Gaming",
    "Video Editing",
    "Blogging",
    "Podcasting",
    "Coding",
    "App Development",
    "Web Development",
    "Designing",
    "UI/UX Design",
    "Sports",
    "Football",
    "Cricket",
    "Basketball",
    "Badminton",
    "Cycling",
    "Running",
    "Gym/Fitness",
    "Yoga",
    "Meditation",
    "Swimming",
    "Hiking",
    "Camping",
    "Fishing",
    "Chess",
    "Board Games",
    "Volunteering",
    "Public Speaking",
    "Learning Languages",
    "Watching Movies",
    "Watching Series",
    "Content Creation",
    "Social Media",
    "DIY Crafts",
    "Home Decoration",
  ];




}