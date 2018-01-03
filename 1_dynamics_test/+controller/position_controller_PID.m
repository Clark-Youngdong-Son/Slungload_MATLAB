function output = position_controller_PID(input)

n = 16;
x_now = input(1:n);
x_des = input(n+1:2*n);
m_Q = input(2*n+1);
m_L = input(2*n+2);
g = input(2*n+3);

xyz_now = x_now(1:3);
xyz_dot_now = x_now(9:11);
xyz_des = x_des(1:3);
xyz_dot_des = x_des(9:11);

xyz_error = xyz_des - xyz_now;
xyz_dot_error = xyz_dot_des - xyz_dot_now;

maxThrust = -2*(m_Q+m_L)*g;
minThrust = -0.1*(m_Q+m_L)*g;
K_p = diag([3 3 7]);
K_d = diag([0.3 0.3 2.7]);
% yaw_control = true;    %Yaw is controlled to see the deisred direction
yaw_control = false;   %Yaw is maintained constantly
maxRollPitch = deg2rad(30);

acceleration_des = K_p*xyz_error + K_d*xyz_dot_error - [0 0 g].';

thrust_des = (m_Q+m_L)*(acceleration_des(3));
thrust_des(thrust_des<maxThrust) = maxThrust;
thrust_des(thrust_des>minThrust) = minThrust;

psi_now = x_now(6);
rollPitch_des = [ cos(psi_now) sin(psi_now);
                 -sin(psi_now) cos(psi_now)]*[acceleration_des(2); -acceleration_des(1)];
for i=1:2
%     if(rollPitch_des(i) > maxRollPitch)
%         rollPitch_des(i) = maxRollPitch;
%     elseif(rollPitch_des(i) < -maxRollPitch)
%         rollPitch_des(i) = -maxRollPitch;
%     end
    if(isnan(rollPitch_des(i)))
        rollPitch_des(i) = 0;
    end
end

if(yaw_control)
    yaw_des = atan(xyz_error(2)/xyz_error(1));
else
    yaw_des = psi_now;
end

output = zeros(4,1);

output(1)   = thrust_des;
output(2:4) = [rollPitch_des; yaw_des];

end