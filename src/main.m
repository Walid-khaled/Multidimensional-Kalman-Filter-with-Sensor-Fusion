clear all 
clc
%% 1- get the data from 2 sensors
% read the data
acc_data = xlsread('acc_data.xlsx');
GPS_data = xlsread('GPS_data.xlsx');

% time vector
time = acc_data(:,1);
% get timestamp 
dt = (acc_data(2,1)-acc_data(1,1)) * 1e-3;

% get intial position values from GPS data
xo = GPS_data(1,1);
yo = GPS_data(1,2);

% get gps data in two seprate vectors one for X and one for Y
X_GPS = GPS_data(:,1);
Y_GPS = GPS_data(:,2);

% get linear acc data in two seprate vectors one for X and one for Y
X_acc = acc_data(:,2);
Y_acc = acc_data(:,3);

%% 2- design constant velocity model
% fit line to data using polyfit
c_x = polyfit(time,X_GPS,1);
c_y = polyfit(time,Y_GPS,1);

% fitting x and y models from obtained slope and intercept
x_model = c_x(1).*time + c_x(2);
y_model = c_y(1).*time + c_y(2);
% Display evaluated equation y = m*x + b
fprintf("Evaluated equation x_model = x_slope * t + x_intercept\n");
disp([' x = ' num2str(c_x(1)) '*t + ' num2str(c_x(2))]);
fprintf("Evaluated equation y_model = y_slope * t + y_intercept\n");
disp([' y = ' num2str(c_y(1)) '*t + ' num2str(c_y(2))]);

% now let's plot our fit data the slope will be our v_x
warning('off');
figure;
plot(time,X_GPS,'r',time,x_model,'b');
title('X vs time');
xlabel('time');
ylabel('X from GPS');
legend('GPS','X Model');
grid;

figure;
plot(time,Y_GPS,'r',time,y_model,'b');
title('Y vs time');
xlabel('time');
ylabel('Y from GPS');
legend('GPS','Y Model');
grid;

%x and y velocities for model are
v_x = c_x(1);
v_y = c_y(1);

% create arrays to hold transformation value from accelration to position
vel_x = zeros(length(X_acc),1);
vel_y = zeros(length(Y_acc),1);
X_pos = zeros(length(X_acc),1);
Y_pos = zeros(length(Y_acc),1);

% inital values for velocity and position in X
vel_x(1) = v_x + X_acc(1)*dt;
X_pos(1) = xo + vel_x(1)*dt;

% inital values for velocity and position Y
vel_y(1) = v_y + Y_acc(1)*dt;
Y_pos(1) = yo + vel_y(1)*dt;

for i = 2:length(X_acc)
    vel_x(i) = vel_x(i-1) + X_acc(i-1)*dt;
    X_pos(i) = X_pos(i-1) + vel_x(i)*dt;

    vel_y(i) = vel_y(i-1) + Y_acc(i-1)*dt;
    Y_pos(i) = Y_pos(i-1) + vel_y(i)*dt;
end

%% 3- design matrices Phi , Q , H , R , P
phi= [1 dt 0 0; 
      0 1 0 0;
      0 0 1 dt;
      0 0 0 1];

Q=   [1 0 0 0; 
      0 1 0 0;
      0 0 1 0;
      0 0 0 1];
  
H=   [1 0 0 0; 
      1 0 0 0;
      0 0 1 0;
      0 0 1 0];

R=   [25 0 0 0; 
      0 400 0 0;
      0 0 25 0;
      0 0 0 400];
  
   
P=   [200 0 0 0; 
      0 200 0 0;
      0 0 200 0;
      0 0 0 200];

%% 4- Kalman filter loop

% inital value for X state vector
Xo = [xo; v_x; yo; v_y];
X(:,1) = Xo;

for i=1:length(Y_acc)
   Zk = [X_GPS(i); X_pos(i); Y_GPS(i); Y_pos(i)];
   
   % project ahead
   Xp = phi* X(:,i);
   Pp = phi * P * phi' + Q;
   
   % compute kalman gain 
   K = Pp * H' * inv(H * Pp * H' + R);

   % update step
   X(:,i+1) = Xp + K * (Zk - H * Xp);
   
   % compute error covariance for updated estimate 
   P = (eye(4) - K*H) * Pp * (eye(4) - K*H)' + K* R *K';
   
end

fprintf("\nFinal error covariance matrix P:\n");
disp(P);

%% 5- graphs plotting
figure;
plot(X_GPS,Y_GPS,'g');
hold on;
plot(x_model,y_model,'r');
plot(X_pos,Y_pos,'k');
plot(X(1,:),X(3,:),'b');
title('Plot X and Y of GPS, Fitting Model, Integrated pos from acc, Kalman Filter');
xlabel('X');
ylabel('Y');
legend('GPS','Fitting Model','Integrated pos from acc','Kalman Filter');
grid;
hold off;




