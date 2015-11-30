/* CircularBullet:
 * A Bullet whose path is circular instead of straight.
 * Does not bounce off walls.
 */

class CircularBullet extends Bullet {
  float centerX; //origin from which the bullet spins w/respect to.
  float centerY;
  float r = 0;
  float theta = 0;
  float offset = .5;
  
  CircularBullet(float _xPos, float _yPos) {
    super(_xPos, _yPos);
    centerX = _xPos;
    centerY = _yPos;
    hp = 500;
  }

  void moveAndDraw() {
    float x = (r + offset) * cos(theta);
    float y = (r + offset) * sin(theta);
    noStroke();
    float alpha = map(hp, 0, 500, 0, 255); //transparency
    fill(255, alpha);
    xPos = x+centerX;
    yPos = y+centerY;
    ellipse(xPos, yPos, 20, 20); 
    hp--;
    invincibility--;

    theta += 0.02;
    r += 0.7;
  }
}

