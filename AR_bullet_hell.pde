// live video libraries
import processing.video.*;

// AR library - find the 'NyAR4psg' folder that came with today's downloadable
// code package and put it into the 'libraries' folder of your Processing sketchbook
import jp.nyatla.nyar4psg.*;

// video object
Capture video;

// AR marker object - this keeps track of all of the patterns you wish to look for
MultiMarker augmentedRealityMarkers;

int SCREEN_WIDTH = 640;
int SCREEN_HEIGHT = 480;
ArrayList<Bullet> bullets;
Player player;
Player player2;
BulletGenerator generator;

//NOTE ABOUT MARKERS
//Marker detection seems to be almost 100% accurate when the markers themselves are very well-lit
//considering using phones with markers as marker "wands"


void setup() {
  size(640, 480, OPENGL);
  
  // create our video object
  video = new Capture(this, 640, 480);
  video.start();
  
   // create a new AR marker object
  // note that "camera_para.dat" has to be in the data folder of your sketch
  // this is used to correct for distortions in your webcam
  augmentedRealityMarkers = new MultiMarker(this, width, height, "camera_para.dat", NyAR4PsgConfig.CONFIG_PSG);

  // attach the pattern you wish to track to this marker.  this file also needs to be in the data folder
  // 80 is the width of the pattern
  augmentedRealityMarkers.addARMarker("patt.hiro", 80);
  augmentedRealityMarkers.addARMarker(loadImage("a.gif"), 16, 25, 80);
  
  player = new Player("flyingPikachu.png", 1);
  player2 = new Player("Patamon.png", 2);
  generator = new BulletGenerator(width/2, height/2);
  noCursor();
  bullets = new ArrayList<Bullet>();
}

void draw() {
  //System.out.println(bullets.size());
  
  if(player.checkLoss() || player2.checkLoss()){
    endScreen();
  }
  else {

  if (video.available()) {
    background(0);
    drawVideoToScreen();
    bullets = generator.move(); //REMOVED THIS FROM hasMarker requirement to make the game constantly progress even when no markers are present
    player.drawHealthPool();
    player2.drawHealthPool();
    if (hasMarker()) {
      if (augmentedRealityMarkers.isExistMarker(0))  
        doARStuff(player, 0);
      if (augmentedRealityMarkers.isExistMarker(1))  
        doARStuff(player2, 1);
      moveBullets();
//      doARStuff();
      
    } else {
      showNoMarkersDetected();
    }
    //System.out.println(bullets.size());
  }
  }
}

void doARStuff(Player player, int id) {
  try {
      augmentedRealityMarkers.detect(video);

      // if they exists then we will be given information about their location
      // note that we only have one pattern that we are looking for, so it will be pattern 0
      if (augmentedRealityMarkers.isExistMarker(id))
      {
        //get its coordinates
        PVector[] marker1 = augmentedRealityMarkers.getMarkerVertex2D(id);
        float x = (marker1[0].x + marker1[1].x + marker1[2].x + marker1[3].x)/4;
        float y = (marker1[0].y + marker1[1].y + marker1[2].y + marker1[3].y)/4;
        player.setCoordinatesTo(x, y);
        player.moveAndDraw(bullets);
      }
    }
    catch (Exception e) {
      println("Issue with AR detection ... resuming regular operation ..");
      println(e.toString());
    }
}



boolean hasMarker() {
  try {
      augmentedRealityMarkers.detect(video);
      // if they exists then we will be given information about their location
      // note that we only have one pattern that we are looking for, so it will be pattern 0
      return augmentedRealityMarkers.isExistMarker(0) || augmentedRealityMarkers.isExistMarker(1);
    }
    catch (Exception e) {
      println("Issue with AR detection ... resuming regular operation ..");
      println(e.toString());
    }
    return false;
}


void drawVideoToScreen() {
    video.read();
    imageMode(CORNER);
    tint(255, 30);
    image(video, 0, 0);
    tint(255, 255, 255, 255);

}

void endScreen() {
  background(0);
  if(player.checkLoss())
    text("Player "+ player.id + " has lost!", width/2, player.id * 20);
  else
    text("Player "+ player2.id + " has lost!", width/2, player2.id * 20);
}

void moveBullets() {
  for (int i = 0; i < bullets.size(); i++) {
    bullets.get(i).moveAndDraw();
  }
}


void showNoMarkersDetected() {
  textAlign(CENTER);
  fill(255);
  text("No Markers Detected", width/2, height/2);

}

void mouseClicked() {
  bullets.add(new CircularBullet(mouseX, mouseY));
}
