class Player {
  float xPos;
  float yPos;
  float radius = 20;
  ArrayList<Bullet> bullets = new ArrayList<Bullet>();

  Player() {
    setCoordinatesToMouse();
  }
  

  void moveAndDraw() {
    fill(255);
    setCoordinatesToMouse();
    float r = radius;
    triangle(xPos-r, yPos+r, xPos, yPos-r, xPos+r, yPos+r);
  }


  void setCoordinatesToMouse() {
    xPos = mouseX;
    yPos = mouseY;
  }
}

