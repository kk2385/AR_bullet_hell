/* Player: A playable triangle that spawns bullets, and 
 *         tasked with avoiding them at the same time.
 */
class Player {
  int id;
  PImage playerImage;
  float xPos; //WILL CHANGE xPos and yPos to be the "Go-to-here" location for each player pikachus
  float yPos;//And make pikachu to always be drawn to the screen
  float playerX = 40 * id;
  float playerY = 40;
  float radius = 20;
  ArrayList<Bullet> bullets = new ArrayList<Bullet>();
  int myFrame = 0;
  int health = 15;

  Player(String imgName, int id) {
    this.id = id;
    playerImage = loadImage(imgName);
    setCoordinatesToMouse();
  }
  
  Player() {
    playerImage = loadImage("data/flyingPikachu.png");
    setCoordinatesToMouse();
  }

  void moveAndDraw(ArrayList<Bullet> bullets) {
    //updateBullets();
    //removeDeadBullets();
    drawPlayer();
//    drawHealthPool();
    //drawBullets();
    checkBulletCollision(bullets);
    myFrame = (myFrame+1) % 10000;
    fill(255);
    textSize(15);
//    text("Health: " + health, xPos, yPos); //HEALTH SHOWN AS TEXT UNDER THE PIKACHU
  }
  
  void drawHealthPool(){
    fill(id * 100, 200/id, 200);
    rect(xPos+10, yPos+30, (float)health/15 * 100, 20);
  }

  void drawPlayer() {
    fill(255);
    float r = radius;
    imageMode(CENTER);
    image(playerImage, xPos, yPos);
//    fill(0, 255, 0, 50);
//    triangle(xPos-r, yPos+r, xPos, yPos-r, xPos+r, yPos+r);
    fill(255, 0, 0);
//    ellipse(xPos, yPos, radius, radius);
  }
  
  boolean checkLoss(){
    if(this.health <= 0)
      return true;
     else
       return false;
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
  
  void setCoordinatesToMouse() {//RECORDS THE COORDINATES OF THE GO-TO POINT FOR PIKACHUS
    xPos = mouseX;
    yPos = mouseY;
  }
  
  void setCoordinatesTo(float x, float y) {
    xPos = x;
    yPos = y;
  } 
}

