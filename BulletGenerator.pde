class BulletGenerator {
  float xPos;
  float yPos;
  float radius = 20;
  ArrayList<Bullet> bullets = new ArrayList<Bullet>();
  int myFrame = 0;
    
  public BulletGenerator(float x, float y) {
    xPos = x;
    yPos = y;
  }  
  
  void spawnBullets() {
      if (myFrame % 20 == 0) {
      bullets.add(new Bullet(xPos, yPos));
    }
    if (myFrame % 30 == 0) {
      bullets.add(new CircularBullet(xPos, yPos));
    }    
  }
  
  void drawGenerator() {
    fill(255);
    //imageMode(CENTER);
    //image(playerImage, xPos, yPos);
    ellipseMode(CENTER);
    //fill(255, 0, 0);
    ellipse(xPos, yPos, radius, radius);
    
  }
    
  ArrayList<Bullet> move() {
    updateBullets();
    removeDeadBullets();
    drawGenerator();
    drawBullets();
    myFrame = (myFrame+1) % 10000;
    return bullets;  
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
}

