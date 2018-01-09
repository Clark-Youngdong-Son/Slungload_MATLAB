function y = computeDynamics(u)

n = 16;
X = u(1:n);
x = X(1:n/2);
x_dot = X(n/2+1:n);
M = reshape(u(n+1:n+(n/2)^2),[n/2 n/2]);
C = reshape(u(n+(n/2)^2+1:n+2*(n/2)^2),[n/2 n/2]);
K = u(n+2*(n/2)^2+1:n+2*(n/2)^2+(n/2));
U = u(n+2*(n/2)^2+(n/2)+1:n+2*(n/2)^2+(n/2)+4);
I_Q = diag(u(n+2*(n/2)^2+(n/2)+5:n+2*(n/2)^2+(n/2)+7));

phi_Q   = x(4);
theta_Q = x(5);
psi_Q   = x(6);
phi_Q_dot = x_dot(4);
theta_Q_dot = x_dot(4);
psi_Q_dot = x_dot(4);

rotX = [1       0          0;
    0 cos(phi_Q) -sin(phi_Q);
    0 sin(phi_Q)  cos(phi_Q)];
rotY = [cos(theta_Q)   0 sin(theta_Q);
    0            1          0;
    -sin(theta_Q)  0 cos(theta_Q)];
rotZ = [cos(psi_Q) -sin(psi_Q) 0;
    sin(psi_Q)  cos(psi_Q) 0;
    0         0 1];
R_IB = rotZ*rotY*rotX;                  %multi-rotor rotation matrix (coordinate I->B: x_Q_I = R_Q_IB*x_Q_B)

T = [1 0 -sin(theta_Q);
     0 cos(phi_Q) sin(phi_Q)*cos(theta_Q);
     0 -sin(phi_Q) cos(phi_Q)];
input_transform_thrust = R_IB*[0 0 U(1)].';
input_transform_moment = T*U(2:4);

% input_transform_moment = [1             sin(phi_Q)*tan(theta_Q)  cos(phi_Q)*tan(theta_Q);
%                           cos(phi_Q)    0                       -sin(phi_Q);
%                           0             sin(phi_Q)*sec(theta_Q)  cos(phi_Q)*sec(theta_Q)]*U(2:4);
%TODO: acceleration relationship must be comptued in detail
                      
% y = M\([input_transform_thrust; rpy_ddot; 0; 0] - C*x_dot - K);
y = M\([input_transform_thrust; input_transform_moment; 0; 0] - C*x_dot - K);
if(sum(isnan(y))==n/2)
   y = zeros(n/2,1); 
end
