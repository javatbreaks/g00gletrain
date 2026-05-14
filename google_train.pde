float rp; //つり革の揺れの周期0~360
int dph; //揺れの周期
PImage img;
int[] tree = new int[20]; //木の座標を管理 0で待機
int treenum = 0; 
int t;
boolean mouseState = false;//マウス押されているか
int pastX; //1f前のマウスのx座標
boolean time = true; //false=dusk true=day
boolean timesub = true; //false=dusk true=day
int changing = -1; //移り変わっているとき0~1200に

void setup() {
  size(960, 540);
  if (time) {
    img = loadImage("day.png");
  } else {
    img = loadImage("dusk.png");
  }
}

void draw() {
  background(255);
 
  image(img, 0, 0);
  
  //木々
  if (int(random(0, 70)) <= 1 && changing == -1) {
    tree[treenum] = -3;
    treenum ++;
    if (treenum == 20) {treenum=0;}
  }
  noStroke();
  fill(0);
  for (int i = 0; i<20; i++) {
    t = tree[i];
    if (t != 0) {
      if (timesub) {fill(120, 96, 24);}
      rect(t-20, 240, 40, 40);
      if (timesub) {fill(47, 126, 34);}
      triangle(t, 60, t-50, 165, t+50, 165);
      triangle(t, 110, t-55, 205, t+55, 205);
      triangle(t, 155, t-60, 245, t+60, 245);
      tree[i] += 15;
      if (t > 960) {
        tree[i] = 0;
      }
    }
  }
  
  //トンネルに入って時間が変わる
  if (changing != -1) {
    fill(0);
    rect(changing - 1200, 80, 1200, 170);
    changing += 25;
    if (changing == 1200) {
      if (time) {
        img = loadImage("day.png");
      } else {
        img = loadImage("dusk.png");
      }
    }
    //完
    if (changing >= 2400) {
      changing = -1;
      timesub = !timesub;
    }
  }
  
  //時を変えるボタン
  noStroke();
  fill(54);
  rect(13, 513, 20, 20);
  stroke(0);
  strokeWeight(1);
  if (time) {
    fill(245, 101, 39);
  } else {
    fill(91, 200, 255);
  }
  rect(10, 510, 20, 20);
  
  //揺れ
  dph++;
  if (dph == 45) {dph = 0;}
  if (dph >= 25) {
    translate(0, -2);
  }
  
  //画像のフチを白で消す
  fill(255);
  noStroke();
  rect(0, 50, 960, 50);
  rect(0, 250, 960, 50);
  rect(0, 50, 100, 290);
  rect(147, 0, 40, 340);
  rect(234, 0, 86, 340);
  rect(640, 0, 86, 340);
  rect(773, 0, 40, 340);
  rect(860, 0, 100, 340);
  
  //車両
  stroke(0);
  strokeWeight(10);
  noFill();
  strokeCap(SQUARE);
  rect(20, 40, 920, 440);
  ellipse(200, 480, 60, 60);
  ellipse(280, 480, 60, 60);
  ellipse(680, 480, 60, 60);
  ellipse(760, 480, 60, 60);
  
  //扉　とびら
  noFill();
  strokeWeight(2);
  rect(80, 90, 174, 282);
  line(167, 90, 167, 372);
  rect(100, 100, 47, 150);
  rect(187, 100, 47, 150);
  rect(706, 90, 174, 282);
  line(793, 90, 793, 372);
  rect(726, 100, 47, 150);
  rect(813, 100, 47, 150);
  
  //窓　まど
  rect(320, 100, 320, 150);
  line(480, 100, 480, 250);
  
  // G
  strokeWeight(15);
  arc(180, 267, 200, 200, 0, radians(300 + (sin(radians(0)) * 30) ));
  line(180, 267, 287, 267);
  
  // L
  line(676, 170, 690, 373);
  
  // e
  arc(790, 297, 140, 140, radians(40), radians(360 + (sin(radians(0)) * 30) ));
  line(740, 297, 866, 297);
  
  //席　せき
  strokeWeight(2);
  rect(290, 190, 5, 182);
  rect(665, 190, 5, 182);
  rect(295, 290, 370, 82 );
  
  //つり革部分
  if (!mouseState) {
    rp += 3;
  }
  //マウスでD&Dしたときの動きに合わせる処理
  if (mouseState) {
    if ((pastX>mouseX && (rp<90 || rp>=270)) || (pastX<mouseX && (rp<90 || rp>=270))) {
      rp += pastX-mouseX;
    }
    if ((pastX>mouseX && (rp>=90 && rp<270)) || (pastX<mouseX && (rp>=90 && rp<270))) {
      rp -= pastX-mouseX;
    }
    pastX = mouseX;
  }
  if (rp >= 360) {rp -= 360;}
  if (rp < 0) {rp += 360;}
  rect(275, 68, 410, 5);
  rect(270, 43, 5, 30);
  rect(685, 43, 5, 30);
  for (int i = 360; i <= 600; i+=120) {
    //持ち手の白い塗り
    noFill();
    strokeWeight(10);
    stroke(255);
    ellipse(i + (cos(radians( sin(radians(rp))*20 + 90 )) * 85), 70 + (sin(radians( sin(radians(rp))*20 + 90 )) * 85), 35, 35);
    //持ち手の線画
    strokeWeight(2);
    stroke(0);
    ellipse(i + (cos(radians( sin(radians(rp))*20 + 90 )) * 85), 70 + (sin(radians( sin(radians(rp))*20 + 90 )) * 85), 45, 45);
    ellipse(i + (cos(radians( sin(radians(rp))*20 + 90 )) * 85), 70 + (sin(radians( sin(radians(rp))*20 + 90 )) * 85), 25, 25);
    //革
    fill(255);
    quad(i + (cos(radians( sin(radians(rp))*20 + 270)) * 8 ) + (cos(radians( sin(radians(rp))*20 + 0))*8), 70 + (sin(radians( sin(radians(rp))*20 + 270)) * 8 ) + (sin(radians( sin(radians(rp))*20 + 0))*8),
         i + (cos(radians( sin(radians(rp))*20 + 270)) * 8 ) - (cos(radians( sin(radians(rp))*20 + 0))*8), 70 + (sin(radians( sin(radians(rp))*20 + 270)) * 8 ) - (sin(radians( sin(radians(rp))*20 + 0))*8),
         i + (cos(radians( sin(radians(rp))*20 + 90 )) * 80) - (cos(radians( sin(radians(rp))*20 + 0))*8), 70 + (sin(radians( sin(radians(rp))*20 + 90 )) * 80) - (sin(radians( sin(radians(rp))*20 + 0))*8),
         i + (cos(radians( sin(radians(rp))*20 + 90 )) * 80) + (cos(radians( sin(radians(rp))*20 + 0))*8), 70 + (sin(radians( sin(radians(rp))*20 + 90 )) * 80) + (sin(radians( sin(radians(rp))*20 + 0))*8));
    ellipse(i + (cos(radians( sin(radians(rp))*20 + 90)) * 24 ), 70 + (sin(radians( sin(radians(rp))*20 + 90 )) * 24), 5, 5);
  }
  // g の下部分
  noFill();
  strokeWeight(10);
  stroke(255);
  arc(605 + (cos(radians( sin(radians(rp))*20 + 90 )) * 85), 98 + (sin(radians( sin(radians(rp))*20 + 90 )) * 85), 32, 32, radians(314), radians(460));
  strokeWeight(2);
  stroke(0);
  arc(605 + (cos(radians( sin(radians(rp))*20 + 90 )) * 85), 98 + (sin(radians( sin(radians(rp))*20 + 90 )) * 85), 42, 42, radians(310), radians(460));
  arc(605 + (cos(radians( sin(radians(rp))*20 + 90 )) * 85), 98 + (sin(radians( sin(radians(rp))*20 + 90 )) * 85), 22, 22, radians(301), radians(460));
  strokeWeight(2);
  line(605 + (cos(radians( sin(radians(rp))*20 + 90 )) * 85) + (cos(radians(460)))*22, 98 + (sin(radians( sin(radians(rp))*20 + 90 )) * 85) + (sin(radians(460)))*22,
       605 + (cos(radians( sin(radians(rp))*20 + 90 )) * 85) + (cos(radians(460)))*11, 98 + (sin(radians( sin(radians(rp))*20 + 90 )) * 85) + (sin(radians(460)))*11);
}

//スクショ
void keyPressed() {
  save("ss.png");
}

//マウス押した
void mousePressed() {
  if (mouseX > 10 && mouseX < 30 && mouseY > 510 && mouseY < 530 && changing == -1) {
    changing = 0;
    time=!time;
  } else {
    mouseState = true;
    pastX = mouseX;
  }
}

//マウス離した
void mouseReleased() {
  mouseState = false;
}
