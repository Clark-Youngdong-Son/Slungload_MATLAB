function output = position_controller_PID(input)

n = 16;
x_now = input(1:n);
x_des = input(n+1:2*n);

xyz_now = x_now(1:3);
xyz_dot_now = x_now(9:11);
xyz_des = x_des(1:3);
xyz_dot_des = x_des(9:11);

xyz_error = xyz_now - xyz_des;
xyz_dot_error = xyz_dot_now - xyz_dot_des;

K_p = diag([1 1 1]);
K_d = diag([0.1 0.1 0.1]);
yaw_control = true;    %Yaw is controlled to see the deisred direction
yaw_control = false;   %Yaw is maintained constantly

acceleration_des = K_p*xyz_error + K_d*xyz_dot_error;

output(1:3) = attitude_des;
output(4)   = thrust_des;

end