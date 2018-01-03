function output = attitude_controller_PID(input)

n = 16;
x_now = input(1:n);
attitude_des = input(n+1:n+3);

K_p = diag([1 1 0.0]);
K_d = diag([0.2 0.2 0.0]);
maxTorque = [1 1 0.3].';

attitude_now = x_now(4:6);
attitude_dot_now = x_now(12:14);

attitude_error = attitude_des - attitude_now;
attitude_dot_error = zeros(3,1) - attitude_dot_now;

torque = K_p*attitude_error + K_d*attitude_dot_error;

for i=1:3
%    if(torque(i) > maxTorque(i))
%        torque(i) = maxTorque(i);
%    elseif(torque(i) < -maxTorque(i))
%        torque(i) = -maxTorque(i);
%    end
end

output = [torque; attitude_des];
end