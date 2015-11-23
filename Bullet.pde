class Bullet {

  float xPos;
  float yPos;
  float xSpeed;
  float ySpeed;
  String mode = "default"; //i feel like there will be differnet kinds of bullets
  
  Bullet(float _xPos, float _yPos) {
    xPos = _xPos;
    ypos = _yPos;
    xSpeed = 1;
    ySpeed = 1;
  }
  
  
  void drawAndDisplay() {
    if (mode.equals("default")) {
      ellipse(xPos, yPos, 0, 0);
    }
    xPos += xSpeed;
    yPos += ySpeed;
    if (xPos >= width || xPos <= 0) xSpeed *= -1;
    if (xPos >= width || xPos <= 0) xSpeed *= -1;
  }
  
  
}
