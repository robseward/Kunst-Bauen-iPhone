/*
 *  Instructions.h
 *  kunstBaueniPhone
 *
 *  Created by Rob Seward on 4/29/10.
 *  Copyright 2010 VHS DESIGN LLC. All rights reserved.
 *
 */

#pragma once

#include "ofMain.h"
#include "Button.h"



class Instructions {
	
	enum instructionStates {
		MAIN_MENU,
		DRAG,
		TOUCH,
		DOUBLE_TAP,
		PLAY
	};
	
private:
	//main menu
	ofImage mmBackground;
	Button* instructionsButton;
	Button* playButton;
	
	//everything else
	Button* nextButton;
	Button* backButton;
	Button* smallPlayButton;
	
	ofImage dragBackground;
	ofImage touchBackground;
	ofImage doubleTapBackground;
	
	int state;
	void checkButtons(int x, int y);
	
	bool touchHappening;
	void getLandscapeCoordinates(int *xPtr, int *yPtr, UIDeviceOrientation orientation);

	int rotX;	//temp
	int rotY;
	
	int mouseX;
	int mouseY;
		
public:
	
	void setup();
	void draw();
	void update();
	void exit();
	
	void touchDown(int x, int y, int id);
	void touchMoved(int x, int y, int id);
	void touchUp(int x, int y, int id);
	void touchDoubleTap(int x, int y, int id);
	
	bool isPlayState();

};