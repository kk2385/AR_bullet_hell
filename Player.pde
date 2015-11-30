/* Player: A playable triangle that spawns bullets, and 
 *         tasked with avoiding them at the same time.
 */
class Player {
  float xPos;
  float yPos;
  float radius = 20;
  ArrayList<Bullet> bullets = new ArrayList<Bullet>();
  int myFrame = 0;

  Player() {
    setCoordinatesToMouse();
  }

  void moveAndDraw() {
    updateBullets();
    removeDeadBullets();
    drawPlayer();
    drawBullets();
    myFrame = (myFrame+1) % 10000;
  }

  void drawPlayer() {
    fill(255);
    setCoordinatesToMouse();
    float r = radius;
    triangle(xPos-r, yPos+r, xPos, yPos-r, xPos+r, yPos+r);
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

  void setCoordinatesToMouse() {
    xPos = mouseX;
    yPos = mouseY;
  }
}

