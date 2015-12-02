class Bullet {
  float SPEED = 6;
  float xPos;
  float yPos;
  float xSpeed;
  float ySpeed;
  float hp; //a bullet with hp of 0 will disappear.
  float invincibility; //an invincible wallet can't do damage. When a bullet spawns it is invincible for a short time.
  String mode = "default"; //i feel like there will be differnet kinds of bullets
  
  Bullet(float _xPos, float _yPos) {
    xPos = _xPos;
    yPos = _yPos;
    xSpeed = SPEED * random(0,100) > 50? 1 : -1;
    ySpeed = SPEED * random(0,100) > 50? 1 : -1;
    invincibility = 30;
    hp = 600;
  }
  
  void moveAndDraw() {
    float alpha = map(hp, 0, 500, 0, 255); //the less health, the less visible the bullet has.
    fill(255,255,255, alpha);
    if (mode.equals("default")) {
      ellipse(xPos, yPos, 10, 10);
    }
    xPos += xSpeed;
    yPos += ySpeed;
    if (xPos >= width || xPos <= 0) xSpeed *= -1;
    if (yPos >= width || yPos <= 0) ySpeed *= -1;
    hp--;
    invincibility--;
  }
  
  boolean isInvincible() {
    return invincibility >= 0;
  }
}
