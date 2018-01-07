function out1 = dynamics_K(in1)
%DYNAMICS_K
%    OUT1 = DYNAMICS_K(IN1)

%    This function was generated by the Symbolic Math Toolbox version 7.1.
%    07-Jan-2018 17:18:44

g = in1(23,:);
l_L = in1(20,:);
m_L = in1(21,:);
m_Q = in1(22,:);
p_S_B_1 = in1(24,:);
p_S_B_2 = in1(25,:);
p_S_B_3 = in1(26,:);
phi_L = in1(7,:);
phi_Q = in1(4,:);
theta_L = in1(8,:);
theta_Q = in1(5,:);
t2 = cos(theta_Q);
t3 = cos(phi_Q);
t4 = sin(phi_Q);
t5 = sin(theta_Q);
out1 = [0.0;0.0;-g.*(m_L+m_Q);-g.*m_L.*t2.*(p_S_B_2.*t3-p_S_B_3.*t4);g.*m_L.*(p_S_B_1.*t2+p_S_B_2.*t4.*t5+p_S_B_3.*t3.*t5);0.0;g.*l_L.*m_L.*cos(theta_L).*sin(phi_L);g.*l_L.*m_L.*cos(phi_L).*sin(theta_L)];
