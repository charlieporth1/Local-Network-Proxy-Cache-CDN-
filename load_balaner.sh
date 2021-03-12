#!/bin/bash
# This script is for if you have another Raspberry Pi, a couple of them, or you can use mutiple Raspberry Pi on other Ports
# You will need a load balerner raspberry pi to handle all of the connections coming in
iptables -t nat -A PREROUTING -m tcp -p tcp --dport 3128 -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT

# 4/4 chance of trying this rule * 0.25 chance of matching = 0.25
iptables -t nat -A PREROUTING -p tcp -m statistic --mode random \
         --probability 0.25 -m tcp --dport 3128 -j REDIRECT --to-ports 3129

# 3/4 chance of trying this rule * 0.33 chance of matching = 0.25
iptables -t nat -A PREROUTING -p tcp -m statistic --mode random \
         --probability 0.25 -m tcp --dport 3128 -j REDIRECT --to-ports 3130

# 2/4 chance of trying this rule * 0.5 chance of matching = 0.25
iptables -t nat -A PREROUTING -p tcp -m statistic --mode random \
         --probability 0.25 -m tcp --dport 3128 -j REDIRECT --to-ports 3131

# 1/4 chance of trying this rule * 1.0 chance of matching = 0.25
# let these go through to port 3128
