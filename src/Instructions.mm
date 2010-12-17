/*
 *  Instructions.cpp
 *  kunstBaueniPhone
 *
 *  Created by Rob Seward on 4/29/10.
 *  Copyright 2010 VHS DESIGN LLC. All rights reserved.
 *
 */

#include "Instructions.h"
#import "DeviceDetection.h"

void Instructions::setup(){
	ofBackground(255,255,255);	
	
	string path;
	
	int screenType = [DeviceDetection detectScreen];

	
	if(screenType == SCREEN_IPAD_GEN1){
		path = "ipad/";
		instructionsButton = new Button(117, 353, path + "instructions-up.png",  path + "instructions-down.png");
		playButton = new Button(117, 497, path + "play-up-main-menu.png",  path + "play-down-main-menu.png"); 
		smallPlayButton = new Button(520, 880,  path + "play-up.png",  path + "play-down.png");
		backButton = new Button(50, 880,  path + "back-up.png",  path + "back-down.png");
		nextButton = new Button(520, 880,  path + "next-up.png",  path + "next-down.png");
		
	} else{
		path = "iphone/";
		if (screenType == SCREEN_RETINA) {
			instructionsButton = new Button(30, 175, path + "instructions-up-hd.png",  path + "instructions-down-hd.png");
			playButton = new Button(30, 250, path + "play-up-main-menu-hd.png",  path + "play-down-main-menu-hd.png"); 
			smallPlayButton = new Button(200, 410,  path + "play-up-hd.png",  path + "play-down-hd.png");
			backButton = new Button(30, 410,  path + "back-up-hd.png",  path + "back-down-hd.png");
			nextButton = new Button(200, 410,  path + "next-up-hd.png",  path + "next-down-hd.png");
			
		} else  {
			instructionsButton = new Button(30, 175, path + "instructions-up.png",  path + "instructions-down.png");
			playButton = new Button(30, 250, path + "play-up-main-menu.png",  path + "play-down-main-menu.png"); 
			smallPlayButton = new Button(200, 410,  path + "play-up.png",  path + "play-down.png");
			backButton = new Button(30, 410,  path + "back-up.png",  path + "back-down.png");
			nextButton = new Button(200, 410,  path + "next-up.png",  path + "next-down.png");
		} 
		
		
	}
	
	
	if (screenType == SCREEN_RETINA) {
		mmBackground.loadImage( path + "main-menu-bg-hd.png");	
		dragBackground.loadImage( path + "drag-bg-hd.png");
		touchBackground.loadImage( path + "touch-bg-hd.png");
		doubleTapBackground.loadImage( path + "double-tap-bg-hd.png");
	}else{	
		mmBackground.loadImage( path + "main-menu-bg.png");	
		dragBackground.loadImage( path + "drag-bg.png");
		touchBackground.loadImage( path + "touch-bg.png");
		doubleTapBackground.loadImage( path + "double-tap-bg.png");
	}
	
	state = MAIN_MENU;
	
	if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
		[[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
	} 
}



void Instructions::update(){
	if(!touchHappening) checkButtons(-1, -1);
}

void Instructions::draw(){
	if ([DeviceDetection detectScreen] == SCREEN_RETINA){
		ofScale(0.5, 0.5, 0.5);
	}
	
	ofPushMatrix();
	ofBackground(128, 128, 128);
	
	if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
		if ([UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeLeft 
			|| [UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeRight) {
			
			float ratio = 768.0/1024.0;
			float offset = ((float)ofGetScreenHeight() - ((float)ofGetScreenWidth() * ratio) ) / 2;
			if([UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeLeft ){
				ofRotateZ(90);
				ofTranslate(offset, -ofGetScreenWidth(), 0);
			}else {
				ofRotateZ(270);
				ofTranslate(-ofGetScreenHeight()+offset, 0, 0);
			}
			ofScale(ratio, ratio, 0);
		} else if ([UIDevice currentDevice].orientation == UIDeviceOrientationPortraitUpsideDown) {
			ofRotateZ(180);
			ofTranslate(-ofGetScreenWidth(), -ofGetScreenHeight(), 0);
		}
	}
	ofEnableAlphaBlending();
	switch (state) {
		case MAIN_MENU:
			mmBackground.draw(0,0);
			instructionsButton->draw();
			playButton->draw();
			break;
		case DRAG:
			dragBackground.draw(0, 0);
			backButton->draw();
			nextButton->draw();
			break;
		case TOUCH:
			touchBackground.draw(0,0);
			backButton->draw();
			nextButton->draw();
			break;
		case DOUBLE_TAP:
			doubleTapBackground.draw(0,0);
			backButton->draw();
			smallPlayButton->draw();
			break;


		default:
			break;
	}
	ofDisableAlphaBlending();
	
	//ofCircle(rotX, rotY, 20);

	ofPopMatrix();
	
}


void Instructions::touchDown(int x, int y, int id){
	checkButtons(x, y);
	
	touchHappening = true;
}


void Instructions::touchUp(int x, int y, int id){
	getLandscapeCoordinates(&x, &y, [UIDevice currentDevice].orientation);

	switch (state) {
		case MAIN_MENU:
			if (instructionsButton->isTouched(x, y)) {
				state = TOUCH;
			} else if (playButton->isTouched(x, y)) {
				state = PLAY;
			}
			break;
		case DRAG:
			if (backButton->isTouched(x, y)) {
				state = TOUCH;
			} else if (nextButton->isTouched(x, y)) {
				state = DOUBLE_TAP;
			}
			break;
		case TOUCH:
			if (backButton->isTouched(x, y)) {
				state = MAIN_MENU;
			} else if (nextButton->isTouched(x, y)) {
				state = DRAG;
			}
			break;
		case DOUBLE_TAP:
			if (backButton->isTouched(x, y)) {
				state = DRAG;
			} else if (smallPlayButton->isTouched(x, y)) {
				state = PLAY;
			}
			break;

		default:
			break;
	}
	touchHappening = false;
}


void Instructions::touchMoved(int x, int y, int id){	
	mouseX = x;
	mouseY = y;
	checkButtons(x, y);
}


void Instructions::checkButtons(int x, int y){
	getLandscapeCoordinates(&x, &y, [UIDevice currentDevice].orientation);
	
	switch (state) {
		case MAIN_MENU:
			instructionsButton->isTouched(x, y);
			playButton->isTouched(x, y);
			break;
		case DOUBLE_TAP:
			backButton->isTouched(x, y);
			smallPlayButton->isTouched(x, y);
			break;

		default:
			backButton->isTouched(x, y);
			nextButton->isTouched(x, y);
			break;
	}
}


void Instructions::getLandscapeCoordinates(int* xPtr, int* yPtr, UIDeviceOrientation orientation){
    if (orientation == UIDeviceOrientationLandscapeLeft || orientation == UIDeviceOrientationLandscapeRight) {
		float ratio = 1024.0/768.0;
		int x= *xPtr; 
		int y= *yPtr;
		float offset;
		offset = ((float)ofGetScreenHeight() - ((float)ofGetScreenWidth() * (768/1024) )) / 4;

		if (orientation == UIDeviceOrientationLandscapeLeft) {
			*xPtr = y * ratio - offset;
			*yPtr = x * ratio * -1 + 1024;
		}
		
		if (orientation == UIDeviceOrientationLandscapeRight) {			
			*xPtr = -y * ratio + 1024;
			*yPtr = x * ratio;
		}
	}
	else if (orientation == UIDeviceOrientationPortraitUpsideDown) {
		*xPtr = ofGetScreenWidth() - *xPtr;
		*yPtr = ofGetScreenHeight() - *yPtr;
	}
	
	rotX = *xPtr;
	rotY = *yPtr;
}


bool Instructions::isPlayState(){
	if (state == PLAY) {
		return true;
	} else {
		return false;
	}
}