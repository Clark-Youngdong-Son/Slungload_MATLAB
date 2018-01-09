xyz = state.Data(:,1:3).';
rpy = state.Data(:,4:6).';
swing = state.Data(:,7:8).';

xyz_dot = state.Data(:,9:11).';
rpy_dot = state.Data(:,12:14).';
swing_dot = state.Data(:,15:16).';

rpy_des = state_des.Data(:,1:3).';

Input = input.Data(:,1:4).';

dt = 0.01;
t = state.Time;
step = 10;
vid = VideoWriter('animation.avi');
vid.Quality = 50;
vid.FrameRate = 1/dt/step;
open(vid);

loadSize = 0.1;
suspensionColor = [0 0 1];
cableColor = [0 0 0];
loadColor = [0.1 0.1 0.1];

figure(111);
set(gcf,'Color',[1 1 1]);
set(gcf,'Position',[1 41 1920 963]);
for i=1:step:length(t)
    figure(111);
    subplot(1,2,1);
    h1 = drawRotor_syd(xyz(:,i),rpy(:,i),[0 0 0]);
    h2 = drawSuspensionCableLoad(xyz(:,i),rpy(:,i),swing(:,i),l_L,p_S_B,...
        loadSize,suspensionColor,cableColor,loadColor);
    plot3(xf(1),xf(2),-xf(3),'or','MarkerFaceColor','r','MarkerSize',3);
    grid on;
    xlabel('x(m)');
    ylabel('y(m)');
    zlabel('altitude(m)');
    view([0 90]);

    axis equal; grid on;
    xlim([-3 3]);
    ylim([-3 3]);
    zlim([-3 3]);
    
    subplot(1,2,2);
    h3 = drawRotor_syd(xyz(:,i),rpy(:,i),[0 0 0]);
    h4 = drawSuspensionCableLoad(xyz(:,i),rpy(:,i),swing(:,i),l_L,p_S_B,...
        loadSize,suspensionColor,cableColor,loadColor);
    plot3(xf(1),xf(2),-xf(3),'or','MarkerFaceColor','r','MarkerSize',4);
    grid on;
    xlabel('x(m)');
    ylabel('y(m)');
    zlabel('altitude(m)');
    view([0 0]);
    
    axis equal; grid on;
    xlim([-3 3]);
    ylim([-3 3]);
    zlim([-3 3]);
    
    
    suptitle(['time : ' num2str(dt*i) '/' num2str(t(end)) ' second']);
    drawnow;
    writeVideo(vid,getframe(gcf));
    delete(h1);
    delete(h2);
    delete(h3);
    delete(h4);
end
close(vid);