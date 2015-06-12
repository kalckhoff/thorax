clear s a;
MAX = 0.99; %negative Auslenkung - nach links  (ca. 180°)
MIN = 0.01; %Positive Auslenkung - nach rechts (ca. 0°)

a = arduino('/dev/tty.usbmodem1421', 'uno', 'Libraries', 'Servo');
%s = servo(a, 'D9');
clear s;
s = servo(a, 'D9', 'MinPulseDuration', 700*10^-6, 'MaxPulseDuration', 2300*10^-6);
angle=0;
writePosition(s, angle);
pause(2);
i = 1;
  k=1;
%% Ausatmung
comment='s';
while comment ~= 'q'
      
      comment=input('s');

    while angle < MAX
       writePosition(s, angle);
       current_pos = readPosition(s);
       current_pos = current_pos*180;
       %current_pos = roundn(current_pos,-2);
       fprintf('Current motor position is %d degrees\n', current_pos);
       angle = angle + 0.1;
       pause(0.01);
    end
pause(1);

%% Einatmung
    while angle > MIN
       writePosition(s, angle);
       current_pos = readPosition(s);
       current_pos = current_pos*180;
       fprintf('Current motor position is %d degrees\n', current_pos);
       angle =angle - 0.1;
       pause(0.012);
    end
    
    i = i+1;
end
pause(3);
clear s a;