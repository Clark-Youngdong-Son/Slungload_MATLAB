xyz = state.Data(:,1:3).';
rpy = state.Data(:,4:6).';
swing = state.Data(:,7:8).';

xyz_dot = state.Data(:,9:11).';
rpy_dot = state.Data(:,12:14).';
swing_dot = state.Data(:,15:16).';

rpy_des = state_des.Data(:,1:3).';

Input = input.Data(:,1:4).';

t = state.Time;

close all;

figure(1);
ylabels = {'$$x(m)$$', '$$y(m)$$', '$$z(m)$$'};
for i=1:3
    subplot(3,2,2*(i-1)+1); plot(t,xyz(i,:),'-'); hold on; grid on; ylabel(ylabels{i},'Interpreter','latex');
    subplot(3,2,2*(i-1)+1); plot([t(1) t(end)],[xf(i) xf(i)],'-r');
end
xlabel('time(s)');

ylabels = {'$$\dot{x}(m/s)$$', '$$\dot{y}(m/s)$$', '$$\dot{z}(m/s)$$'};
for i=1:3
    subplot(3,2,2*i); plot(t,xyz_dot(i,:),'-'); hold on; grid on; ylabel(ylabels{i},'Interpreter','latex');
end
xlabel('time(s)');


figure(2);
ylabels = {'$$\phi_Q(deg)$$', '$$\theta_Q(deg)$$', '$$\psi_Q(deg)$$'};
for i=1:3
    subplot(3,2,2*(i-1)+1); plot(t,rad2deg(rpy(i,:)),'-'); hold on; grid on; ylabel(ylabels{i},'Interpreter','latex');
    subplot(3,2,2*(i-1)+1); plot(t,rad2deg(rpy_des(i,:)),'-r');
end
xlabel('time(s)');

ylabels = {'$$\dot{\phi_Q}(deg/s)$$', '$$\dot{\theta_Q}(deg/s)$$', '$$\dot{\psi_Q}(deg/s)$$'};
for i=1:3
    subplot(3,2,2*i); plot(t,rad2deg(rpy_dot(i,:)),'-'); hold on; grid on; ylabel(ylabels{i},'Interpreter','latex');
end
xlabel('time(s)');

figure(3);
ylabels = {'$$\phi_L(deg)$$', '$$\theta_L(deg)$$'};
for i=1:2
    subplot(2,2,2*(i-1)+1); plot(t,rad2deg(swing(i,:)),'-'); hold on; grid on; ylabel(ylabels{i},'Interpreter','latex');
end
xlabel('time(s)');

ylabels = {'$$\dot{\phi_L(deg)}$$', '$$\dot{\theta_L(deg)}$$'};
for i=1:2
    subplot(2,2,2*i); plot(t,rad2deg(swing_dot(i,:)),'-'); hold on; grid on; ylabel(ylabels{i},'Interpreter','latex');
end
xlabel('time(s)');

figure(4);
ylabels = {'$$thrust(N)$$', '$$M_x(N\cdot m)$$', '$$M_y(N\cdot m)$$', '$$M_z(N\cdot m)$$'};
for i=1:4
    subplot(4,1,i); plot(t,Input(i,:),'-'); hold on; grid on; ylabel(ylabels{i},'Interpreter','latex');
end
xlabel('time(s)');

autoArrangeFigures(2,2,2);