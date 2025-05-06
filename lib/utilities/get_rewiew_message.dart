import 'dart:math';

final categoryMessages = <String, List<String>>{
  'SCIENCE_AMP_NATURE': [
    "A small spark of knowledge! Keep the curiosity burning.",
    "Don't be discouraged — this is just the beginning! Use this as fuel to learn and grow. You’ve got potential, keep going!",
    "You're on the path, but there's room to improve. Let's focus and come back stronger. Progress starts with effort!",
    "Good try! You're starting to build your foundation. A little more practice and you'll see big changes!",
    "You're getting warmer! Keep learning, and don’t be afraid to challenge yourself. Growth is happening!",
    "Halfway there! Solid effort. Now let’s aim for higher. Review and retry — success is within reach!",
    "Not bad at all! You're improving steadily. Keep sharpening your knowledge — you're more capable than you think.",
    "Great job! You're above average. Just a few more steps to excellence. Keep the momentum going!",
    "Excellent! You’ve got strong command over the topic. Aim for 100 next — you’re almost there!",
    "Outstanding work! You're nearly perfect. Just polish a few areas and you’ll be unstoppable.",
    "Perfect score! Absolutely amazing. You've mastered this quiz. Keep challenging yourself to grow even more!"
  ],
  'ENTERTAINMENT_BOOKS': [
    "The first page of many! Let’s keep reading.",
    "Early chapters can be rough — keep flipping those pages!",
    "You’re starting your story. Turn the page and dive deeper!",
    "Getting into the plot! Keep reading and growing.",
    "The storyline is taking shape. Well done!",
    "Halfway through the book — keep it up!",
    "Page-turning progress! Stay focused!",
    "Strong character arc! You’re writing success.",
    "Almost bestseller level!",
    "Author-level excellence. Keep shining!",
    "Master storyteller! You’ve aced the book trivia!"
  ],
  'ENTERTAINMENT_FILM': [
    "Opening scene. Let’s roll the reel!",
    "You’ve got some screen time — keep watching!",
    "Early in the movie. Stay for the climax!",
    "Plot’s getting better! Keep going!",
    "You’re halfway to the credits!",
    "Good watch! You're catching the plot!",
    "You’ve got the director’s vision!",
    "Blockbuster performance!",
    "Award-winning knowledge!",
    "Oscar-worthy answers!",
    "Cinema legend! Lights, camera, mastery!"
  ],
  'ENTERTAINMENT_MUSIC': [
    "A single note — the tune begins!",
    "First verse done — let’s find the chorus!",
    "The rhythm is building — keep grooving!",
    "You’ve got the melody right!",
    "Halfway through the song of success!",
    "You’re in tune! Nice performance.",
    "Harmony is building — keep up the tempo!",
    "You’ve dropped a hit score!",
    "A few beats from perfection!",
    "Nearly symphonic brilliance!",
    "Perfect harmony! Music maestro!"
  ],
  'ENTERTAINMENT_VIDEO_GAMES': [
    "You’ve just picked up the controller!",
    "First level passed. Practice more!",
    "You’ve unlocked beginner XP!",
    "Leveling up! Keep grinding!",
    "Half the game explored — GG!",
    "Impressive gameplay!",
    "You’re gaining XP rapidly!",
    "High-score vibes!",
    "Final boss almost beaten!",
    "One move from victory!",
    "Game cleared! You’re legendary!"
  ],
  'ENTERTAINMENT_BOARD_GAMES': [
    "First move on the board!",
    "Rolling the dice — try again!",
    "You're learning the strategy!",
    "Piece by piece, you're improving!",
    "Halfway on the game board!",
    "Tactical moves incoming!",
    "You're mastering the game!",
    "Smart moves — almost there!",
    "You’re playing like a pro!",
    "So close to victory!",
    "Checkmate! You rule the board!"
  ],
  // ignore: equal_keys_in_map
  'SCIENCE_AMP_NATURE': [
    "A spark of discovery!",
    "You’ve started the experiment!",
    "Basic observations noted!",
    "Forming solid hypotheses!",
    "Experiment halfway complete!",
    "Results are promising!",
    "You're observing well!",
    "Natural genius emerging!",
    "Scientific accuracy unlocked!",
    "One discovery away!",
    "Einstein-level genius!"
  ],
  'SCIENCE_COMPUTERS': [
    "Booting up your knowledge!",
    "Basic inputs received!",
    "You’re debugging your skills!",
    "You’ve logged in properly!",
    "Processing... halfway done!",
    "Code is compiling!",
    "Binary brilliance!",
    "You’re executing knowledge!",
    "Close to perfect syntax!",
    "Almost error-free!",
    "Flawless logic! Coding wizard!"
  ],
  'SCIENCE_MATHEMATICS': [
    "Starting from zero!",
    "Basic numbers known — keep solving!",
    "Adding up your skills!",
    "Equations are taking shape!",
    "Half solved! Stay sharp.",
    "Your logic is multiplying!",
    "You're finding the right formulas!",
    "Sharp mind — solving like a pro!",
    "Almost a mathematician!",
    "Few steps from perfection!",
    "Math master! Precision perfect!"
  ],
  'MYTHOLOGY': [
    "A whisper from the past!",
    "You’ve heard the ancient tales!",
    "Myths unfolding!",
    "You know the legends!",
    "Halfway through Olympus!",
    "God-tier progress!",
    "Divine wisdom growing!",
    "You’re becoming a myth expert!",
    "Hero-level knowledge!",
    "Almost immortal in trivia!",
    "You’re a legend yourself!"
  ],
  'SPORTS': [
    "Warm-up done!",
    "In the game — keep training!",
    "You’ve scored a few points!",
    "The match is on!",
    "Half-time score — doing well!",
    "Great play so far!",
    "Champion potential!",
    "Star player mode!",
    "On the edge of victory!",
    "Golden medal moment!",
    "MVP of sports trivia!"
  ],
  'GEOGRAPHY': [
    "You’ve dropped a pin!",
    "Learning landmarks!",
    "Navigating new terrain!",
    "Maps are getting clearer!",
    "You’re halfway across the world!",
    "Good sense of direction!",
    "Exploring the world like a pro!",
    "Geography genius!",
    "Almost a globe master!",
    "One map from mastery!",
    "World explorer level: expert!"
  ],
  'HISTORY': [
    "The timeline begins!",
    "You've learned the ancient dates!",
    "Events are unfolding!",
    "You’re building the timeline!",
    "Half the past uncovered!",
    "Great historical insights!",
    "You’re connecting centuries!",
    "Impressive historian streak!",
    "Almost there in the archives!",
    "So close to full chronology!",
    "Master of time and events!"
  ],
  'POLITICS': [
    "One vote in!",
    "Know a few leaders!",
    "Learning the game!",
    "Politics making sense!",
    "Halfway to strategist!",
    "Shaping opinions now!",
    "Debate-ready knowledge!",
    "Global affairs sharp!",
    "Policy guru status near!",
    "A few laws from mastery!",
    "Trivia President!"
  ],
  'ART': [
    "Blank canvas!",
    "Sketched the outline!",
    "Blending colors!",
    "Artwork forming!",
    "Half a masterpiece!",
    "Beautiful strokes!",
    "Brushwork brilliance!",
    "Gallery-worthy!",
    "One shade from perfect!",
    "Art legend alert!",
    "Masterpiece complete!"
  ],
  'ANIMALS': [
    "A paw print!",
    "First tracks spotted!",
    "Wildlife whispers!",
    "Animal instincts growing!",
    "Half jungle explored!",
    "Roaring success!",
    "Predator sharpness!",
    "Top of the food chain!",
    "Near-zoologist score!",
    "Final leap away!",
    "King of the wild!"
  ],
  'VEHICLES': [
    "Engine started!",
    "First gear on!",
    "Cruising slowly!",
    "Speed building!",
    "Half trip complete!",
    "Smooth driving!",
    "Fast lane!",
    "Racing ahead!",
    "Almost full speed!",
    "One lap left!",
    "Top gear trivia!"
  ],
  'ENTERTAINMENT_COMICS': [
    "Panel one!",
    "Meet the heroes!",
    "Plot twist ahead!",
    "Storyline strong!",
    "Half the comic read!",
    "Hero arc rising!",
    "Comic champ vibes!",
    "Superpower trivia!",
    "Almost full arc!",
    "Final page near!",
    "Comic hero complete!"
  ],
  'SCIENCE_GADGETS': [
    "Low battery!",
    "Booting up!",
    "Basic setup done!",
    "Syncing knowledge!",
    "Half-charged brain!",
    "Techy thoughts!",
    "High speed knowledge!",
    "Smart performance!",
    "Almost innovator level!",
    "One tap away!",
    "Gadget genius!"
  ],
  'ENTERTAINMENT_JAPANESE_ANIME_AMP_MANGA': [
    "Episode 1 — start!",
    "First arc done!",
    "Power building!",
    "Training arc mode!",
    "Half the saga!",
    "Main battle starts!",
    "Super Saiyan IQ!",
    "Protagonist vibes!",
    "Final battle near!",
    "Climax incoming!",
    "Hokage of trivia!"
  ],
  'failed': [
    "Every pro was once a beginner. Keep going!",
    "It's not failure — it's your first step!",
    "You showed up. That’s already a win!",
    "Today’s loss is tomorrow’s lesson.",
    "Keep learning — greatness starts here.",
    "Failure isn’t the end. It’s a checkpoint.",
    "One try down. Many wins to come!",
    "Progress starts with trying.",
    "Low score? High chance to grow!"
        "You’ve got potential — don’t stop!"
  ]
};
String scoreMessage(int score, List<String> messages, int index) {
  // ignore: unnecessary_null_comparison
  if (index < 0) {
    if (score == 0) return messages[0];
    if (score <= 1) return messages[1];
    if (score <= 2) return messages[2];
    if (score <= 3) return messages[3];
    if (score <= 4) return messages[4];
    if (score <= 5) return messages[5];
    if (score <= 6) return messages[6];
    if (score <= 7) return messages[7];
    if (score <= 8) return messages[8];
    if (score <= 9) return messages[9];
    return messages[10];
  } else {
    return messages[index];
  }
  // for score <= 100
}

String getReviewMessage(int finalMark, String category) {
  if (categoryMessages.containsKey(category)) {
    return scoreMessage(finalMark, categoryMessages[category]!, -1);
  } else {
    int random = Random().nextInt(10) + 1;
    return scoreMessage(finalMark, categoryMessages[category]!, random);
  }
}
