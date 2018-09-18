TARGET = testing
CC = gcc
CFLAGS = -g -Wall -lm
OBJS = testing.o ece486_IQ_mixer.o
SRC = testing.c ece486_IQ_mixer.c

$(TARGET): $(SRC)
	        $(CC) $(CFLAGS) -o $(TARGET) $(SRC) -lm

clean:
	        rm -rf $(OBJS) $(TARGET)
