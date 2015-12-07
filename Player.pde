/* Player: A playable triangle that spawns bullets, and 
 *         tasked with avoiding them at the same time.
 */
class Player {
  PImage playerImage;
  float xPos;
  float yPos;
  float radius = 20;
  ArrayList<Bullet> bullets = new ArrayList<Bullet>();
  int myFrame = 0;
  int health = 1000;

  Player(String imageDirectory) {
    playerImage = loadImage(imageDirectory);
    setCoordinatesToMouse();
  }

  void moveAndDraw(ArrayList<Bullet> bullets) {
    //updateBullets();
    //removeDeadBullets();
    drawPlayer();
    //drawBullets();
    checkBulletCollision(bullets);
    myFrame = (myFrame+1) % 10000;
    fill(255);
    textSize(15);
    text("Health: " + health, xPos, yPos);
  }

  void drawPlayer() {
    fill(255);
    float r = radius;
    imageMode(CENTER);
    image(playerImage, xPos, yPos);
//    fill(0, 255, 0, 50);
//    triangle(xPos-r, yPos+r, xPos, yPos-r, xPos+r, yPos+r);
    fill(255, 0, 0);
    ellipse(xPos, yPos, radius, radius);
  }

  void updateBullets() {
    if (myFrame % 20 == 0) {
      bullets.add(new Bullet(xPos, yPos));
    }
    if (myFrame % 30 == 0) {
      bullets.add(new CircularBullet(xPos, yPos));
    }
  }
  
  void drawBullets() {
    for (int i = 0; i < bullets.size(); i++) {
      bullets.get(i).moveAndDraw();
    }
  }

  
  void removeDeadBullets() {
    for (int i = 0; i < bullets.size(); i++) {
      Bullet curr = bullets.get(i);
      if (curr.hp <= 0) {
        bullets.remove(curr);
      }
    }
  }


  void checkBulletCollision(ArrayList<Bullet> bullets) {
    
    for (int i = 0; i < bullets.size(); i++) {
      Bullet curr = bullets.get(i);
      if (dist(xPos, yPos, curr.xPos, curr.yPos) <= radius && !curr.isInvincible()) {
        bullets.remove(curr);
        health--;
      }
    }
  }
  
  void setCoordinatesToMouse() {
    xPos = mouseX;
    yPos = mouseY;
  }
  
  void setCoordinatesTo(float x, float y) {
    xPos = x;
    yPos = y;
  } 
}

