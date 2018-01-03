%% Parameters for simulation
clear all;
n = 16;                   %Number of the state
m = 4;                    %Number of the input
g = 9.81;                 %Gravitational accelerational of Earth

m_Q = 1.0;                %Mass of the multi-rotor
m_L = 0.1;                %Mass of the load
l_L = 1.0;                %Length of the cable

Ix = 0.1;                 %Moments of inertia of the multi-rotor
Iy = 0.1;
Iz = 0.05;
I_Q = [Ix Iy Iz].';

p_S_B = zeros(3,1);       %Displacement of suspension
% p_S_B(1) = 0.1;
% p_S_B(2) = 0.1;
% p_S_B(3) = 0.1;

x0 = zeros(n,1);          %Initial state
x0_position = x0(1:n/2);
x0_velocity = x0(n/2+1:n);

xf = zeros(n,1);          %Final desired state
xf(1:3,1) = [1 0 0].';