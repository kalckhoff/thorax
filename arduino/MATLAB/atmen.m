function atmen(T_atemzyklus,max_auslenkung)

clear s a;
MAX_angel = 0.99; %negative Auslenkung - nach links  (ca. 180°)
MIN_angel = 0.01; %Positive Auslenkung - nach rechts (ca. 0°)

a = arduino('/dev/tty.usbmodem1421', 'uno', 'Libraries', 'Servo');
%s = servo(a, 'D9');
clear s;
s = servo(a, 'D9', 'MinPulseDuration', 700*10^-6, 'MaxPulseDuration', 2300*10^-6);
angle=0;
writePosition(s, angle);
pause(2);
% Beispiel
T_atemzyklus=10; %Sekunden
max_auslenkung=5; %übergebene Auslenkung der Atmung in cm

% max_auslenkung_torso entspricht MAX_angle
max_auslenkung_phantom=10; %maximal mögliche Auslenkung des Torso in cm
einzustellender_angel=max_auslenkung/max_auslenkung_phantom;
angle_steps= einzustellender_angel/0.1;
time=angle_steps/T_atemzyklus;


    while current_angle < einzustellender_angel
       writePosition(s, angle);
       current_pos = readPosition(s);
       current_pos = current_pos*180;
       %current_pos = roundn(current_pos,-2);
       fprintf('Current motor position is %d degrees\n', current_pos);
       angle = angle + 0.1; %fest
       pause(time);
    end


