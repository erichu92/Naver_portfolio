#include <ros.h>
#include <Arduino.h>
#include <ArduinoHardware.h>
#include <math.h>
#include <geometry_msgs/Twist.h>
#include <chusa_msgs/StartArduino.h>
#include <chusa_msgs/StopArduino.h>

#define R_PWM 9
#define R_FORW 8
#define R_BACK 7
#define L_PWM 3
#define L_FORW 4
#define L_BACK 2

// var
unsigned char min_pwm = 0;
unsigned char max_pwm = 0;
float min_vel = 0;
float max_vel = 0;
bool turn_on = false;
float a = 0;

// functions
void setupPins();
void stop();
unsigned char readPWM(float vel);
void left_wheel(bool forw, unsigned char pwm);
void right_wheel(bool forw, unsigned char pwm);
void startSrvCb(const chusa_msgs::StartArduino::Request& req, chusa_msgs::StartArduino::Response& res);
void stopSrvCb(const chusa_msgs::StopArduino::Request& req, chusa_msgs::StopArduino::Response& res);
void msgCallback(const geometry_msgs::Twist &msg);

void setupPins(){
  pinMode(LED_BUILTIN, OUTPUT);
  pinMode(R_PWM, OUTPUT);
  pinMode(R_FORW, OUTPUT);
  pinMode(R_BACK, OUTPUT);
  pinMode(L_PWM, OUTPUT);
  pinMode(L_FORW, OUTPUT);
  pinMode(L_BACK, OUTPUT);
  stop();
}

void stop()
{
  digitalWrite(LED_BUILTIN, 0);
  digitalWrite(R_FORW, 0);
  digitalWrite(R_BACK, 0);
  digitalWrite(L_FORW, 0);
  digitalWrite(L_BACK, 0);
  analogWrite(R_PWM, 0);
  analogWrite(L_PWM, 0);
}

unsigned char readPWM(float vel){
  // linear interpolation
  float t = a * (vel - min_vel) + (float)min_pwm;
  return (byte)t;
}

void left_wheel(bool forw, unsigned char pwm){
  if(pwm == 0){
    analogWrite(L_PWM, 0);
  }
  else{
    if(forw){
      digitalWrite(L_FORW, HIGH);
      digitalWrite(L_BACK, LOW);
    }
    else{
      digitalWrite(L_FORW, LOW);
      digitalWrite(L_BACK, HIGH);
    }
    analogWrite(L_PWM, pwm);
  }
}

void right_wheel(bool forw, unsigned char pwm){
  if(pwm == 0){
    analogWrite(R_PWM, 0);
  }
  else{
    if(forw){
      digitalWrite(R_FORW, HIGH);
      digitalWrite(R_BACK, LOW);
    }
    else{
      digitalWrite(R_FORW, LOW);
      digitalWrite(R_BACK, HIGH);
    }
    analogWrite(R_PWM, pwm);
  }
}

// service callback
void startSrvCb(const chusa_msgs::StartArduino::Request& req, chusa_msgs::StartArduino::Response& res){
  min_pwm = req.min_pwm;
  max_pwm = req.max_pwm;
  min_vel = req.min_velocity;
  max_vel = req.max_velocity;
  float t = (float)(req.max_pwm - req.min_pwm);
  a = t/(req.max_velocity - req.min_velocity);
  turn_on = true;
  digitalWrite(LED_BUILTIN, HIGH);
  res.rx_signal = true;
}

void stopSrvCb(const chusa_msgs::StopArduino::Request& req, chusa_msgs::StopArduino::Response& res){
  if(req.tx_signal){
    turn_on = false;
    stop();
    res.rx_signal = true;
  }
  else{
    res.rx_signal = false;
  }
}

// message callback
void velMsgCb(const geometry_msgs::Twist& msg){
  float left_vel = msg.linear.x + msg.angular.z * 0.125 / 2;
  float right_vel = msg.linear.x - msg.angular.z * 0.125 / 2;
  unsigned char left_pwm = 0;
  unsigned char right_pwm = 0;

  // main control
  if(left_vel > 0){
    if(left_vel > min_vel){
      left_pwm = readPWM(min(left_vel,max_vel));
      left_wheel(true, left_pwm);
    }
    else{
      left_wheel(true, 0);
    }
  }
  else{
    if(left_vel < -min_vel){
      left_pwm = readPWM(fabs(max(left_vel,-max_vel)));
      left_wheel(false, left_pwm);
    }
    else{
      left_wheel(false, 0);
    }
  }
  if(right_vel > 0){
    if(right_vel > min_vel){
      right_pwm = readPWM(min(right_vel,max_vel));
      right_wheel(true, right_pwm);
    }
    else{
      right_wheel(true, 0);
    }
  }
  else{
    if(right_vel < -min_vel){
      right_pwm = readPWM(fabs(max(right_vel,-max_vel)));
      right_wheel(false, right_pwm);
    }
    else{
      right_wheel(false, 0);
    }
  }
}


ros::NodeHandle nh;

ros::ServiceServer<chusa_msgs::StartArduino::Request, chusa_msgs::StartArduino::Response> 
start_server("startArd", &startSrvCb);
ros::ServiceServer<chusa_msgs::StopArduino::Request, chusa_msgs::StopArduino::Response> 
stop_server("stopArd", &stopSrvCb);
ros::Subscriber<geometry_msgs::Twist> vel_sub("/cmd_vel", velMsgCb );

void setup() {
  Serial.begin(9600);
  setupPins();
  nh.initNode();
  nh.advertiseService(start_server);
  nh.advertiseService(stop_server);
  nh.subscribe(vel_sub);
  
}

void loop() {
  if(turn_on){
    nh.spinOnce();
    delay(10);
  }
  else{
    nh.spinOnce();
    delay(1000);
  }
}
