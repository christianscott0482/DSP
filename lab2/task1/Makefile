TARGET = ece486_fir_test
CC = gcc
CFLAGS = -g -Wall
OBJS = ece486_fir_test.o ece486_fir.o
SRC = ece486_fir_test.c ece486_fir.c

$(TARGET): $(SRC)
	$(CC) $(CFLAGS) -o $(TARGET) $(SRC) -lm

clean:
	rm -rf $(OBJS) $(TARGET)
