#ifndef _ROS_SERVICE_StopArduino_h
#define _ROS_SERVICE_StopArduino_h
#include <stdint.h>
#include <string.h>
#include <stdlib.h>
#include "ros/msg.h"

namespace chusa_msgs
{

static const char STOPARDUINO[] = "chusa_msgs/StopArduino";

  class StopArduinoRequest : public ros::Msg
  {
    public:
      typedef bool _tx_signal_type;
      _tx_signal_type tx_signal;

    StopArduinoRequest():
      tx_signal(0)
    {
    }

    virtual int serialize(unsigned char *outbuffer) const
    {
      int offset = 0;
      union {
        bool real;
        uint8_t base;
      } u_tx_signal;
      u_tx_signal.real = this->tx_signal;
      *(outbuffer + offset + 0) = (u_tx_signal.base >> (8 * 0)) & 0xFF;
      offset += sizeof(this->tx_signal);
      return offset;
    }

    virtual int deserialize(unsigned char *inbuffer)
    {
      int offset = 0;
      union {
        bool real;
        uint8_t base;
      } u_tx_signal;
      u_tx_signal.base = 0;
      u_tx_signal.base |= ((uint8_t) (*(inbuffer + offset + 0))) << (8 * 0);
      this->tx_signal = u_tx_signal.real;
      offset += sizeof(this->tx_signal);
     return offset;
    }

    const char * getType(){ return STOPARDUINO; };
    const char * getMD5(){ return "fceae370fe7a9001d381957f0e8b868e"; };

  };

  class StopArduinoResponse : public ros::Msg
  {
    public:
      typedef bool _rx_signal_type;
      _rx_signal_type rx_signal;

    StopArduinoResponse():
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

    const char * getType(){ return STOPARDUINO; };
    const char * getMD5(){ return "b681db55aabf43c10d03f94a707c66ee"; };

  };

  class StopArduino {
    public:
    typedef StopArduinoRequest Request;
    typedef StopArduinoResponse Response;
  };

}
#endif
