#ifndef _ROS_SERVICE_StartArduino_h
#define _ROS_SERVICE_StartArduino_h
#include <stdint.h>
#include <string.h>
#include <stdlib.h>
#include "ros/msg.h"

namespace chusa_msgs
{

static const char STARTARDUINO[] = "chusa_msgs/StartArduino";

  class StartArduinoRequest : public ros::Msg
  {
    public:
      typedef uint8_t _min_pwm_type;
      _min_pwm_type min_pwm;
      typedef uint8_t _max_pwm_type;
      _max_pwm_type max_pwm;
      typedef float _min_velocity_type;
      _min_velocity_type min_velocity;
      typedef float _max_velocity_type;
      _max_velocity_type max_velocity;

    StartArduinoRequest():
      min_pwm(0),
      max_pwm(0),
      min_velocity(0),
      max_velocity(0)
    {
    }

    virtual int serialize(unsigned char *outbuffer) const
    {
      int offset = 0;
      *(outbuffer + offset + 0) = (this->min_pwm >> (8 * 0)) & 0xFF;
      offset += sizeof(this->min_pwm);
      *(outbuffer + offset + 0) = (this->max_pwm >> (8 * 0)) & 0xFF;
      offset += sizeof(this->max_pwm);
      union {
        float real;
        uint32_t base;
      } u_min_velocity;
      u_min_velocity.real = this->min_velocity;
      *(outbuffer + offset + 0) = (u_min_velocity.base >> (8 * 0)) & 0xFF;
      *(outbuffer + offset + 1) = (u_min_velocity.base >> (8 * 1)) & 0xFF;
      *(outbuffer + offset + 2) = (u_min_velocity.base >> (8 * 2)) & 0xFF;
      *(outbuffer + offset + 3) = (u_min_velocity.base >> (8 * 3)) & 0xFF;
      offset += sizeof(this->min_velocity);
      union {
        float real;
        uint32_t base;
      } u_max_velocity;
      u_max_velocity.real = this->max_velocity;
      *(outbuffer + offset + 0) = (u_max_velocity.base >> (8 * 0)) & 0xFF;
      *(outbuffer + offset + 1) = (u_max_velocity.base >> (8 * 1)) & 0xFF;
      *(outbuffer + offset + 2) = (u_max_velocity.base >> (8 * 2)) & 0xFF;
      *(outbuffer + offset + 3) = (u_max_velocity.base >> (8 * 3)) & 0xFF;
      offset += sizeof(this->max_velocity);
      return offset;
    }

    virtual int deserialize(unsigned char *inbuffer)
    {
      int offset = 0;
      this->min_pwm =  ((uint8_t) (*(inbuffer + offset)));
      offset += sizeof(this->min_pwm);
      this->max_pwm =  ((uint8_t) (*(inbuffer + offset)));
      offset += sizeof(this->max_pwm);
      union {
        float real;
        uint32_t base;
      } u_min_velocity;
      u_min_velocity.base = 0;
      u_min_velocity.base |= ((uint32_t) (*(inbuffer + offset + 0))) << (8 * 0);
      u_min_velocity.base |= ((uint32_t) (*(inbuffer + offset + 1))) << (8 * 1);
      u_min_velocity.base |= ((uint32_t) (*(inbuffer + offset + 2))) << (8 * 2);
      u_min_velocity.base |= ((uint32_t) (*(inbuffer + offset + 3))) << (8 * 3);
      this->min_velocity = u_min_velocity.real;
      offset += sizeof(this->min_velocity);
      union {
        float real;
        uint32_t base;
      } u_max_velocity;
      u_max_velocity.base = 0;
      u_max_velocity.base |= ((uint32_t) (*(inbuffer + offset + 0))) << (8 * 0);
      u_max_velocity.base |= ((uint32_t) (*(inbuffer + offset + 1))) << (8 * 1);
      u_max_velocity.base |= ((uint32_t) (*(inbuffer + offset + 2))) << (8 * 2);
      u_max_velocity.base |= ((uint32_t) (*(inbuffer + offset + 3))) << (8 * 3);
      this->max_velocity = u_max_velocity.real;
      offset += sizeof(this->max_velocity);
     return offset;
    }

    const char * getType(){ return STARTARDUINO; };
    const char * getMD5(){ return "cd9153f2e7177a076039c36fa7c73a0c"; };

  };

  class StartArduinoResponse : public ros::Msg
  {
    public:
      typedef bool _rx_signal_type;
      _rx_signal_type rx_signal;

    StartArduinoResponse():
      rx_signal(0)
    {
    }

    virtual int serialize(unsigned char *outbuffer) const
    {
      int offset = 0;
      union {
        bool real;
        uint8_t base;
      } u_rx_signal;
      u_rx_signal.real = this->rx_signal;
      *(outbuffer + offset + 0) = (u_rx_signal.base >> (8 * 0)) & 0xFF;
      offset += sizeof(this->rx_signal);
      return offset;
    }

    virtual int deserialize(unsigned char *inbuffer)
    {
      int offset = 0;
      union {
        bool real;
        uint8_t base;
      } u_rx_signal;
      u_rx_signal.base = 0;
      u_rx_signal.base |= ((uint8_t) (*(inbuffer + offset + 0))) << (8 * 0);
      this->rx_signal = u_rx_signal.real;
      offset += sizeof(this->rx_signal);
     return offset;
    }

    const char * getType(){ return STARTARDUINO; };
    const char * getMD5(){ return "b681db55aabf43c10d03f94a707c66ee"; };

  };

  class StartArduino {
    public:
    typedef StartArduinoRequest Request;
    typedef StartArduinoResponse Response;
  };

}
#endif
