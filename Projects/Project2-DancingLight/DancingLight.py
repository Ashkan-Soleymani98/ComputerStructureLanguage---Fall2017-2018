import RPi.GPIO as GPIO
import time

GPIO.setwarnings(False)

ledPins = [2, 3, 4, 17, 27, 22]

def setup():
    GPIO.setmode(GPIO.BCM)
    for i in range (0, 6):
        GPIO.setup(ledPins[i], GPIO.OUT)
        GPIO.output(ledPins[i], GPIO.LOW)
        
        
def loop():
    while True:
        for i in range (0, 6):
            for j in range (0, 6):
                for k in range (0, i):
                    GPIO.output(ledPins[(j + k)%6], GPIO.HIGH)
                time.sleep(0.5)
                for k in range (0, i):
                    GPIO.output(ledPins[(j + k)%6], GPIO.LOW)
def destroy():
    for i in range (0, 6):
        GPIO.output(ledPins[i], GPIO.LOW)
    
if __name__ == '__main__':
    setup()
    try:
        loop()
    except KeyboardInterrupt:
        destroy()