#include "testApp.h"

//--------------------------------------------------------------
void testApp::setup(){	
	// register touch events
	ofxRegisterMultitouch(this);
	
	// initialize the accelerometer
	ofxAccelerometer.setup();
	
	//iPhoneAlerts will be sent to this.
	ofxiPhoneAlerts.addListener(this);
	
	playGame = false;
	
	instructions.setup();
	game.setup();
	
}


//--------------------------------------------------------------
void testApp::update() {
	if(playGame){
		game.update();
	} else {
		instructions.update();
		playGame = instructions.isPlayState();
	}
}

//--------------------------------------------------------------
void testApp::draw() {
	if(playGame){
		game.draw();
	} else {
		instructions.draw();
	}

}


//--------------------------------------------------------------
void testApp::exit() {
	printf("exit()\n");
}

//--------------------------------------------------------------
void testApp::touchDown(int x, int y, int id){
	if(playGame){
		game.touchDown(x, y, id);
	} else {
		instructions.touchDown(x, y, id);
	}
}

//--------------------------------------------------------------
void testApp::touchMoved(int x, int y, int id){
	if(playGame){
		game.touchMoved(x, y, id);
	} else {
		instructions.touchMoved(x, y, id);
	}
}

//--------------------------------------------------------------
void testApp::touchUp(int x, int y, int id){
	if(playGame){
		game.touchUp(x, y, id);
	} else {
		instructions.touchUp(x, y, id);
	}
}

//--------------------------------------------------------------
void testApp::touchDoubleTap(int x, int y, int id){
	if(playGame){
		game.touchDoubleTap(x, y, id);
	} else {
		//instructions.touchDoubleTap(x, y, id);
	}
}

//--------------------------------------------------------------
void testApp::lostFocus() {
	game.lostFocus();
}

//--------------------------------------------------------------
void testApp::gotFocus() {
	game.gotFocus();
}

//--------------------------------------------------------------
void testApp::gotMemoryWarning() {
	game.gotMemoryWarning();
}

//--------------------------------------------------------------
void testApp::deviceOrientationChanged(int newOrientation){
	game.deviceOrientationChanged(newOrientation);
}