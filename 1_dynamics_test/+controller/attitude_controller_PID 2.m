function output = attitude_controller_PID(input)
persistent attitude_error_int;
if isempty(attitude_error_int)
    attitude_error_int = zeros(3,1);
end
n = 16;
x_now = input(1:n);
attitude_des = input(n+1:n+3);

K_p = diag([5 5 3]);
K_i = diag([0.03 0.03 0.01]);
K_d = diag([0.5 0.5 0.3]);

maxTorque = [0.3 0.3 0.1].';

attitude_now = x_now(4:6);
attitude_dot_now = x_now(12:14);

attitude_error = attitude_des - attitude_now;
attitude_dot_error = zeros(3,1) - attitude_dot_now;
attitude_error_int = attitude_error_int + attitude_error;

torque = K_p*attitude_error + K_i*attitude_error_int + K_d*attitude_dot_error;
% torque(3) = 0;
for i=1:3
   if(torque(i) > maxTorque(i))
       torque(i) = maxTorque(i);
   elseif(torque(i) < -maxTorque(i))
       torque(i) = -maxTorque(i);
   end
end

output = [torque; attitude_des];
end