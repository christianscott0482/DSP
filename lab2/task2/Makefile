TARGET = ece486_biquad_test
CC = gcc
CFLAGS = -g -Wall
LFLAGS = -lm
OBJS = ece486_biquad_test.o ece486_biquad.o
SRC = ece486_biquard_test.c ece486_biquad.c

$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) $^ $(LFLAGS) -o $(TARGET)

$%.o: $%.c
	$(CC) -c $(CFLAGS) $< -o $@

clean:
	rm -rf $(OBJS) $(TARGET)
