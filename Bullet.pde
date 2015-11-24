class Bullet {

  float xPos;
  float yPos;
  float xSpeed;
  float ySpeed;
  String mode = "default"; //i feel like there will be differnet kinds of bullets
  
  Bullet(float _xPos, float _yPos) {
    xPos = _xPos;
    yPos = _yPos;
    xSpeed = 1;
    ySpeed = 1;
  }
  
  
  void moveAndDraw() {
    fill(255,255,255);
    if (mode.equals("default")) {
      ellipse(xPos, yPos, 10, 10);
    }
    xPos += xSpeed;
    yPos += ySpeed;
    if (xPos >= width || xPos <= 0) xSpeed *= -1;
    if (yPos >= width || yPos <= 0) ySpeed *= -1;
  }
  
}
