/* CircularBullet:
 * A Bullet whose path is circular instead of straight.
 *
 */

class CircularBullet extends Bullet {
  float r = 0;
  float theta = 0;
  float offset = .5;
  
  CircularBullet(float _xPos, float _yPos) {
    super(_xPos, _yPos);
  }

  void moveAndDraw() {
    float x = (r + offset) * cos(theta);
    float y = (r + offset) * sin(theta);
    noStroke();
    fill(255);
    xPos = x+width/2;
    yPos = y+height/2;
    ellipse(xPos, yPos, 20, 20); 

    theta += 0.02;
    r += 0.7;
    
  }
}

