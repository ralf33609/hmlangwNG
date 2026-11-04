CXX	= g++

#CXXFLAGS	= -O2 -Wall -Wno-deprecated
CXXFLAGS	= -O2 -pipe -Wall
#CXXFLAGS	= -Wall -O2 -pipe -march=armv6j -mtune=arm1176jzf-s -mfpu=vfp -mfloat-abi=hard

all: hmlangwng

hmlangwng:	hmlangwng.o hmframe.o
	$(CXX) -o hmlangwng hmlangwng.o hmframe.o -lpthread
    
.cpp.o:
	$(CXX) -c $(CXXFLAGS) $<

hmlangwng.o: hmlangwng.cpp hmframe.h
hmframe.o:  hmframe.cpp hmframe.h

clean:
	rm -f hmlangwng *.o

.PHONY: all clean
