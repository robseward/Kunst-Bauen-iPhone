#pragma once




#include "ofMain.h"
#include "ofxiPhone.h"
#include "ofxiPhoneExtras.h"
#include "Square.h"
#include "Paths.h"
#include "Game.h"
#include "Instructions.h"
#include "ofxMSASpline.h"



class testApp : public ofxiPhoneApp {
private:
	Instructions instructions;
	Game game;
	bool playGame;
public:
	void setup();
	void update();
	void update(ofxMSASpline2D spline);
	void draw();
	void exit();

	void touchDown(int x, int y, int id);
	void touchMoved(int x, int y, int id);
	void touchUp(int x, int y, int id);
	void touchDoubleTap(int x, int y, int id);
	
	void lostFocus();
	void gotFocus();
	void gotMemoryWarning();
	void deviceOrientationChanged(int newOrientation);
	
	
};
