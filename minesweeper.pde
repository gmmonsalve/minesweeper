import javax.swing.JOptionPane;
import java.util.concurrent.TimeUnit;

ArrayList<PImage> tileset = new ArrayList();
ArrayList<Integer> bombpos = new ArrayList(); // es ejta vaina
boolean end;

Tile face = new Tile(155,40); 
Tile btn = new Tile(120,350); //coordenadas para un gameover 120,170

Tile board[][] = new Tile[8][8];

void setup() {
  
  PImage im;
  im = loadImage("images/15.png");
  im.resize(112,40);
  size(340,450);
  
  loadtiles();
  create();
  mines();
  
  face.setcontent(tileset.get(12));
  btn.x1 = btn.x0 + 112;
  btn.y1 = btn.y0 + 40;
  btn.setcontent(im);
  end = false;
}
 
void draw() {
  for(int i=0;i<=7;i++){
    for(int j=0;j<=7;j++){
      board[i][j].getcontent();
    }  
   }
    face.getcontent();
    
     if(end)
     btn.getcontent();
    
}

void mouseClicked(){
int mx = mouseX;
int my = mouseY;
int count = 0;
Tile t;
PImage edit;
if(!end){
  
  
  for(int i=0;i<=7;i++){
  for(int j=0;j<=7;j++){
    
    t = board[i][j];
    
    if(t.collision(mx,my)){
      
       if(mouseButton == LEFT){
         
            if(t.bomb){
            
             t.setcontent(tileset.get(9));
             gameover();
             
            }else{
             show(i, j);
             count = t.bombcount;
             t.setcontent(tileset.get(count));
            }
          
       }else{
          if(mouseButton == RIGHT && !t.show){
              if(!t.flag){
                t.setcontent(tileset.get(11));
                t.flag = true;
              }else{
                t.setcontent(tileset.get(10));
                t.flag = false;
        } 
       }
      }
      break;
     }
    }
   }
   
}else{
  if(btn.collision(mx,my)){
    bombpos.clear();
    setup();
  }
}

}

  
 
 
     
void loadtiles(){
  PImage img;
 for(int i=0;i<=14;i++){
      img = loadImage("images/"+i+".png");
        img.resize(32, 32);
        tileset.add(img);
 }
}


void create(){
  int x = 45; // inicia en 45 y termina en 301 con aso 32
  int y = 80; // inicia en 80 y termina en 336 con aso 32
  
   for(int i=0;i<=7;i++){
    for(int j=0;j<=7;j++){
      
       Tile t = new Tile(x,y);
       t.setcontent(tileset.get(10));
        board[i][j]= t;
        x+=32;
           if(x>=301)
            x = 45;
    }
    y+=32;
  }
  random_bomb();
}

void random_bomb(){
  int i=0;
  int j=0;
  for(int c=0;c<=9;c++){
    i = (int) random(0,7);
    j  = (int) random (0,7);
    bombpos.add(i);
    bombpos.add(j);
    board[i][j].bomb = true;
  }
}

Tile search(int x, int y){
Tile t;
for(int i=0;i<=7;i++){
  for(int j=0;j<=7;j++){
    t = board[i][j];
    if(t.collision(x,y)){
      return t;
    }
  }
}
return null;
}

 public void show(int i, int j){
        if(i < 0 || j < 0 || i > board.length-1 || j > board[0].length-1 || board[i][j].show || board[i][j].bomb){
          return;
  }else{
         if(!board[i][j].show && board[i][j].bombcount != 0){
                return;
      }
           board[i][j].show  = true;
           board[i][j].setcontent(tileset.get(board[i][j].bombcount));
           show(i+1,j); show(i-1,j);
           show(i,j+1); show(i,j-1);
           show(i+1,j+1); show(i+1,j-1);
           show(i-1,j+1);show(i-1,j-1);
    }  
}
            
void Minescount(int i, int j){
       int count = 0; 

       for(int r = i-1; r < i+2; r++){
           for(int c = j-1; c < j+2; c++){
               if(!(r < 0 || c < 0 || r > board.length-1 || c > board[r].length-1 ) && (board[r][c].bomb && !board[r][c].show )) 
                   count++;        
           }
        }
        board[i][j].bombcount = count;
    }
    
void mines(){
for(int i=0;i<=7;i++){
  for(int j=0;j<=7;j++){
    Minescount(i,j);
  }
 }
 
}
void showbomb(){
  int x,y;
for(int i=0;i<bombpos.size();i+=2){
  x = bombpos.get(i);
  y = bombpos.get(i+1);
  board[x][y].setcontent(tileset.get(9));
}
}
void gameover(){
showbomb();
face.setcontent(tileset.get(13));
end = true;
}

void win(){

}
